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
        retriggers = 1,
        upgrade_args = {
            scale_var = 'retriggers',
            message="Recorded!",
        },
        count_args = {
            down = 23,
            init = 23
        }
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_args.down } }
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
                colour = Holo.C.Shiori
            }
        elseif context.discard and not context.blueprint then
            if holo_card_counting(card) then
                holo_card_upgrade(card)
            end
            if context.other_card:is_face() then
                return {
                    remove = true,
                    message="Archived!",
                    colour = Holo.C.Shiori,
                    card = context.other_card
                }
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
            '{C:attention}Stone cards{} become {C:attention}#4#{},',
            'permanently gain {C:chips}+#3#{} chips when played.',
            '{C:attention}Non-face cards{} or {C:attention}Stone Cards',
            'give {X:mult,C:white}X#1#{} Mult when scored.',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The Tower{} used.',
            '{C:attention}Non-face cards{} will always score.'
        }
        ,boxes={2,3,1}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        bonus_mod = 50,
        Xmult = 1, Xmult_mod = 0.2,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Rock!',
        },
    } },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_tower
        return { vars = {
            cae.Xmult, cae.Xmult_mod,
            cae.bonus_mod,
            Holo.mod_config.allow_profanity and 'Rock Hard' or 'More Solid',
        } }
    end,

    atlas = 'Relic_Advent',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_tower')
        if context.hololive_played_card then
            local v = context.hololive_played_card
            local is_stone = SMODS.has_enhancement(v, "m_stone")
            if is_stone then
                v.ability.bonus = v.ability.bonus + cae.bonus_mod
                SMODS.calculate_effect({message="Biboo!",colour = Holo.C.Biboo},v)
            end
        elseif context.individual and context.cardarea == G.play then
            local v = context.other_card
            if (SMODS.has_enhancement(v, "m_stone") or not v:is_face()) and (cae.Xmult > 1) then
                return {
                    Xmult = cae.Xmult,
                    colour = Holo.C.Biboo,
                }
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
            'will fall victim into {X:black,C:white}craziness{}.',
            'Gain {X:mult,C:white}X#2#{} mult after the chorus',
            'if everyone survived.'
        }
        ,boxes={2,2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 3,
        Xmult_mod = 0.3,
        upgrade_args = {
            scale_var = 'Xmult',
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return { vars = {
            cae.Xmult, cae.Xmult_mod,
        }}
    end,

    atlas = 'Relic_Advent',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                message = "Ope!",
                colour = Holo.C.Nerissa,
                Xmult = card.ability.extra.Xmult
            }
        elseif context.post_joker and not context.blueprint then
            if not Holo.series_or(context.scoring_hand, Card.is_face) then
                holo_card_upgrade(card)
            end
        elseif context.destroying_card then
            if context.destroying_card:is_face() then
                return { remove = true, sound = 'gong' }
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
            'Each played card with {V:1}odd{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}22{C:inactive} [#2#]',
            '{V:1}odd{} cards played.',
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers = 2,
        upgrade_args = {
            scale_var = 'retriggers',
            message = 'Baubau!'
        },
        count_args = {
            down = 22,
            init = 22
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_odd'}
        return { vars = {
            card.ability.extra.retriggers,
            card.ability.extra.count_args.down,
            colours = {Holo.C.Fuwawa}
        }}
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
                    colour = Holo.C.Fuwawa
                }
            end
        elseif context.hololive_played_card and not context.blueprint then
            local _rank = context.hololive_played_card:get_id()
            if (_rank == 14)or(_rank == 9)or(_rank == 7)or(_rank == 5)or(_rank == 3) then
                if holo_card_counting(card) then
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
            'Each played card with {V:1}even{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}22{C:inactive} [#2#]',
            '{V:1}even{} cards played.',
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers = 2,
        upgrade_args = {
            scale_var = 'retriggers',
            message = 'Baubau!'
        },
        count_args = {
            down = 22,
            init = 22
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_even'}
        return { vars = {
            card.ability.extra.retriggers,
            card.ability.extra.count_args.down,
            colours = {Holo.C.Mococo}
        }}
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
                    colour = Holo.C.Mococo
                }
            end
        elseif context.hololive_played_card and not context.blueprint then
            local _rank = context.hololive_played_card:get_id()
            if (_rank == 10)or(_rank == 8)or(_rank == 6)or(_rank == 4)or(_rank == 2) then
                if holo_card_counting(card) then
                    holo_card_upgrade(card)
                end
            end
        end
    end
}

----