----
SMODS.Atlas{
    key = "Relic_Justice",
    path = "Relic_Justice.png",
    px = 71,
    py = 95
}

SMODS.Joker{ -- Elizabeth Rose Bloodflame
    key = "Relic_Elizabeth",
    talent = "Elizabeth",
    loc_txt = {
        name = "Great Sword of the Scarlet Queen",
        text = {
            'Serve {C:tarot}Justice{} when a {C:attention}blind{}',
            'is either {C:attention}selected{} or {C:attention}skipped{}.',
            '{C:inactive}(Must have room){}',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Justice{}',
            'rightfully delivered.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes = { 3, 3 }
    },
    config = { extra = { Xmult = 4, Xmult_mod = 0.5 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_justice
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod} }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Justice',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        self.config.extra.Xmult = self.config.extra.Xmult + self.config.extra.Xmult_mod
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.config.center.key == 'c_justice' and not context.blueprint then
                self:upgrade(card)
            end
        elseif context.setting_blind or context.skip_blind then
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

SMODS.Joker{ -- Gigi Murin
    key = "Relic_Gigi",
    talent = "Gigi",
    loc_txt = {
        name = "Gauntlet of Da Fister",
        text = {
            'All played cards get {C:attention}fisted{} and',
            'become {C:attention}Glass cards{} when scored.',
            'Gain {X:mult,C:white} X#1# {} Mult every time a card',
            'is already a {C:attention}Glass Card{}',
            'before getting {C:attention}fisted{}.',
            '(Currently {X:mult,C:white} X#2# {} Mult)'
        }
        ,boxes = { 2, 4 }
    },
    config = { extra = { Xmult = 4, Xmult_mod = 0.25 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult} }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Justice',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    upgrade = function(self, card)
        card:juice_up(0.5, 0.5)
        self.config.extra.Xmult = self.config.extra.Xmult + self.config.extra.Xmult_mod
        return {
            message = "Upgrade!",
            colour = G.C.XMULT,
            card = card
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before and context.scoring_hand then
                for i = 1, #context.scoring_hand do
                    if SMODS.has_enhancement(context.scoring_hand[i], "m_glass") and not context.blueprint then
                        self:upgrade(card)
                    else
                        context.scoring_hand[i]:set_ability(G.P_CENTERS.m_glass, nil, true)
                    end
                    return {
                        message = "Fisted!",
                        colour = G.C.GREY,
                        card = context.other_card
                    }
                end
            elseif context.joker_main then
                card:juice_up(0.5, 0.5)
                return {
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
    end
}

SMODS.Joker{ -- Cecilia Immergreen
    key = "Relic_Ceci",
    talent = "Ceci",
    loc_txt = {
        name = "Violance of the Automaton",
        text = {
            'All {C:attention}Glass cards{} become {C:attention}very durable{}.',
            'Gain {X:mult,C:white} X#1# {} Mult every time a {C:attention}Glass Card{}',
            'is prevented from shattering.',
            '(Currently {X:mult,C:white} X#2# {} Mult)'
        }
        ,boxes = { 1, 3 }
    },
    config = { extra = { Xmult = 4, Xmult_mod = 1 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult} }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Justice',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    upgrade = function(self, card)
        card:juice_up(0.5, 0.5)
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        return {
            message = "Upgrade!",
            colour = G.C.XMULT,
            card = card
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for i, val in ipairs(context.removed) do
                if SMODS.has_enhancement(val, "m_glass") then
                    if not context.blueprint then
                        self:upgrade(card)
                    end
                    -- Copied and modified this part from Ship of Theseus, ExtraCredit mod.
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(val, nil, nil, G.playing_card)
                    card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(_card)
                    table.insert(G.playing_cards, _card)
                    playing_card_joker_effects({true})

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                        end
                    }))

                end
            end
        elseif context.joker_main then
            card:juice_up(0.5, 0.5)
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{ -- Raora Panthera
    key = "Relic_Raora",
    talent = "Raora",
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
    },
    config = { extra = { Xmult = 4, Xmult_mod = 0.25, Xmult_mod_card = 0.1 } },
    unlock_condition = {type = '', extra = '', hidden = true},
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
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Justice',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        self.config.extra.Xmult = self.config.extra.Xmult + self.config.extra.Xmult_mod
    end,
    calculate = function(self, card, context)
        if context.individual and not context.repetition then
            if SMODS.has_enhancement(context.other_card, "m_glass") then
                context.other_card.ability.x_mult = context.other_card.ability.x_mult + card.ability.extra.Xmult_mod_card
                self:upgrade(card)
            end
        elseif context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

----