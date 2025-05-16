----
SMODS.Atlas{
    key = "Relic_Myth",
    path = "Relics/Relic_Myth.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Mori Calliope
    member = "Calli",
    key = "Relic_Calli",
    loc_txt = {
        name = "Scythe of the Death Apprentice",
        text = {
            'When played exactly {C:attention}4 {}cards, each card',
            'has {C:green}#3# in #4# {}chance to be {C:attention}converted{}',
            'to the {C:attention}fourth {}card before scoring.',
            'Create a {C:dark_edition}Negative {C:tarot}Death {}card',
            'every {C:attention}#5# {C:inactive}[#6#] {}conversions.',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Death{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={3,2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 1,
        odds = 4,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Guh!',
        },
        count_args = {
            down = 4,
            init = 4
        }
    } },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_death
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                Holo.prob_norm(), cae.odds,
                cae.count_args.init, cae.count_args.down,
            }
        }
    end,
    pools = {
        Relic_Myth = true,
        Relic_EN = true
    },

    atlas = 'Relic_Myth',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_death')
        if context.before and #context.full_hand == 4 and not context.blueprint then
            play_sound('tarot1')
            local rightmost = context.full_hand[4]
            for i, _card in ipairs(context.full_hand) do
                if i == 4 then
                    break
                end
                if Holo.chance('Calli', cae.odds) then
                    local percent = 1.15 - (i-0.999)/(4-0.998)*0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            _card:flip();
                            play_sound('card1', percent);
                            _card:juice_up(0.3, 0.3);
                            delay(0.2)
                            _card:juice_up()
                            return true
                        end
                    }))
                    if holo_card_counting(card) then
                        SMODS.calculate_effect({message="Shin de kudasai!",colour=Holo.C.Calli,},card)
                        SMODS.add_card({ key = 'c_death', area = G.consumeables, edition = 'e_negative' })
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.1,
                        func = function()
                            copy_card(rightmost, _card)
                            return true
                        end
                    }))
                    percent = 0.85 + (i-0.999)/(4-0.998)*0.3
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            _card:flip()
                            play_sound('tarot2', percent, 0.6)
                            _card:juice_up(0.3, 0.3)
                            return true
                        end
                    }))
                end
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = cae.Xmult,
                message='Death!',
                colour=HEX('a1020b'),
            }
        end
    end
}

Holo.Relic_Joker{ -- Takanashi Kiara
    member = "Kiara",
    key = "Relic_Kiara",
    loc_txt = {
        name = "Flaming Sword of the Phoenix",
        text = {
            'Ignite {C:attention}1{V:1} fire charge {C:inactive}(#4#/4)',
            'when the scoring board is {V:1,E:1}on fire{}.',
            'When {C:red}discard{}, spend {C:attention}1{V:1} fire charge',
            'to destroy {C:attention}all{} discarded cards.',
            'Gain {X:mult,C:white}X#2#{} mult per burned discard',
            'and {C:money}$#3#{} per burning card.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={4,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 0.4,
        flame = 0, burn = false,
        dollars = 4,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Kikiriki!'
        },
    } },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.dollars,
                cae.flame,
                colours = {HEX('f8421a')}
            }
        }
    end,
    pools = {
        Relic_Myth = true,
        Relic_EN = true
    },

    atlas = 'Relic_Myth',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.first_hand_drawn then
            local charge = cae.flame
            local eval = function(_c) return _c.ability.extra.flame>0 and G.GAME.facing_blind and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        elseif context.after then
            if hand_chips*mult >= G.GAME.blind.chips and cae.flame < 4 then
                cae.flame = math.min(cae.flame + 1, 4)
            end
        elseif context.pre_discard and not context.blueprint then
            if cae.flame>=1 then
                holo_card_upgrade(card)
                cae.flame = math.max(cae.flame - 1, 0)
                cae.burn = true
            else
                cae.burn = false
            end
        elseif context.discard and cae.burn then
            ease_dollars(cae.dollars)
            return {
                remove = true,
            }
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                message="Phoenix!",
                colour = Holo.C.Kiara,
            }
        end
    end
}

SMODS.Sound{
    key = 'sound_Ina_Wah',
    path = 'Ina_Wah.ogg'
    -- source: https://www.myinstants.com/en/instant/wah-eco-ninomae-inanis-8589/
}

Holo.Relic_Joker{ -- Ninomae Ina'nis
    member = "Ina",
    key = "Relic_Ina",
    loc_txt = {
        name = "Ancient Tome of the Eldritch Priestess",
        text = {
            'Each played card with a {C:purple}purple seal{}',
            'creates a {C:spectral}Spectral{} card when scored.',
            '(If no room, {C:attention}accumulate{} them {C:inactive}[#3#]{} until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:spectral}Spectral{} card used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 2.5, Xmult_mod = 1.25,
        tome_of_spectrals = 0,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'WAH!',
            sound = 'hololive_sound_Ina_Wah'
        },
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        info_queue[#info_queue+1] = {set='Other',key='holo_info_forbiddenSpectrals'}
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.tome_of_spectrals
            }
        }
    end,
    pools = {
        Relic_Myth = true,
        Relic_EN = true
    },

    atlas = 'Relic_Myth',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.set == 'Spectral' and not context.blueprint then
                holo_card_upgrade(card)
            end
        elseif context.individual and context.cardarea == G.play then
            if context.other_card.seal == 'Purple' then
                card.ability.extra.tome_of_spectrals = card.ability.extra.tome_of_spectrals + 1
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = card.ability.extra.Xmult,
                message='Wah!',
                colour=HEX('3f3e69'),
                sound = 'hololive_sound_Ina_Wah',
            }
        end
        -- Release the Spectrals until the consumable slot is full.
        if card.ability.extra.tome_of_spectrals > 0 then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                card.ability.extra.tome_of_spectrals = card.ability.extra.tome_of_spectrals - 1
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        local _spectral = pseudorandom_element(G.P_CENTER_POOLS.Spectral,pseudoseed('ina'))
                        SMODS.add_card({ key = _spectral.key, area = G.consumeables})
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Sound{
    key = 'sound_Gura_A',
    path = 'Gura_A.ogg'
    -- source: https://www.myinstants.com/en/instant/gawr-gura-a-66933/
}

Holo.Relic_Joker{ -- Gawr Gura
    member = "Gura",
    key = "Relic_Gura",
    loc_txt = {
        name = "Trident of the Atlantic Shark",
        text = {
            'Retrigger {C:blue}first {C:attention}3 {}scored cards {C:attention}2{} additional times',
            'if played hand is a {V:1}Straight Flush{}.',
            'Gain {X:mult,C:white}X#2#{} mult every time {V:1}Straight Flush{}',
            'is {C:planet}leveled up{}. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}',
            '{s:0.8}Using a {C:planet,s:0.8}Neptune{s:0.8} levels up {C:attention,s:0.8}Straight Flush {C:blue,s:0.8}2{s:0.8} additional times.',
            '{s:0.8}Using a {C:planet,s:0.8}Jupiter{s:0.8} or a {C:planet,s:0.8}Saturn{s:0.8} also levels up {C:attention,s:0.8}Straight Flush{s:0.8}.'
        }
        ,boxes={2,2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 3, Xmult_mod = 0.3,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'A!',
            sound='hololive_sound_Gura_A',
        },
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_neptune
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                colours = {Holo.C.Gura}
            }
        }
    end,
    pools = {
        Relic_Myth = true,
        Relic_EN = true
    },

    atlas = 'Relic_Myth',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        if context.using_consumeable then
            local _p = context.consumeable.config.center.key
            if _p == 'c_jupiter' or _p == 'c_saturn' or _p == 'c_neptune' then
                update_hand_text(
                    { sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                    {
                        handname=localize('Straight Flush', 'poker_hands'),
                        chips = G.GAME.hands['Straight Flush'].chips,
                        mult = G.GAME.hands['Straight Flush'].mult,
                        level=G.GAME.hands['Straight Flush'].level
                    }
                )
                level_up_hand(card, 'Straight Flush')
                if _p == 'c_neptune' then level_up_hand(card, 'Straight Flush') end
                update_hand_text(
                    { sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                    { mult = 0, chips = 0, handname = '', level = '' }
                )
            end
        elseif context.before and context.scoring_name == 'Straight Flush' then
            return {
                message="A!",
                colour = HEX('5d81c7'),
                sound='hololive_sound_Gura_A'
            }
        elseif context.repetition and context.scoring_name == 'Straight Flush' then
            if #context.scoring_hand < 3 then
                return {}
            end
            local is_first_three = false
            for i=1, 3 do
                if context.other_card == context.scoring_hand[i] then
                    is_first_three = true
                end
            end
            if is_first_three then
                return {
                    message = 'A!',
                    repetitions = 2,
                    card = card,
                    colour = HEX('5d81c7')
                }
            end
        elseif context.joker_main then
            return {
                Xmult=card.ability.extra.Xmult,
                message="Shark!",
                colour = HEX('5d81c7'),
                sound='multhit2'
            }
        elseif context.hololive_level_up_hand == 'Straight Flush' then
            if (context.hololive_level_up_amount > 0) and not context.blueprint then
                holo_card_upgrade(card, context.hololive_level_up_amount)
            end
        end
    end
}

Holo.Relic_Joker{ -- Watson Amelia
    member = "Ame",
    key = "Relic_Ame",
    loc_txt = {
        name = "Magnifying Glass of the Detective",
        text = {
            'Mult gained next hand increases by {X:mult,C:white}X#3#{} mult',
            'per {C:attention}consecutive{} hand played with',
            'at least one scoring {C:attention}face card{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult, gain {X:mult,C:white}X#2#{C:inactive} Mult next hand){}'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0, Xmult_mod_mod = 0.25,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Elementary!',
        }
    } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.Xmult_mod_mod
            }
        }
    end,
    pools = {
        Relic_Myth = true,
        Relic_EN = true
    },

    atlas = 'Relic_Myth',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.after and not context.blueprint then
            card:juice_up()
            local contains_scoring_face_card = false
            for i, _card in ipairs(context.scoring_hand) do
                if _card:is_face() then
                    contains_scoring_face_card = true
                end
            end
            if contains_scoring_face_card then
                card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + card.ability.extra.Xmult_mod_mod
                card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Clues Found!",colour = HEX('f8db92')})
            else
                card.ability.extra.Xmult_mod = 0
                card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Lost the track!",colour = HEX('f8db92')})
            end
            delay(0.2)
            holo_card_upgrade(card)
        elseif context.joker_main then
            card:juice_up()
            play_sound('gong')
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Detective!',colour=HEX('f8db92')})
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

----