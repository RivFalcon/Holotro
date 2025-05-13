----
SMODS.Atlas{
    key = "Relic_Area15",
    path = "Relics/Relic_Area15.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Ayunda Risu
    member = "Risu",
    key = "Relic_Risu",
    loc_txt = {
        name = "\"Deez Nuts\" of the Squirrel",
        text = {
            'Every {C:attention}3{} cards with {C:clubs}Club{} suit held in hand',
            'will be {C:clubs}#1#{} and give {X:mult,C:white} X15 {} Mult.'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        clubbin = 3, effect = "clubin\' deez nuts",
    }},
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.clubbin = 3
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.effect
            }
        }
    end,
    blueprint_compat = false,

    atlas = 'Relic_Area15',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0 , y = 1 },

    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.clubbin = 3
        elseif context.individual and context.cardarea == G.hand and not context.end_of_round then
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
                        colour = Holo.C.Risu,
                        card = context.other_card
                    }
                elseif card.ability.extra.clubbin == 2 then
                    card.ability.extra.clubbin = 1
                    return {
                        message = 'Deez',
                        colour = Holo.C.Risu,
                        card = context.other_card
                    }
                elseif card.ability.extra.clubbin == 1 then
                    card.ability.extra.clubbin = 3
                    return {
                        message = 'NUTS!',
                        colour = HEX('ad6e4f'),
                        card = context.other_card,
                        Xmult_mod = 15
                    }
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Moona Hoshinova
    member = "Moona",
    key = "Relic_Moona",
    loc_txt = {
        name = "Phases of the Lunar Diva",
        text = {
            'For every {C:attention}15{} {C:inactive}[#3#]{} scored',
            'cards with {C:clubs}Club{} suit,',
            'create a {C:tarot}#4#{}.',
            'Gain {X:mult,C:white}X#1#{} Mult per {C:tarot}The Moon{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 3, Xmult_mod = 1.5,
        phase = "moon_full",
        upgrade_args = {
            scale_var = 'Xmult',
        },
        count_args = {
            down = 15,
            init = 15
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_moon
        return {
            vars = {
                card.ability.extra.Xmult_mod,
                card.ability.extra.Xmult,
                card.ability.extra.count_args.down,
                localize("k_hololive_"..card.ability.extra.phase)
            }
        }
    end,

    atlas = 'Relic_Area15',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1 , y = 1 },

    calculate = function(self, card, context)
        holo_card_upgrade_by_consumeable(card, context, 'c_moon')
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if not context.other_card.debuff and context.other_card:is_suit("Clubs") then
                if holo_card_counting(card) then
                    SMODS.calculate_effect({
                        message=localize("k_hololive_"..card.ability.extra.phase),
                        colour=Holo.C.Moona,
                    },card)
                    if card.ability.extra.phase == "moon_full" then
                        SMODS.add_card({ key = 'c_moon', area = G.consumeables })
                        card.ability.extra.phase = "moon_new"
                    elseif card.ability.extra.phase == "moon_new" then
                        SMODS.add_card({ key = 'c_moon', area = G.consumeables , edition = 'e_negative' })
                        card.ability.extra.phase = "moon_full"
                    end
                end
            end
        elseif context.joker_main then
            return {
                Xmult_mod = card.ability.extra.Xmult,
                colour=Holo.C.Moona,
            }
        end
    end
}

Holo.Relic_Joker{ -- Airani Iofifteen
    member = "Iofi",
    key = "Relic_Iofi",
    loc_txt = {
        name = "Paintbrush of the Alien Artist",
        text = {
            'Played cards get {C:attention}painted{} into {C:clubs}Club{} suit.',
            'Gain {X:mult,C:white} X#1# {} Mult every {C:attention}3{} {C:inactive}[#3#]{} cards with {C:clubs}Club{} suit',
            'get painted with {C:clubs}Club{} suit again.',
            '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 3, Xmult_mod = 1.5,
        upgrade_args = {
            scale_var = 'Xmult',
        },
        count_args = {
            down = 3,
            init = 3
        }
    } },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.extra.Xmult_mod,
            card.ability.extra.Xmult,
            card.ability.extra.count_args.down,
        }}
    end,

    atlas = 'Relic_Area15',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2 , y = 1 },

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for i,v in ipairs(context.full_hand) do
                if v:is_suit("Clubs") then
                    if holo_card_counting(card) then
                        holo_card_upgrade(card)
                    end
                else
                    v:change_suit("Clubs")
                end
                v:juice_up()
            end
            return {
                message = "Painted!",
                card = card,
                colour = Holo.C.Iofi
            }
        elseif context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult,
                colour = Holo.Iofi
            }
        end
    end
}


----