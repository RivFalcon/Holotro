----

Holo.Relic_Joker{ -- Ookami Mio
    member = "Mio",
    key = "Relic_Mio",
    loc_txt = {
        name = "Tarot Deck of the Wolf",
        text = {
            'Create a {C:tarot}Tarot card{} per:',
            '{C:attention}blind{} either {C:blue}selected{} or {C:red}skipped{};',
            '{C:attention}booster pack{} of any type opened in shop; or',
            '{C:dark_edition}purple seal{} card held in hand at {C:attention}end of round{}.',
            '(If no room, {C:attention}accumulate{} them {C:inactive}[#3#]{} until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Tarot card{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={5,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { Xmult = 1, Xmult_mod = 0.2, deck_of_tarots = 0 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.deck_of_tarots
            }
        }
    end,

    --atlas = 'Relic_Gamers',
    --pos = { x = 1, y = 0 },
    --soul_pos = { x = 1, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Mion!",colour = HEX('dc1935'),instant=true})
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.skip_blind then
            card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots + 1
        elseif context.buying_booster_pack then
            card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots + 1
        elseif context.end_of_round and context.individual then
            if context.other_card.seal == 'Purple' then
                card.ability.extra.deck_of_tarots = card.ability.extra.deck_of_tarots + 1
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
                        SMODS.add_card({ key = _tarot, area = G.consumeables})
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
                if not context.blueprint then
                    self:upgrade(card)
                end
            end
        end
    end
}

----