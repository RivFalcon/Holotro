----

--[[
SMODS.Joker{ -- Kiara: The Usual Room
    member = "Kiara",
    key = "Kiara_TUR",
    loc_txt = {
        name = "The Usual Room",
        text = {
            'If first discard of round',
            'has only {C:attention}1{} card,',
            'send it to {C:attention}The Usual Room{}',
            'and create a {C:holofan}KFP{}.'
        }
    },
    config = { extra = {} },
    rarity = 2,
    cost = 6,
    --atlas = 'Kiara_TUR',
    --pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
    end
}
]]--

SMODS.Atlas{
    key = "Ina_WAH",
    path = "Memes/Meme_Ina_WAHs.png",
    px = 71,
    py = 95
}

SMODS.Joker{ -- Ina: WAH 00
    member = "Ina",
    key = "Ina_WAH_00",
    loc_txt = {
        name = 'We Are Hololive',
        text = {
            'Copies ability of Joker to the right',
            'if it\'s a {V:1}holotro{} joker.'
        }
    },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return { vars = { colours = { Holo.C.Hololive } } }
    end,
    WAH_index = 0,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=0,x=0},

    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        local joker_to_the_right = nil
        for i,J in ipairs(G.jokers.cards)do
            if J == card and i<#G.jokers.cards then
                joker_to_the_right = G.jokers.cards[i+1]
                break
            end
        end
        if ((joker_to_the_right or {}).mod or {}).id == 'Holotro' then
            SMODS.calculate_effect(SMODS.blueprint_effect(card, joker_to_the_right, context), card)
        end
    end
}

SMODS.Joker{ -- Ina: WAH 01
    member = "Ina",
    key = "Ina_WAH_01",
    loc_txt = {
        name = 'We Are Happy',
        text = {
            '{C:attention}Face cards{} are',
            'retriggered {C:attention}#1#{} time.'
        }
    },
    config = { extra = { happy = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.happy,
            }
        }
    end,
    WAH_index = 1,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=0,x=1},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.repetition then
            if context.other_card:is_face() then
                return {
                    retrigger = card.ability.extra.happy,
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 02
    member = "Ina",
    key = "Ina_WAH_02",
    loc_txt = {
        name = 'We Are Hype',
        text = {
            'When blind is selected,',
            'create {C:attention}#1# {C:dark_edition}Negative {C:spectrals}Medium{}s.'
        }
    },
    config = { extra = { hype = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_medium
        return {
            vars = {
                card.ability.extra.hype,
            }
        }
    end,
    WAH_index = 2,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=0,x=2},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card:juice_up()
            for i=1,card.ability.extra.hype do
                SMODS.add_card({ key = 'c_medium', area = G.consumeables, edition = 'e_negative' })
            end
            return {
                message = 'WAH!',
                colour = Holo.C.Ina,
            }
        end
    end
}

SMODS.Joker{ -- Ina: WAH 03
    member = "Ina",
    key = "Ina_WAH_03",
    loc_txt = {
        name = 'We Are Here',
        text = {
            '{X:mult,C:white}X#1#{} Mult if played hand',
            'contains a {C:purple}purple{} seal.'
        }
    },
    config = { extra = { here = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.here,
            }
        }
    end,
    WAH_index = 3,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=0,x=3},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _,v in ipairs(context.full_hand)do
                if v.seal == 'Purple' then
                    return {
                        Xmult = card.ability.extra.here,
                        message = 'WAH!',
                        colour = Holo.C.Ina,
                    }
                end
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 04
    member = "Ina",
    key = "Ina_WAH_04",
    loc_txt = {
        name = 'We Are Ho**y',
        text = {
            'Mult cards with {C:purple}purple{} seals',
            'permanently gain {C:mult}+#1#{} mult',
            'when discarded.'
        }
    },
    config = { extra = { horny = 4 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mult
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.horny,
            }
        }
    end,
    WAH_index = 4,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=0,x=4},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.discard then
            if SMODS.has_enhancement(context.other_card, "m_mult") and context.other_card.seal == 'Purple' then
                context.other_card.ability.config.mult = context.other_card.ability.config.mult + card.ability.extra.horny
                return {
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 05
    member = "Ina",
    key = "Ina_WAH_05",
    loc_txt = {
        name = 'Win All Hearts',
        text = {
            'Gain {C:mult}+#2#{} mult when drew a card',
            'with {C:hearts}Heart{} suit and {C:purple}purple{} seal.',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult)'
        }
    },
    config = { extra = { win = 0, heart = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.win,
                card.ability.extra.heart,
            }
        }
    end,
    WAH_index = 5,
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=1,x=0},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.card_drawn and G.GAME.facing_blind and not context.blueprint then
            if context.card_drawn:is_suit('Hearts') and context.card_drawn.seal == 'Purple' then
                card.ability.extra.win = card.ability.extra.win + card.ability.extra.heart
                SMODS.calculate_effect(
                    {
                        message = localize('k_upgrade_ex'),
                        colour = Holo.C.Ina,
                    },
                    card
                )
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                mult = card.ability.extra.win,
                message = 'WAH!',
                colour = Holo.C.Ina,
            }
        end
    end
}

SMODS.Joker{ -- Ina: WAH 06
    member = "Ina",
    key = "Ina_WAH_06",
    loc_txt = {
        name = 'Work At Home',
        text = {
            'Cards with {C:purple}purple{} seal held in hand',
            'give {C:money}$#1#{} at end of round.'
        }
    },
    config = { extra = { work = 6 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.work
            }
        }
    end,
    WAH_index = 6,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=1,x=1},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.individual then
            if context.other_card.seal == 'Purple' then
                return {
                    h_dollars = card.ability.extra.work,
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 07
    member = "Ina",
    key = "Ina_WAH_07",
    loc_txt = {
        name = 'We Are Honor students',
        text = {
            'Played Aces with {C:purple}purple{} seal give',
            '{C:chips}+#1#{} chips and {C:mult}+#1#{} mult when scored.'
        }
    },
    config = { extra = { honor = 7 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.honor
            }
        }
    end,
    WAH_index = 7,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=1,x=2},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 14 and context.other_card.seal == 'Purple' then
                return {
                    chips = card.ability.extra.honor,
                    mult = card.ability.extra.honor,
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 08
    member = "Ina",
    key = "Ina_WAH_08",
    loc_txt = {
        name = 'We Adore Her',
        text = {
            'Has {C:green}#1# in #2#{} chance to {C:dark_edition}+#3#{} consumeable slot',
            'when a card with {C:purple}purple{} seal scores.'
        }
    },
    config = { extra = { we = 8, adore = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                Holo.prob_norm(),
                card.ability.extra.we,
                card.ability.extra.adore,
            }
        }
    end,
    WAH_index = 8,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=1,x=3},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == 'Purple' then
                if Holo.chance('We Adore Her', card.ability.extra.we) then
                    G.E_MANAGER:add_event(Event({func = function()
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                        return true end
                    }))
                    return {
                        message = 'WAH!',
                        colour = Holo.C.Ina,
                    }
                end
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 09
    member = "Ina",
    key = "Ina_WAH_09",
    loc_txt = {
        name = 'We Are Healthy',
        text = {
            'Drink {C:blue}water{} from the bottle',
            'at {C:attention}end of round{}. {C:inactive}(#1#/#2#)',
            'Retrigger {C:attention}all{} played cards while {C:blue}hydrated{}.'
        }
    },
    config = { extra = { we = 9, healthy = 9 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        info_queue[#info_queue+1] = G.P_CENTERS.c_temperance
        return {
            vars = {
                card.ability.extra.we,
                card.ability.extra.healthy,
            }
        }
    end,
    WAH_index = 9,
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=1,x=4},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            if card.ability.extra.we > 0 then card:juice_up() end
            card.ability.extra.we = math.max( 0, card.ability.extra.we - 1 )
        elseif context.using_consumeable and not context.blueprint then
            if context.consumeable.config.center.key == 'c_star' or context.consumeable.config.center.key == 'c_temperance' then
                card:juice_up()
                card.ability.extra.we = card.ability.extra.healthy
                return {
                    message = 'Refilled!',
                    colour = Holo.C.Ina,
                }
            end
        elseif context.repetition and context.cardarea == G.play then
            if card.ability.extra.we > 0 then
                return {
                    retrigger = 1,
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 10
    member = "Ina",
    key = "Ina_WAH_10",
    loc_txt = {
        name = 'We Are Hidden',
        text = {
            'Cards have {C:green}#1# in #2#{} chance',
            'to be drawn {C:attention}face down{}.',
            'Cards held in hand facing down',
            'give {X:mult,C:white}X#2#{} Mult.'
        }
    },
    config = { extra = { hidden = 10 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                Holo.prob_norm(),
                card.ability.extra.hidden,
            }
        }
    end,
    WAH_index = 10,
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=2,x=0},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.card_drawn and context.card_drawn.facing == 'front' and not context.blueprint then
            if Holo.chance('We Are Hidden', card.ability.extra.hidden) then
                context.card_drawn:flip()
            end
        elseif context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card.facing == 'back' then
                return {
                    Xmult = card.ability.extra.hidden,
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 11
    member = "Ina",
    key = "Ina_WAH_11",
    loc_txt = {
        name = 'We Are Horrified',
        text = {
            'Face cards with {C:purple}purple{} seal',
            'give {C:chips}+#1#{} chips when scored.',
            'Increase by {C:chips}+#2#{} chips per {C:attention}consecutive{} hand',
            'that contains {C:attention}face cards{} with {C:purple}purple{} seal.'
        }
    },
    config = { extra = { we = 0, horror = 11 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.we,
                card.ability.extra.horror,
            }
        }
    end,
    WAH_index = 11,
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=2,x=1},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() and context.other_card.seal == 'Purple' then
                return {
                    chips = card.ability.extra.we,
                }
            end
        elseif context.before and not context.blueprint then
            local _tick = false
            for _,v in ipairs(context.full_hand)do
                if v:is_face() and v.seal == 'Purple' then
                    _tick = true
                    break
                end
            end
            if _tick then
                card.ability.extra.we = card.ability.extra.we + card.ability.extra.horror
                return {
                    message = "WAH!",
                    colour = Holo.C.Ina,
                }
            else
                card.ability.extra.we = 0
                return {
                    message = localize('k_reset')
                }
            end
        end
    end
}

SMODS.Joker{ -- Ina: WAH 12
    member = "Ina",
    key = "Ina_WAH_12",
    loc_txt = {
        name = 'We Are Hot soup',
        text = {
            'Played cards with {C:purple}purple{} seal',
            'give {X:mult,C:white}X#1#{} Mult when scored.',
            'Lose {X:mult,C:white}X#2#{} Mult per discarded',
            'card {C:attention}without {C:purple}purple{} seal.'
        }
    },
    config = { extra = { soup = 12, sip = 0.1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS.Purple
        return {
            vars = {
                card.ability.extra.soup,
                card.ability.extra.sip,
            }
        }
    end,
    WAH_index = 12,
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,

    atlas = 'Ina_WAH',
    pos = {y=2,x=2},

    in_pool = function(self, args)
        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if pool_flags_WAH[self.WAH_index] then
            return true
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index+1] = true
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == 'Purple' then
                return {
                    Xmult = card.ability.extra.soup,
                    colour = Holo.C.Ina,
                }
            end
        elseif context.discard and not context.blueprint then
            if context.other_card.seal ~= 'Purple' then
                card.ability.extra.soup = card.ability.extra.soup - card.ability.extra.sip
                if card.ability.extra.soup <= 1 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    }))
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                else
                    return {
                        message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.sip}},
                        colour = Holo.C.Ina,
                    }
                end
            end
        end
    end
}

----