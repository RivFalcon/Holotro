----
SMODS.Atlas{
    key = "Relic_Advent",
    path = "Relic_Advent.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "Relic_Shiori",
    talent = "Shiori",
    loc_txt = {
        name = "Quill Pen of the Archiver",
        text = {
            'Retrigger all cards {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}23{C:inactive} [#2#] {}cards discarded.',
            'Discarded {C:attention}face cards{} get made into {X:black,C:white}bookmarks{}',
            'and will be properly {X:black,C:white}archived{}.'
        }
        ,boxes={2,2}
    },
    config = { extra = { retriggers = 1, count_down = 23 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Advent',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.retriggers = card.ability.extra.retriggers + 1
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Yoricked!",colour = HEX("373741")})
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.scoring_hand and context.full_hand then
            return {
                message = "Note!",
                repetitions = card.ability.extra.retriggers,
                card = card,
                colour = HEX("373741")
            }
        elseif context.discard and not context.blueprint then
            card.ability.extra.count_down = card.ability.extra.count_down - 1
            if card.ability.extra.count_down <= 0 then
                card.ability.extra.count_down = card.ability.extra.count_down + 23
                self:upgrade(card)
            end
            if context.other_card:is_face() then
                context.other_card:juice_up()
                card_eval_status_text(context.other_card, 'extra', nil, 1, nil, {message="Archived!",colour = HEX("373741")})
                context.other_card:start_dissolve(nil, true)
                -- "No no no, they were not destroyed, silly! I just took them to somewhere else!"
            end
        end
    end
}

SMODS.Joker{
    key = "Relic_Biboo",
    talent = "Biboo",
    loc_txt = {
        name = "Jewel Crown of the Ancient Rock",
        text = {
            '{C:attention}Stone cards{} become {C:attention}Rock Hard{}',
            'and give {C:chips}81,800{} extra chips when scored.',
            '{C:attention}Face cards{} held in hand',
            'get {X:black,C:white}petrified{} at end of round.'
        }
        ,boxes={2,2}
    },
    config = { extra = { } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_stone
        return { vars = { } }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Advent',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_stone") then
                card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Biboo!",colour = HEX("6e5bf4")})
                return {
                    card = context.other_card,
                    chips = 81800
                }
            end
        elseif context.individual and context.cardarea == G.hand and context.end_of_round then
            if context.other_card:is_face() then
                context.other_card:juice_up()
                play_sound('cancel')
                context.other_card:set_ability(G.P_CENTERS.m_stone, nil, true)
            end
        end
    end
}

SMODS.Joker{
    key = "Relic_Nerissa",
    talent = "Nerissa",
    loc_txt = {
        name = "Tuning Fork of the Raven Diva",
        text = {
            'Each played card {C:spectral}sings along with the tune{}',
            'and gives {X:mult,C:white} X#1# {} mult when scored.',
            '{C:attention}Face cards{} that joined the chorus',
            'will fall victim into {X:black,C:white}craziness{}.'
        }
        ,boxes={2,2}
    },
    config = { extra = { Xmult = 3 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

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

SMODS.Joker{
    key = "Relic_Fuwawa",
    talent = "Fuwawa",
    loc_txt = {
        name = "Claws of the Fluffy Hellhound",
        text = {
            'Each played card with {C:blue}odd{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}22{C:inactive} [#2#] {C:blue}odd{} cards.',
            '{C:inactive}(A, 9, 7, 5, 3){}'
        }
    },
    config = { extra = { retriggers = 2, count_down = 22 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Advent',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.retriggers = card.ability.extra.retriggers + 1
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Baubau!",colour = HEX("67b2ff")})
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.scoring_hand and context.full_hand then
            local _rank = context.other_card:get_id()
            if (_rank == 14)or(_rank == 9)or(_rank == 7)or(_rank == 5)or(_rank == 3) then
                return {
                    message = 'Bau!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    colour = HEX("67b2ff")
                }
            end
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            local _rank = context.other_card:get_id()
            if (_rank == 14)or(_rank == 9)or(_rank == 7)or(_rank == 5)or(_rank == 3) then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 22
                    self:upgrade(card)
                end
            end
        end
    end
}

SMODS.Joker{
    key = "Relic_Mococo",
    talent = "Mococo",
    loc_txt = {
        name = "Claws of the Fuzzy Hellhound",
        text = {
            'Each played card with {C:red}even{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger every {C:attention}22{C:inactive} [#2#] {C:red}even{} cards.',
            '{C:inactive}(10, 8, 6, 4, 2){}'
        }
    },
    config = { extra = { retriggers = 2, count_down = 22 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Advent',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.retriggers = card.ability.extra.retriggers + 1
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Baubau!",colour = HEX("f7a6ca")})
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.scoring_hand and context.full_hand then
            local _rank = context.other_card:get_id()
            if (_rank == 10)or(_rank == 8)or(_rank == 6)or(_rank == 4)or(_rank == 2) then
                return {
                    message = 'Bau!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    colour = HEX("f7a6ca")
                }
            end
        elseif context.individual and context.cardarea == G.play and not context.blueprint then
            local _rank = context.other_card:get_id()
            if (_rank == 10)or(_rank == 8)or(_rank == 6)or(_rank == 4)or(_rank == 2) then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 22
                    self:upgrade(card)
                end
            end
        end
    end
}

----