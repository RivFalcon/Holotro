----
SMODS.Atlas{
    key = "Relic_Advent",
    path = "Relic_Advent.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "Relic_Fuwawa",
    talent = "Fuwawa",
    loc_txt = {
        name = "Claws of the Fluffy Hellhound",
        text = {
            'Each played card with {C:blue}odd{} rank',
            'is retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger after scoring #2# {C:blue}odd{} cards.',
            '{C:inactive}(A, 9, 7, 5, 3){}'
        }
    },
    config = { extra = { retriggers = 2, count_down = 22 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,
    rarity = "hololive_Relic",
    cost = 20,

    atlas = 'Relic_Advent',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        self.config.extra.retriggers = self.config.extra.retriggers + 1
        return {message="Baubau!",colour = HEX("67b2ff")}
    end,
    calculate = function(self, card, context)
        if context.other_card then
            local _rank = context.other_card:get_id()
            if (_rank == 10)or(_rank == 8)or(_rank == 6)or(_rank == 4)or(_rank == 2) then
                if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
                    return {
                        message = "Bau!",
                        repetitions = card.ability.extra.retriggers,
                        card = card,
                        colour = HEX("67b2ff")
                    }
                elseif (context.individual or context.repetition) and context.cardarea == G.play then
                    card.ability.extra.count_down = card.ability.extra.count_down - 1
                    if card.ability.extra.count_down <= 0 then
                        card.ability.extra.count_down = card.ability.extra.count_down + 22
                        return self:upgrade(card)
                    end
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
            '{C:attention}+1{} retrigger after scoring #2# {C:red}even{} cards.',
            '{C:inactive}(10, 8, 6, 4, 2){}'
        }
    },
    config = { extra = { retriggers = 2, count_down = 22 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers, card.ability.extra.count_down } }
    end,
    rarity = "hololive_Relic",
    cost = 20,

    atlas = 'Relic_Advent',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        self.config.extra.retriggers = self.config.extra.retriggers + 1
        return {message="Baubau!",colour = HEX("f7a6ca")}
    end,
    calculate = function(self, card, context)
        if context.other_card then
            local _rank = context.other_card:get_id()
            if (_rank == 14)or(_rank == 9)or(_rank == 7)or(_rank == 5)or(_rank == 3) then
                if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
                    return {
                        message = "Bau!",
                        repetitions = card.ability.extra.retriggers,
                        card = card,
                        colour = HEX("f7a6ca")
                    }
                elseif (context.individual or context.repetition) and context.cardarea == G.play then
                    card.ability.extra.count_down = card.ability.extra.count_down - 1
                    if card.ability.extra.count_down <= 0 then
                        card.ability.extra.count_down = card.ability.extra.count_down + 22
                        return self:upgrade(card)
                    end
                end
            end
        end
    end
}

----