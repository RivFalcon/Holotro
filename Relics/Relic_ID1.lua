----
SMODS.Atlas{
    key = "Relic_Area15",
    path = "Relic_Area15.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "Relic_Risu",
    talent = "Risu",
    colour = HEX('EF8381'),
    loc_txt = {
        name = "\"Deez Nuts\" of the Squirrel",
        text = {
            'Every {C:attention}3{} cards with {C:clubs}Club{} suit held in hand',
            'will be clubin\' deez nuts and give {X:mult,C:white} X15 {} Mult.'
        }
    },
    config = { extra = { clubbin = 3 } },
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.clubbin = 3
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    rarity = "hololive_Relic",
    cost = 20,

    atlas = 'Relic_Area15',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0 , y = 1 },

    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.clubbin = 3
        elseif context.individual and context.cardarea == G.hand then
            if not context.after and not context.end_of_round then
                if context.other_card:is_suit("Clubs") then
                    if context.other_card.debuff then
                        return {
                            message = localize("k_debuffed"),
                            colour = G.C.RED,
                            card = card,
                        }
                    elseif card.ability.extra.clubbin == 3 then
                        card.ability.extra.clubbin = 2
                        return {
                            message = 'Clubbin\'',
                            colour = card.colour,
                            card = context.other_card
                        }
                    elseif card.ability.extra.clubbin == 2 then
                        card.ability.extra.clubbin = 1
                        return {
                            message = 'Deez',
                            colour = card.colour,
                            card = context.other_card
                        }
                    elseif card.ability.extra.clubbin == 1 then
                        card.ability.extra.clubbin = 3
                        return {
                            message = 'NUTS!',
                            card = context.other_card,
                            Xmult_mod = 15
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{
    key = "Relic_Moona",
    talent = "Moona",
    loc_txt = {
        name = "Phases of the Lunar Diva",
        text = {
            'For every {C:attention}15{} {C:inactive}[#3#]{} scored cards with {C:clubs}Club{} suit',

            'create a {C:tarot}#4#{} and gain {X:mult,C:white} X#1# {} Mult.',
            '{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult){}'

            --'create a {C:tarot}#4#{}.',
            --'Each {C:tarot}Moons{} in your {C:attention}consumable{}',
            --'area gives {X:mult,C:white} X#2# {} Mult.'
        }
    },
    config = { extra = { Xmult = 3, Xmult_mod = 1.5, scored_card = 15, phase = "Full Moon" } },
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.Xmult = 3
        card.ability.extra.Xmult_mod = 1.5
        card.ability.extra.scored_card = 15
        card.ability.extra.phase = "Full Moon"
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_moon
        return {
            vars = {
                card.ability.extra.Xmult_mod,
                card.ability.extra.Xmult,
                card.ability.extra.scored_card,
                card.ability.extra.phase
            }
        }
    end,
    rarity = "hololive_Relic",
    cost = 20,

    atlas = 'Relic_Area15',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1 , y = 1 },

    upgrade = function(self, card)
        card:juice_up(0.5, 0.5)
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        if card.ability.extra.phase == "Full Moon" then
            SMODS.add_card({ key = 'c_moon', area = G.consumeables })
            card.ability.extra.phase = "New Moon"
            return {
                message = "Full Moon!",
                colour = G.C.PURPLE,
                card = card
            }
        elseif card.ability.extra.phase == "New Moon" then
            SMODS.add_card({ key = 'c_moon', area = G.consumeables , edition = 'e_negative' })
            card.ability.extra.phase = "Full Moon"
            return {
                message = "New Moon!",
                colour = G.C.PURPLE,
                card = card
            }
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if not context.other_card.debuff and context.other_card:is_suit("Clubs") then
                card.ability.extra.scored_card = card.ability.extra.scored_card - 1
                if card.ability.extra.scored_card <= 0 then
                    card.ability.extra.scored_card = card.ability.extra.scored_card + 15
                    self:upgrade(card)
                end
            end
        elseif context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{
    key = "Relic_Iofi",
    talent = "Iofi",
    loc_txt = {
        name = "Paintbrush of the Alien Artist",
        text = {
            'Played cards get {C:attention}painted{} into {C:clubs}Club{} suit.',
            'Gain {X:mult,C:white} X#1# {} Mult every {C:attention}3{} {C:inactive}[#3#]{} cards with {C:clubs}Club{} suit',
            'get painted with {C:clubs}Club{} suit again.',
            '(Currently {X:mult,C:white} X#2# {} Mult)'
        }
    },
    config = { extra = { Xmult = 3, Xmult_mod = 1.5, scored_card = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.Xmult_mod,
            card.ability.extra.Xmult,
            card.ability.extra.scored_card,
        }}
    end,
    rarity = "hololive_Relic",
    cost = 20,

    atlas = 'Relic_Area15',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2 , y = 1 },

    upgrade = function(self, card)
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        return {
            message = "Upgrade!",
            colour = G.C.XMULT,
            card = card
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.full_hand then
            for i=1, #context.full_hand do
                if card.full_hand[i]:is_suit("Clubs") and not context.blueprint then
                    card.ability.extra.scored_card = card.ability.extra.scored_card - 1
                    if card.ability.extra.scored_card <= 0 then
                        card.ability.extra.scored_card = 3
                        self:upgrade(card)
                    end
                else
                    context.full_hand[i]:change_suit("Clubs")
                end
                context.full_hand[i]:juice_up()
            end
            return {
                message = "Painted!",
                card = card
            }
        elseif context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
}


----