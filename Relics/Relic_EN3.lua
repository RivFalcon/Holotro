----
SMODS.Atlas{
    key = "Relic_Advent",
    path = "Relics/Relic_Advent.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Shiori Novella
    member = "Shiori",
    key = "Relic_Shiori",
    loc_txt = {
        name = "Quill Pen of the Archiver",
        text = {
            'Retrigger all cards {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}23{C:inactive} [#2#] {}cards discarded.',
            'Discarded {C:attention}face cards{} get made into {X:black,C:white}bookmarks{}',
            'and will be properly {X:black,C:white}archived{}.'
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers = 1, count_down = 23,
        upgrade_args = {
            scale_var = 'retriggers',
            message="Yoricked!",
        }
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,

    atlas = 'Relic_Advent',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                message = "Note!",
                repetitions = card.ability.extra.retriggers,
                card = card,
                colour = HEX('373741')
            }
        elseif context.discard and not context.blueprint then
            card.ability.extra.count_down = card.ability.extra.count_down - 1
            if card.ability.extra.count_down <= 0 then
                card.ability.extra.count_down = card.ability.extra.count_down + 23
                holo_card_upgrade(card)
            end
            if context.other_card:is_face() then
                context.other_card:juice_up()
                card_eval_status_text(context.other_card, 'extra', nil, 1, nil, {message="Archived!",colour = HEX('373741')})
                context.other_card:start_dissolve(nil, true)
                -- "No no no, they were not destroyed, silly! I just took them to somewhere else!"
            end
        end
    end
}

Holo.Relic_Joker{ -- Koseki Bijou
    member = "Biboo",
    key = "Relic_Biboo",
    loc_txt = {
        name = "Jewel Crown of the Ancient Rock",
        text = {
            '{C:attention}Stone cards{} become {C:attention}More Solid{},',
            'permanently gain {C:chips}+#1#{} chips when scored.',
            'Chip gain increases by {C:chips}+#2#{} chips',
            'per {C:tarot}The Tower{} used.',
            '{C:attention}Non-face cards{} will always score.'
        }
        ,boxes={2,2,1}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        bonus_mod = 50, bonus_mod_mod = 10,
        upgrade_args = {
            scale_var = 'bonus_mod',
            message = 'Rock!',
        },
    } },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = {
            cae.bonus_mod, cae.bonus_mod_mod
        } }
    end,

    atlas = 'Relic_Advent',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        holo_card_upgrade_by_consumeable(card, context, 'c_tower')
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_stone") then
                context.other_card.ability.bonus = context.other_card.ability.bonus + card.ability.extra.bonus_mod
                SMODS.calculate_effect({message="Biboo!",colour = HEX('6e5bf4')},card)
            end
        end
    end
}

Holo.Relic_Joker{ -- Nerissa Ravencroft
    member = "Nerissa",
    key = "Relic_Nerissa",
    loc_txt = {
        name = "Tuning Fork of the Raven Diva",
        text = {
            'Each played card {C:spectral}sings along with the tune{}',
            'and gives {X:mult,C:white} X#1# {} mult when scored.',
            '{C:attention}Face cards{} that joined the chorus',
            'will fall victim into {X:black,C:white}craziness{}.'
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { Xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,

    atlas = 'Relic_Advent',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                message = "Ope!",
                colour = HEX('2233fb'),
                Xmult_mod = card.ability.extra.Xmult,
                card = card
            }
        elseif context.destroying_card then
            if context.destroying_card:is_face() then
                play_sound('gong')
                return { remove = true }
            end
        end
    end
}

Holo.Relic_Joker{ -- Fuwawa Abyssgard
    member = "Fuwawa",
    key = "Relic_Fuwawa",
    loc_txt = {
        name = "Claws of the Fluffy Hellhound",
        text = {
            'Each played card with {C:blue}odd{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}22{C:inactive} [#2#]{} {C:blue}odd{} cards scored.',
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers = 2, count_down = 22,
        upgrade_args = {
            scale_var = 'retriggers',
            message = 'Baubau!'
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_odd'}
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,

    atlas = 'Relic_Advent',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local _rank = context.other_card:get_id()
            if (_rank == 14)or(_rank == 9)or(_rank == 7)or(_rank == 5)or(_rank == 3) then
                return {
                    message = 'Bau!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    colour = HEX('67b2ff')
                }
            end
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            local _rank = context.other_card:get_id()
            if (_rank == 14)or(_rank == 9)or(_rank == 7)or(_rank == 5)or(_rank == 3) then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 22
                    holo_card_upgrade(card)
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Mococo Abyssgard
    member = "Mococo",
    key = "Relic_Mococo",
    loc_txt = {
        name = "Claws of the Fuzzy Hellhound",
        text = {
            'Each played card with {C:red}even{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}22{C:inactive} [#2#] {C:red}even{} cards scored.',
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers = 2, count_down = 22,
        upgrade_args = {
            scale_var = 'retriggers',
            message = 'Baubau!'
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_even'}
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,

    atlas = 'Relic_Advent',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local _rank = context.other_card:get_id()
            if (_rank == 10)or(_rank == 8)or(_rank == 6)or(_rank == 4)or(_rank == 2) then
                return {
                    message = 'Bau!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    colour = HEX('f7a6ca')
                }
            end
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            local _rank = context.other_card:get_id()
            if (_rank == 10)or(_rank == 8)or(_rank == 6)or(_rank == 4)or(_rank == 2) then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 22
                    holo_card_upgrade(card)
                end
            end
        end
    end
}

----