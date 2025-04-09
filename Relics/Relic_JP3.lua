----
SMODS.Atlas{
    key = "Relic_Fantasy",
    path = "Relics/Relic_Fantasy.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Usada Pekora
    member = "Pekora",
    key = "Relic_Pekora",
    loc_txt = {
        name = "Slot Machine of the Greedy Rabbit",
        text = {
            'For each {C:attention}Gold Card{} held in hand at {C:attention}end of round{},',
            'pay {C:money}$#3#{} to pull the lever.',
            'Each pull has {C:green}#1# in #2#{} chance to',
            '{C:attention}hit the jackpot{} and gain {C:money}$#4#{},',
            'otherwise raise the prize by {C:money}$#5#{}.',
            '{C:inactive}(Prize resets after each jackpot)',
            '{C:inactive}(Odds {C:green}-1{} per {C:attention}Gold Card{C:inactive} in your {C:attention}full deck{C:inactive})'
        }
        ,boxes={2,3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = {
        extra = {
            odds = 50,
            fee = 1,
            prize = 777,
            prize_mod = 7,
            upgrade_args = {
                scale_var = 'prize',
            }
        }
    },
    get_odds = function(init_odd)
        local _odds = init_odd or 50
        if G.playing_cards then
            for k,v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_gold") then
                    _odds = _odds - 1
                end
                if _odds < 2 then
                    return _odds
                end
            end
        end
        return math.max(_odds,1)
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        return {
            vars = {
                Holo.prob_norm(),
                card.config.center.get_odds(card.ability.extra.odds),
                card.ability.extra.fee,
                card.ability.extra.prize,
                card.ability.extra.prize_mod
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.end_of_round and context.individual then
            if SMODS.has_enhancement(context.other_card, "m_gold") then
                ease_dollars(-cae.fee)
                if Holo.chance('Pekora', card.config.center.get_odds(cae.odds)) then
                    card:juice_up()
                    ease_dollars(cae.prize)
                    cae.prize = 777
                    return {
                        message='JACKPOT!',
                        colour=HEX('7dc4fc'),
                        sound = 'coin2',
                    }
                elseif not context.blueprint then
                    holo_card_upgrade(card)
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Uruha Rushia
    member = "Rushia",
    key = "Relic_Rushia",
    loc_txt = {
        name = "Butterfies of the Necromancer",
        text = {
            'Prevents Death once.',
            '{C:red}self destructs{}',
            'Selling this card spawns',
            '#1# {C:attention}Butterfly Tags{}.'
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        summon = math.floor((os.date('%y%m%d')-220224)/10000)
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_hololive_butterfly
        return {
            vars = {
                card.ability.extra.summon
            }
        }
    end,
    blueprint_compat = false,
    eternal_compat = false,

    atlas = 'Relic_Fantasy',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.game_over then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = localize('k_saved_ex'),
                saved_by_necromancy = true,
                colour = HEX('04e3cb')
            }
        elseif context.selling_self then
            for i=1, card.ability.extra.summon do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        add_tag(Tag('tag_hololive_butterfly'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end
                }))
            end
        end
    end
}

Holo.Relic_Joker{ -- Shiranui Flare
    member = "Flare",
    key = "Relic_Flare",
    loc_txt = {
        name = "Paint Splasher of the Fire Elf",
        text = {
            'Spray {C:attention}Gold{} paint on scored cards',
            'if played hand contains a {C:attention}Two Pair{}.',
            'Each card has {C:green}#3# in #4#{} chance to receive',
            'a {C:attention}Gold seal{} when being spray-painted.',
            'Gain {X:mult,C:white}X#2#{} mult per card sprayed.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 0.25,
        odds = 4,
        upgrade_args = {
            scale_var = 'Xmult',
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_SEALS.Gold
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                Holo.prob_norm(),
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Two Pair']) then
            for k,v in ipairs(context.scoring_hand) do
                if not context.blueprint then
                    v:set_ability(G.P_CENTERS.m_gold, nil, true)
                    holo_card_upgrade(card)
                    SMODS.calculate_effect({message="Painted!",colour = HEX('ff5028')},v)
                end
                if Holo.chance('Flare', card.ability.extra.odds) then
                    v:set_seal('Gold', nil, true)
                end
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

Holo.Relic_Joker{ -- Shirogane Noel
    member = "Noel",
    key = "Relic_Noel",
    loc_txt = {
        name = "Mace of the Silver Knight",
        text = {
            'If played hand contains a {C:attention}Two Pair{},',
            'retrigger all {C:attention}metal cards{} held in hand',
            'once per {C:attention}King{} in scored hand.'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { retriggers = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.retriggers = 0
            if next(context.poker_hands['Two Pair']) then
                for k,v in ipairs(context.scoring_hand) do
                    if v:get_id() == 13 then
                        card.ability.extra.retriggers = card.ability.extra.retriggers + 1
                    end
                end
            end
        elseif context.repetition and context.cardarea == G.hand then
            if next(context.poker_hands['Two Pair']) then
                if SMODS.has_enhancement(context.other_card, "m_gold") or SMODS.has_enhancement(context.other_card, "m_steel") then
                    return {
                        message = 'Knight!',
                        repetitions = card.ability.extra.retriggers,
                        card = card,
                        colour = HEX('aebbc3')
                    }
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Houshou Marine
    member = "Marine",
    key = "Relic_Marine",
    loc_txt = {
        name = "Treasure Box of the Pirate Captain",
        text = {
            'Takes {C:money}$1{} per purchase at the shop.',
            'Gives you back {X:money,C:white}X#1#{} the amount at {C:attention}end of shop{}.',
            '{C:inactive}(Currently {C:money}$#4#{C:inactive} taken)',
            'Multiplier goes up by {X:money,C:white}X#2#{} every {C:attention}17',
            '{C:inactive}[#3#]{} triggered {C:attention}Gold cards{} held in hand.'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Mmult = 2, Mmult_mod = 1,
        count_down = 17, treasure = 0,
        upgrade_args = {
            scale_var = 'Mmult',
            message = 'Ahoy!',
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Mmult,
                card.ability.extra.Mmult_mod,
                card.ability.extra.count_down,
                card.ability.extra.treasure
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, "m_gold") then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = 17
                    holo_card_upgrade(card)
                end
            end
        elseif context.buying_card then
            ease_dollars(-1)
            card.ability.extra.treasure = card.ability.extra.treasure + 1
        elseif context.ending_shop then
            ease_dollars(card.ability.extra.treasure * card.ability.extra.Mmult)
            card.ability.extra.treasure = 0
        end
    end
}

----