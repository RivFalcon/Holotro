----

--[[
Holo.Meme_Joker{ -- Kiara: The Usual Room
    member = "Kiara",
    key = "Meme_Kiara_TUR",
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

SMODS.Atlas{ -- Ina_WAH
    key = "Ina_WAH",
    path = "Memes/Meme_Ina_WAHs.png",
    px = 71,
    py = 95
}

local Wah_Joker = Holo.Meme_Joker:extend{
    member = "Ina",
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    in_pool = function(self, args)
        local wah = self.WAH_index
        if wah == 0 then return true end

        local pool_flags_WAH = G.GAME.pool_flags.WAH or {}
        if wah>=1 and wah<=5 and pool_flags_WAH[0]then
            if wah==4 then return pseudorandom('forbidden WAH')<1/4 end
            return true
        end

        local common_wah_flag_counter = 0
        for w=1,5 do
            if pool_flags_WAH[w] then
                common_wah_flag_counter = common_wah_flag_counter + 1
            end
        end
        if wah>=6 and wah<=10 and common_wah_flag_counter>=3 then return true end

        local uncommon_wah_flag_counter = 0
        for w=6,10 do
            if pool_flags_WAH[w] then
                uncommon_wah_flag_counter = uncommon_wah_flag_counter + 1
            end
        end
        --if wah>=11 and wah<=15 and uncommon_wah_flag_counter>=1 then return true end
        return false
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.pool_flags.WAH = G.GAME.pool_flags.WAH or {}
        G.GAME.pool_flags.WAH[self.WAH_index] = true
    end,
}

Wah_Joker{ -- Ina: WAH 00
    key = "Meme_Ina_WAH_00",
    loc_txt = {
        name = 'We Are Hololive',
        text = {
            'Copies ability of',
            'the joker to the right',
            'if it\'s a {V:1}holotro{} joker.'
        }
    },
    config = { extra = { } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { colours = { Holo.C.Hololive } },
            main_end = Holo.blueprint_node(card)
        }
    end,
    WAH_index = 0,
    rarity = 1,
    cost = 5,
    discovered = true,
    atlas = 'Ina_WAH',
    pos = {y=0,x=0},

    update = function(self, card, dt)
        local joker_to_the_right = nil
        local joker_cards = (G.jokers or {}).cards or {}
        for i,J in ipairs(joker_cards)do
            if J == card then
                joker_to_the_right = joker_cards[i+1]
                break
            end
        end
        Holo.blueprint_update(card, joker_to_the_right, Holo.mod_check(joker_to_the_right))
    end,
    calculate = function(self, card, context)
        local joker_to_the_right = nil
        for i,J in ipairs(G.jokers.cards)do
            if J == card then
                joker_to_the_right = G.jokers.cards[i+1]
                break
            end
        end
        if joker_to_the_right and Holo.mod_check(joker_to_the_right) then
            --SMODS.calculate_effect(SMODS.blueprint_effect(card, joker_to_the_right, context)or{}, card)
            return SMODS.blueprint_effect(card, joker_to_the_right, context)
        end
    end
}

Wah_Joker{ -- Ina: WAH 01
    key = "Meme_Ina_WAH_01",
    loc_txt = {
        name = 'We Are Happy',
        text = {
            'Cards with {C:purple}purple seals{} are',
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
    atlas = 'Ina_WAH',
    pos = {y=0,x=1},

    calculate = function(self, card, context)
        if context.repetition then
            if context.other_card.seal=='Purple' then
                return {
                    repetitions = card.ability.extra.happy,
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                    card = card,
                }
            end
        end
    end
}

Wah_Joker{ -- Ina: WAH 02
    key = "Meme_Ina_WAH_02",
    loc_txt = {
        name = 'We Are Hype',
        text = {
            'When blind is selected,',
            'create up to {C:attention}#1# {C:spectral}Mediums{}.',
            '{C:inactive}(Must have room)'
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
    atlas = 'Ina_WAH',
    pos = {y=0,x=2},

    calculate = function(self, card, context)
        if context.setting_blind then
            card:juice_up()
            local empty_consumable_slot_number = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
            for i=1,math.min(card.ability.extra.hype, empty_consumable_slot_number) do
                SMODS.add_card({ key = 'c_medium', area = G.consumeables })
            end
            return {
                message = 'WAH!',
                colour = Holo.C.Ina,
            }
        end
    end
}

Wah_Joker{ -- Ina: WAH 03
    key = "Meme_Ina_WAH_03",
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
    atlas = 'Ina_WAH',
    pos = {y=0,x=3},

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

Wah_Joker{ -- Ina: WAH 04
    key = "Meme_Ina_WAH_04",
    loc_txt = {
        name = 'We Are Ho**y',
        text = {
            'Mult cards with {C:purple}purple seals{}',
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
    atlas = 'Ina_WAH',
    pos = {y=0,x=4},

    calculate = function(self, card, context)
        if context.discard then
            if SMODS.has_enhancement(context.other_card, "m_mult") and context.other_card.seal == 'Purple' then
                context.other_card.ability.mult = context.other_card.ability.mult + card.ability.extra.horny
                return {
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                }
            end
        end
    end
}

Wah_Joker{ -- Ina: WAH 05
    key = "Meme_Ina_WAH_05",
    loc_txt = {
        name = 'Win All Hearts',
        text = {
            'Gain {C:mult}+#2#{} mult when drawing a card',
            'with {C:hearts}Heart{} suit and {C:purple}purple seal{}.',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult)'
        }
    },
    config = { extra = {
        win = 0, heart = 5,
        upgrade_args={
            scale_var='win',
            incr_var='heart',
        }
    }},
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
    atlas = 'Ina_WAH',
    pos = {y=1,x=0},

    calculate = function(self, card, context)
        if context.draw_from_deck_to_hand and G.GAME.facing_blind then
            if context.drawn_card:is_suit('Hearts') and context.drawn_card.seal == 'Purple' and not context.blueprint then
                holo_card_upgrade(card)
            end
        elseif context.joker_main then
            return {
                mult = card.ability.extra.win,
                message = 'WAH!',
                colour = Holo.C.Ina,
            }
        end
    end
}

Wah_Joker{ -- Ina: WAH 06
    key = "Meme_Ina_WAH_06",
    loc_txt = {
        name = 'Work At Home',
        text = {
            'Cards with {C:purple}purple seals{} held in hand',
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
    atlas = 'Ina_WAH',
    pos = {y=1,x=1},

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

Wah_Joker{ -- Ina: WAH 07
    key = "Meme_Ina_WAH_07",
    loc_txt = {
        name = 'We Are Honor students',
        text = {
            '{C:attention}Aces{} with {C:purple}purple seals{}',
            'give {C:chips}+#1#{} chips and {C:mult}+#1#{} mult',
            'when scored or held in hand.'
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
    atlas = 'Ina_WAH',
    pos = {y=1,x=2},

    calculate = function(self, card, context)
        if context.individual and not context.end_of_round then
            if context.other_card:get_id() == 14 and context.other_card.seal == 'Purple' then
                return {
                    chips = card.ability.extra.honor,
                    mult = card.ability.extra.honor,
                }
            end
        end
    end
}

Wah_Joker{ -- Ina: WAH 08
    key = "Meme_Ina_WAH_08",
    loc_txt = {
        name = 'We Adore Her',
        text = {
            'Has {C:green}#1# in #2#{} chance to gain',
            '{C:attention}#3#{} consumeable slot when',
            'played a card with {C:purple}purple seal{}.'
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
    atlas = 'Ina_WAH',
    pos = {y=1,x=3},

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == 'Purple' then
                if Holo.chance('We Adore Her', card.ability.extra.we) then
                    G.E_MANAGER:add_event(Event({func = function()
                        G.consumeables.config.card_limit = G.consumeables.config.card_limit + ard.ability.extra.adore
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

Wah_Joker{ -- Ina: WAH 09
    key = "Meme_Ina_WAH_09",
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
    atlas = 'Ina_WAH',
    pos = {y=1,x=4},

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
                    repetitions = 1,
                    message = 'WAH!',
                    colour = Holo.C.Ina,
                    card = card,
                }
            end
        end
    end
}

Wah_Joker{ -- Ina: WAH 10
    key = "Meme_Ina_WAH_10",
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
    atlas = 'Ina_WAH',
    pos = {y=2,x=0},

    calculate = function(self, card, context)
        if context.draw_from_deck_to_hand and context.drawn_card.facing == 'front' and not context.blueprint then
            if Holo.chance('We Are Hidden', card.ability.extra.hidden) then
                context.drawn_card:flip()
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

Wah_Joker{ -- Ina: WAH 11
    key = "Meme_Ina_WAH_11",
    loc_txt = {
        name = 'We Are Horrified',
        text = {
            'Face cards with {C:purple}purple seals{}',
            'give {C:chips}+#1#{} chips when scored.',
            'Increase by {C:chips}+#2#{} chips per played hand',
            'that contains cards with {C:purple}purple seals{}.',
            'Reset to {C:chips}+0{} chips when a card',
            'with {C:purple}purple seal{} is destroyed.'
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
    no_collection = true,
    atlas = 'Ina_WAH',
    pos = {y=2,x=1},

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == 'Purple' then
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
            end
        elseif context.remove_playing_cards then
            for _,v in ipairs(context.removed)do
                if v.seal == 'Purple'then
                    card.ability.extra.we = 0
                    SMODS.calculate_effect({message=localize('k_reset')},card)
                end
            end
        end
    end
}

Wah_Joker{ -- Ina: WAH 12
    key = "Meme_Ina_WAH_12",
    loc_txt = {
        name = 'We Are Hot soup',
        text = {
            'Played cards with {C:purple}purple seals{}',
            'give {X:mult,C:white}X#1#{} Mult when scored.',
            'Lose {X:mult,C:white}X#2#{} Mult per discarded',
            'card {C:attention}without {C:purple}purple seal{}.'
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
    eternal_compat = false,
    cost = 8,
    no_collection = true,
    atlas = 'Ina_WAH',
    pos = {y=2,x=2},

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
                    holo_card_expired(card)
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

Holo.Atlas_7195{
    key = 'Gura_SharkFinger',
    path = 'Memes/Meme_Gura_SharkFinger.png'
    -- credit: https://www.reddit.com/r/Hololive/comments/tb77iq/here_is_an_hd_upscaled_version_of_gura_giving_you/
}
Holo.Meme_Joker{ -- Gura: Shark Finger
    member = "Gura",
    key = "Meme_Gura_SharkFinger",
    loc_txt = {
        name = "Shark Finger",
        text = {
            'Retrigger {C:attention}third{} played card {C:attention}twice',
            'if played exactly {C:attention}five{} cards.'
        }
    },
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    atlas = 'Gura_SharkFinger',
    pos = {x=0,y=0},

    calculate = function(self, card, context)
        if context.repetition and context.cardarea==G.play then
            if #context.full_hand == 5 and context.other_card==context.full_hand[3] then
                return {
                    repetitions = 2,
                    colour = Holo.C.Gura,
                    card = card,
                }
            end
        end
    end
}

Holo.Atlas_7195{
    key = 'Gura_WTROT',
    path = 'Memes/Meme_Gura_WTROT.png'
}
Holo.Meme_Joker{ -- Gura: Where's the rest of them?
    member = 'Gura',
    key = 'Meme_Gura_WTROT',
    loc_txt = {
        name = "Where\'s the rest of them?",
        text = {
            'Retrigger {C:attention}third{} and {C:attention}fourth{} played cards',
            'if played exactly {C:attention}five{} cards.'
        }
    },
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    atlas = 'Gura_WTROT',
    pos = {x=0,y=0},

    calculate = function(self, card, context)
        if context.repetition and context.cardarea==G.play then
            local full_hand = context.full_hand
            local other_card = context.other_card
            if (#full_hand==5)and((other_card==full_hand[3])or(other_card==full_hand[4]))
             or (#full_hand==6)and((other_card==full_hand[3])or(other_card==full_hand[4])or(other_card==full_hand[5])) then
                return {
                    repetitions = 1,
                    colour = Holo.C.Gura,
                    card = card,
                }
            end
        end
    end
}

----