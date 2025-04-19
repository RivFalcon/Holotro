----
SMODS.Atlas{
    key = "Relic_Justice",
    path = "Relics/Relic_Justice.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Elizabeth Rose Bloodflame
    member = "Elizabeth",
    key = "Relic_Elizabeth",
    loc_txt = {
        name = "Thorn the Great Sword of the Scarlet Queen",
        text = {
            'Serve {C:tarot}Justice{} when a {C:attention}blind{} is either',
            '{C:attention}selected{} or {C:attention}skipped{}. {C:inactive}(Must have room){}',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Justice{} rightfully delivered.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 0.5,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'For Justice!'
        }
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_justice
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod} }
    end,

    atlas = 'Relic_Justice',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        holo_card_upgrade_by_consumeable(card, context, 'c_justice')
        if context.setting_blind or context.skip_blind then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                SMODS.add_card({ key = 'c_justice', area = G.consumeables })
            end
        elseif context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

Holo.Relic_Joker{ -- Gigi Murin
    member = "Gigi",
    key = "Relic_Gigi",
    loc_txt = {
        name = "Gauntlet of Da Fister",
        text = {
            'All played cards get {C:attention}fisted{} and',
            'become {C:attention}Glass cards{} when scored.',
            'Gain {X:mult,C:white} X#1# {} Mult every time a card',
            'is already a {C:attention}Glass Card{}',
            'before getting {C:attention}fisted{}.',
            '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)'
        }
        ,boxes = { 2, 4 }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 0.25,
        upgrade_args = {
            scale_var = 'Xmult',
            message="For Justice!",
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult} }
    end,

    atlas = 'Relic_Justice',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.before then
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], "m_glass") and not context.blueprint then
                    holo_card_upgrade(card)
                else
                    context.scoring_hand[i]:set_ability(G.P_CENTERS.m_glass, nil, true)
                end
                SMODS.calculate_effect(
                    {
                        message = "Fisted!",
                        colour = Holo.C.Gigi,
                    },
                    context.scoring_hand[i]
                )
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

Holo.Relic_Joker{ -- Cecilia Immergreen
    member = "Ceci",
    key = "Relic_Ceci",
    loc_txt = {
        name = "Violance of the Automaton",
        text = {
            'All {C:attention}Glass cards{} become {C:attention}very durable{}.',
            'Gain {X:mult,C:white} X#1# {} Mult every time a {C:attention}Glass Card{}',
            'is prevented from shattering.',
            '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)'
        }
        ,boxes = { 1, 3 }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 1,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'For Justice!',
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult} }
    end,

    atlas = 'Relic_Justice',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i, val in ipairs(context.removed) do
                if SMODS.has_enhancement(val, "m_glass") then
                    holo_card_upgrade(card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            -- Copied (and modified) this part from Ship of Theseus, ExtraCredit mod.
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = copy_card(val, nil, nil, G.playing_card)
                            _card:add_to_deck()
                            G.discard:emplace(_card)
                            table.insert(G.playing_cards, _card)
                            playing_card_joker_effects({true})
                            _card:start_materialize()
                            return true
                        end
                    }))
                end
            end
        elseif context.shatter_check and not context.blueprint then
            holo_card_upgrade(card)
            return {durable=true}
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

Holo.Relic_Joker{ -- Raora Panthera
    member = "Raora",
    key = "Relic_Raora",
    loc_txt = {
        name = "Sketching Pen of the Pink Panther",
        text = {
            'Played {C:attention}Glass cards{} get sketched',
            'and increase its {C:mult}Xmult{}',
            'by {X:mult,C:white}X#3#{} mult when scored.',
            'Gain {X:mult,C:white}X#2#{} mult per card sketched.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes = { 3, 2 }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 4, Xmult_mod = 0.25,
        Xmult_mod_card = 0.1,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'For Justice!',
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.Xmult_mod_card
            }
        }
    end,

    atlas = 'Relic_Justice',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_glass") then
                context.other_card.ability.Xmult = context.other_card.ability.Xmult + card.ability.extra.Xmult_mod_card
                context.other_card.ability.x_mult = context.other_card.ability.x_mult + card.ability.extra.Xmult_mod_card
                holo_card_upgrade(card)
            end
        elseif context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

----