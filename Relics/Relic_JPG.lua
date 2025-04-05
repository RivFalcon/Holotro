----

Holo.Relic_Joker{ -- Ookami Mio
    member = "Mio",
    key = "Relic_Mio",
    loc_txt = {
        name = "Tarot Deck of the Wolf",
        text = {
            'When a {C:tarot}Tarot card{} is used,',
            'create another {C:tarot}Tarot card{}.',
            '(If no room, {C:attention}accumulate{} them {C:inactive}[#3#]{} until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Tarot card{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={5,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.2,
        deck_of_tarots = 0,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Mion!',
            func = function(card)
                card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots + 1
            end
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.deck_of_tarots
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
        if card.ability.extra.deck_of_tarots > 0 then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots - 1
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        local _tarot = pseudorandom_element(G.P_CENTER_POOLS.Tarot,pseudoseed('Miosha'))
                        SMODS.add_card({ key = _tarot.key, area = G.consumeables})
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
            end
        end
    end
}

Holo.Relic_Joker{ -- Nekomata Okayu
    member = "Okayu",
    key = "Relic_Okayu",
    loc_txt = {
        name = "Mealbox of the Hungry Cat",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Gamers',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Inugami Korone
    member = "Korone",
    key = "Relic_Korone",
    loc_txt = {
        name = "Boxing Glove of the Energetic Dog",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Gamers',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
    end
}

----