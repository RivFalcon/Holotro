----

Holo.Relic_Joker{ -- Ookami Mio
    member = "Mio",
    key = "Relic_Mio",
    loc_txt = {
        name = "Tarot Deck of the Wolf",
        text = {
            'When a {C:tarot}Tarot card{} is used, there is',
            '{C:green}#4# in #5#{} chance to create another {C:tarot}Tarot card{}.',
            '(If no room, {C:attention}accumulate{} them {C:inactive}[#3#]{} until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Tarot card{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.2,
        deck_of_tarots = 0,
        odds = 4,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Mion!'
        }
    }},
    upgrade_func = function(card)
        if Holo.chance('MioTarot',card.ability.extra.odds)then
            card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots + 1
        end
    end,
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.deck_of_tarots,
                Holo.prob_norm(), cae.odds,
            }
        }
    end,

    atlas = 'Relic_Gamers',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.ability.set == 'Tarot' and not context.blueprint then
                holo_card_upgrade(card)
            end
        elseif context.joker_main then
            return {Xmult = card.ability.extra.Xmult, colour = HEX('dc1935')}
        end
        -- Release the Tarot cards until the consumable slot is full.
        local empty_consumable_slot_number = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
        local _iter = math.min(card.ability.extra.deck_of_tarots, empty_consumable_slot_number)
        for _=1,_iter do
            card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots - 1
            local _tarot = pseudorandom_element(G.P_CENTER_POOLS.Tarot,pseudoseed('Miosha'))
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({ key = _tarot.key, area = G.consumeables})
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    return true
                end
            }))
        end
    end
}

Holo.Relic_Joker{ -- Nekomata Okayu
    member = "Okayu",
    key = "Relic_Okayu",
    loc_txt = {
        name = "Lunchbox of the Hungry Cat",
        text = {
            '{C:attention}+#3#{} comsumeable slot.',
            'Eat a random {V:1}consumeable{} at end of shop.',
            'Gain {X:mult,C:white}X#2#{} mult per {V:1}consumeable{} eaten, and',
            '{C:attention}+1{} consumeable slot every #5# {C:inactive}[#4#]',
            '{V:1}consumeables{} eaten. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={1,4}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 2, Xmult_mod = 0.2,
        bento_size = 3,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Mogumogu!',
        },
        count_args = {
            down = 5, init = 5,
        }
    }},
    upgrade_func = function(card)
        if holo_card_counting(card) then
            card.ability.extra.bento_size = card.ability.extra.bento_size + 1
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
        end
    end,
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.bento_size,
                cae.count_args.down, cae.count_args.init,
                colours = {Holo.C.Okayu}
            }
        }
    end,

    atlas = 'Relic_Gamers',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    add_to_deck = function(self, card, from_debuff)
        local cae = card.ability.extra
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + cae.bento_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        local cae = card.ability.extra
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - cae.bento_size
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.ending_shop then
            if #G.consumeables.cards>=1 then
                local onigiri = pseudorandom_element(G.consumeables.cards, pseudoseed('Okayu'))
                onigiri:start_dissolve()
                holo_card_upgrade(card)
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                colour=Holo.C.Okayu,
            }
        end
    end
}

Holo.Relic_Joker{ -- Inugami Korone
    member = "Korone",
    key = "Relic_Korone",
    loc_txt = {
        name = "Boxing Glove of the Energetic Dog",
        text = {
            'For each {C:attention}empty{} consumeable slot,',
            'punch the blind at {C:attention}start of round',
            'and reduce score requirement by {C:chips}10%{}.',
            'Gain {X:mult,C:white}X#2#{} mult every time',
            'a consumeable slot is {C:chips}freed up{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.1,
        punches = 2,
        upgrade_args = {
            scale_var = 'Xmult',
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
            }
        }
    end,

    atlas = 'Relic_Gamers',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    add_to_deck = function (self, card, context)
        card.ability.extra.punches = G.consumeables.config.card_limit - #G.consumeables.cards
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.first_hand_drawn then
            for _=1,cae.punches do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.9)
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                        G.HUD_blind:recalculate()
                        G.hand_text_area.blind_chips:juice_up()
                        card:juice_up()
                        return true
                    end
                }))
                SMODS.calculate_effect({message='POW!', colour=Holo.C.Korone},card)
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                colour = Holo.C.Korone,
            }
        elseif cae.punches~=(G.consumeables.config.card_limit-#G.consumeables.cards) then
            local empty_consumable_slot_number = G.consumeables.config.card_limit-#G.consumeables.cards
            for _=1,(empty_consumable_slot_number-cae.punches)do
                holo_card_upgrade(card)
            end
            cae.punches = empty_consumable_slot_number
        end
    end
}

----