----
SMODS.Atlas{
    key = "Relic_Promise",
    path = "Relic_Promise.png",
    px = 71,
    py = 95
}

SMODS.Joker{ -- IRyS
    key = "Relic_IRyS",
    talent = "IRyS",
    loc_txt = {
        name = "Sparklings of the Nephilim",
        text = {
            'Each time using a {C:blue}consumable{}',
            'grants you {C:attention}bonus income{},',
            'and has {C:green}#3# in #4#{} chance',
            'to increase said income by {C:money}$#2#{}.',
            '{C:inactive}(Currently {X:money,C:white}$#1#{C:inactive} income){}'
        }
    },
    config = { extra = { dollars = 6, dollars_mod = 1, odds = 6 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.dollars_mod,
                G.GAME.probabilities.normal,
                card.ability.extra.odds
            }
        }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Promise',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    upgrade = function (self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Wish!",colour = HEX("3c0024")})
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            card:juice_up()
            play_sound('generic1')
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Hope!",colour = HEX("3c0024")})
            ease_dollars(card.ability.extra.dollars)
            if pseudorandom('IRyS') < G.GAME.probabilities.normal / card.ability.extra.odds and not context.blueprint then
                self:upgrade(card)
            end
        end
    end
}

SMODS.Joker{ -- Tsukumo Sana
    key = "Relic_Sana",
    talent = "Sana",
    loc_txt = {
        name = "Size Limiter of the Astrogirl",
        text = {
            '{C:green}#3# in #4#{} chance to create the',
            '{C:planet}Planet{} card of played poker hand.',
            '(If no room, {C:attention}accumulate{} them until there is)',
            'Gain {X:mult,C:white}X#2#{} mult every time a {C:planet}Planet{} card',
            'is used since taking this relic.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={3,3}
    },
    config = { extra = { Xmult = 6, Xmult_mod = 0.6, odds = 3, bag_of_planets = {} } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.bag_of_planets then
            for _, _planet in ipairs(card.ability.extra.bag_of_planets) do
                info_queue[#info_queue+1] = G.P_CENTERS[_planet]
            end
        end
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.GAME.probabilities.normal,
                card.ability.extra.odds
            }
        }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Promise',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    update = function (self, card, dt)
        -- Release the planets until the consumable slot is full.
        if #card.ability.extra.bag_of_planets > 0 then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                local _planet = table.remove(card.ability.extra.bag_of_planets,1)
                SMODS.add_card({ key = _planet, area = G.consumeables})
            end
        end
    end,
    upgrade = function(self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Expand!",colour = HEX("fede4a")})
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == 'Planet' then
                self:upgrade(card)
            end
        elseif context.cardarea == G.jokers and context.scoring_hand then
            if context.before then
                if pseudorandom('sanana') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    -- Store the planet into the bag of planet.
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == context.scoring_name then
                            card.ability.extra.bag_of_planets[#card.ability.extra.bag_of_planets+1] = v.key
                            break
                        end
                    end
                    card:juice_up()
                    play_sound('highlight2')
                    card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Observed!',colour=HEX('fede4a')})
                end
            end
        elseif context.joker_main then
            card:juice_up()
            play_sound('gong')
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Space!',colour=HEX('fede4a')})
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{ -- Ceres Fauna
    key = "Relic_Fauna",
    talent = "Fauna",
    loc_txt = {
        name = "Golden Fruit of the Mother Nature",
        text = {
            'If played hand contains a {C:attention}Full House{}, create',
            'a {C:dark_edition}Negative {C:planet}Planet{} card of played poker hand.',
            'Gain {X:mult,C:white}X#2#{} mult every time',
            '{C:attention}Full House{} or {C:attention}Flush House{} is {C:planet}leveled up{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={2,3}
    },
    config = { extra = { Xmult = 6, Xmult_mod = 1 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_earth
        info_queue[#info_queue+1] = G.P_CENTERS.c_ceres
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod
            }
        }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Promise',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Grow!",colour = HEX("998274")})
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.before then
                local house_key = nil
                local house_message = nil
                if context.scoring_name == 'Full House' then
                    house_key = 'c_earth'
                    house_message = 'Earth!'
                elseif context.scoring_name == 'Flush House' then
                    house_key = 'c_ceres'
                    house_message = 'Ceres!'
                end
                if house_key then
                    card:juice_up()
                    play_sound('whoosh')
                    card_eval_status_text(card, 'jokers', nil, 1, nil, {message = house_message, colour=HEX('a4e5cf')})
                    SMODS.add_card({ key = house_key, area = G.consumeables, edition = 'e_negative' })
                end
            end
        elseif context.joker_main then
            card:juice_up()
            play_sound('gong')
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Nature!',colour=HEX('a4e5cf')})
            return {
                Xmult = card.ability.extra.Xmult
            }
        elseif context.level_up_hand == 'Full House' or context.level_up_hand == 'Flush House' then
            if context.level_up_amount > 0 then
                for i=1,context.level_up_amount do
                    self:upgrade(card)
                end
            end
        end
    end
}

SMODS.Joker{ -- Ouro Kronii
    key = "Relic_Kronii",
    talent = "Kronii",
    loc_txt = {
        name = "Clock Hands of the Time Warden",
        text = {
            'Create a {C:dark_edition}Negative {C:tarot}World{} card every {C:attention}12 {C:inactive}[#3#]{}',
            '{C:blue}played{} or {C:red}discarded{} cards with {C:spades}Spade{} suit.',
            'Gain {X:mult,C:white}X#2#{} mult every time a {C:tarot}World{} card',
            'is used since taking this relic.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={2,3}
    },
    config = { extra = { Xmult = 6, Xmult_mod = 1.5, count_down = 12} },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_world
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.count_down,
            }
        }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Promise',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    add_to_deck = function (self, card, from_debuff)
        card.ability.extra.Xmult = 6
        card.ability.extra.Xmult_mod = 1.5
        card.ability.extra.count_down = 12
    end,
    upgrade = function (self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        if card.ability.extra.Xmult % 3 == 1.5 then
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Tick!',colour=HEX('0869ec')})
        elseif card.ability.extra.Xmult % 3 == 0 then
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Tock!',colour=HEX('0869ec')})
        end
    end,
    calculate = function(self, card, context)
        if ((context.individual and context.cardarea == G.play) or context.discard)then
            if not context.other_card.debuff and context.other_card:is_suit("Spades") then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 12
                    card:juice_up()
                    SMODS.add_card({ key = 'c_world', area = G.consumeables, edition = 'e_negative' })
                end
            end
        elseif context.using_consumeable and not context.blueprint then
            if context.consumeable.config.center.key == 'c_world' then
                self:upgrade(card)
            end
        elseif context.joker_main then
            card:juice_up()
            play_sound('gong')
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Time!',colour=HEX('0869ec')})
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{ -- Nanashi Mumei
    key = "Relic_Mumei",
    talent = "Mumei",
    loc_txt = {
        name = "Dagger of the Guardian Owl",
        text = {
            'Each{C:red} discarded {C:attention}non{}-{C:spades}Spade{} card has {C:green}#3# in #4# chance{}',
            'to be {X:black,C:white}sacrificed{} for the {C:attention}civilization{}.',
            'Gain {X:mult,C:white}X#2#{} mult for each card destroyed.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={2,2}
    },
    config = { extra = { Xmult = 6, Xmult_mod = 1, odds = 6 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.GAME.probabilities.normal,
                card.ability.extra.odds
            }
        }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,

    atlas = 'Relic_Promise',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Develope!",colour = HEX("998274")})
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i=1, #context.removed do
                self:upgrade(card)
            end
        elseif context.discard then
            if not context.other_card:is_suit("Spades") then
                if pseudorandom('mumei') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    play_sound('slice1')
                    context.other_card:juice_up()
                    context.other_card:start_dissolve(nil, true)
                    for _,J in ipairs(G.jokres.cards) do
                        eval_card(J, {cardarea = G.jokers, remove_playing_cards = true, removed = {context.other_card,}})
                    end
                end
            end
        elseif context.joker_main then
            card:juice_up()
            play_sound('gong')
            card_eval_status_text(card, 'jokers', nil, 1, nil, {message='Civilization!',colour=HEX('998274')})
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{ -- Hakos Baelz
    key = "Relic_Bae",
    talent = "Bae",
    loc_txt = {
        name = "Rolling Dice of the Scarlet Rat",
        text = {
            'Roll a {C:red}six-sided die{} after each played hand.',
            'Multiplies all{C:attention} listed {C:green}probabilities{}',
            'with the number it lands.',
            '{C:inactive}(Currently {X:green,C:white}X#1#{C:inactive} Chance){}'
        }
    },
    config = { extra = { Pmult = 6 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Pmult } }
    end,
    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = false,

    atlas = 'Relic_Promise',
    pos = { x = 5, y = 0 },
    soul_pos = { x = 5, y = 1 },

    add_to_deck = function(self, card, from_debuff)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.Pmult
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.Pmult
    end,
    roll = function(self, card)
        card:juice_up()
        play_sound('timpani')
        card.ability.extra.Pmult = pseudorandom('Hakos Baelz', 1, 6)
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Roll!",colour = HEX("d2251e")})
    end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.jokers then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.Pmult
            self:roll(card)
            G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.Pmult
        end
    end
}

----