----
SMODS.Atlas{
    key = "Relic_Promise",
    path = "Relics/Relic_Promise.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- IRyS
    member = "IRyS",
    key = "Relic_IRyS",
    loc_txt = {
        name = "Sparklings of the Nephilim",
        text = {
            'Each time using a {V:1}consumable{} has',
            '{C:green}#3# in #4#{} chance  to grant you {C:money}$#1#{} bonus.',
            'Gain {C:money}$#2#{} bonus by using a {V:1}#5#{}.',
            'Consumeable changes at end of shop.'
        }
        ,boxes={3,1}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        dollars = 6, dollars_mod = 2,
        odds = 6,
        base = {key='c_fool',set='Tarot'},
        upgrade_args = {
            scale_var = 'dollars',
            message = "Ascend!",
            sound = 'coin2'
        }
    } },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.dollars,
                cae.dollars_mod,
                Holo.prob_norm(),
                cae.odds,
                localize{type='name_text',key=cae.base.key,set=cae.base.set},
                colours = {Holo.C.IRyS}
            }
        }
    end,

    atlas = 'Relic_Promise',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, cae.base.key)
        if context.using_consumeable then
            if Holo.chance('IRyS', cae.odds) then
                ease_dollars(cae.dollars)
                SMODS.calculate_effect({message='Hope!',colour=Holo.C.IRyS},card)
            end
        elseif context.ending_shop then
            local _pool_table = {}
            for _,v in ipairs(G.P_CENTER_POOLS.Tarot_Planet)do
                if not (v.config or{}).softlock then
                    _pool_table[v.key] = v.set
                end
            end
            for k,v in pairs(G.GAME.consumeable_usage)do
                if v.set ~= 'relicgacha' and not G.P_CENTERS[k].config.hidden then
                    _pool_table[k] = v.set
                end
            end
            local _pool = {}
            for k,v in pairs(_pool_table)do
                _pool[#_pool+1] = {key=k,set=v.set}
            end
            cae.base = pseudorandom_element(_pool, pseudoseed('ConsumeRyS'))
        end
    end
}

Holo.Relic_Joker{ -- Tsukumo Sana
    member = "Sana",
    key = "Relic_Sana",
    loc_txt = {
        name = "Size Limiter of the Astrogirl",
        text = {
            '{C:green}#3# in #4#{} chance to create the',
            '{C:planet}Planet card{} of played poker hand.',
            '(If no room, {C:attention}accumulate{} them until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:planet}Planet card{} used',
            'since taking this relic.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={3,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 6, Xmult_mod = 0.6,
        odds = 3, bag_of_planets = {},
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Expand!',
        }
    }},
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
                Holo.prob_norm(),
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Promise',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.using_consumeable then
            if context.consumeable.ability.set == 'Planet' and not context.blueprint then
                holo_card_upgrade(card)
            end
        elseif context.before then
            if Holo.chance('Sanana', cae.odds) then
                -- Store the planet into the bag of planet.
                local _planet = 'c_pluto'
                for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.config.hand_type == context.scoring_name then
                        _planet = v.key
                        break
                    end
                end
                if #G.consumeables.cards < G.consumeables.config.card_limit then
                    SMODS.add_card({ key = _planet, area = G.consumeables})
                elseif not context.blueprint then
                    cae.bag_of_planets[#cae.bag_of_planets+1] = _planet
                end
                return {
                    message = 'Observed!',
                    colour=Holo.C.Sana,
                }
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = cae.Xmult,
                message='Space!',
                colour=Holo.C.Sana,
                sound='gong'
            }
        end
        -- Release the planets from the bag until the consumable slot is full.
        local empty_consumable_slot_number = G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer)
        local _iter = math.min(#cae.bag_of_planets, empty_consumable_slot_number)
        for _=1,_iter do
            local _planet = table.remove(cae.bag_of_planets,1)
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({ key = _planet, area = G.consumeables})
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    return true
                end
            }))
        end
    end
}

Holo.Relic_Joker{ -- Ceres Fauna
    member = "Fauna",
    key = "Relic_Fauna",
    loc_txt = {
        name = "Golden Fruit of the Mother Nature",
        text = {
            'If played hand contains a {C:attention}Full House{}, create',
            'a {C:dark_edition}Negative {C:planet}Planet card{} of played poker hand.',
            'Gain {X:mult,C:white}X#2#{} mult every time',
            '{C:attention}Full House{} or {C:attention}Flush House{} is {C:planet}leveled up{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={2,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 6, Xmult_mod = 1,
        upgrade_args = {
            scale_var = 'Xmult',
            message = "Grow!",
        }
    }},
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

    atlas = 'Relic_Promise',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
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
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        SMODS.add_card({ key = house_key, area = G.consumeables, edition = 'e_negative' })
                        return true
                    end
                }))
                return {
                    message = house_message,
                    colour=Holo.C.Fauna
                }
            end
        elseif context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult,
                message='Nature!',
                colour=Holo.C.Fauna,
                sound = 'gong',
            }
        elseif (context.level_up_hand == 'Full House' or context.level_up_hand == 'Flush House') and not context.blueprint then
            if context.level_up_amount > 0 then
                for i=1,context.level_up_amount do
                    holo_card_upgrade(card)
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Ouro Kronii
    member = "Kronii",
    key = "Relic_Kronii",
    loc_txt = {
        name = "Clock Hands of the Time Warden",
        text = {
            'Create a {C:dark_edition}Negative {C:tarot}World{} every {C:attention}12 {C:inactive}[#3#]{}',
            '{C:blue}played{} or {C:red}discarded{} cards with {C:spades}Spade{} suit.',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The World{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 6, Xmult_mod = 1.5,
        upgrade_args = {
            scale_var = 'Xmult',
        },
        count_args = {
            down = 12,
            init = 12
        }
    }},
    upgrade_func = function(card)
        local cae = card.ability.extra
        cae.tick = not cae.tick
        cae.upgrade_args.message = cae.tick and 'Tick!' or 'Tock!'
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_world
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.count_args.down,
            }
        }
    end,

    atlas = 'Relic_Promise',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_world')
        if ((context.individual and context.cardarea == G.play) or context.discard) and not context.blueprint then
            if not context.other_card.debuff and context.other_card:is_suit("Spades") then
                if holo_card_counting(card) then
                    Holo.try_add_consumeable('c_world', true)
                end
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                message='Time!',
                colour=Holo.C.Kronii,
                sound = 'gong',
            }
        end
    end
}

Holo.Relic_Joker{ -- Nanashi Mumei
    member = "Mumei",
    key = "Relic_Mumei",
    loc_txt = {
        name = "Dagger of the Guardian Owl",
        text = {
            'Each{C:red} discarded {C:attention}non{}-{C:spades}Spade{} card',
            'has {C:green}#3# in #4#{} chance to be {X:black,C:white}sacrificed',
            'for the {C:attention}civilization{}.',
            'Gain {X:mult,C:white}X#2#{} mult for each card destroyed.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 6, Xmult_mod = 1,
        odds = 6,
        upgrade_args = {
            scale_var = 'Xmult',
            message = "Develope!",
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                Holo.prob_norm(),
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Promise',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for i=1, #context.removed do
                holo_card_upgrade(card)
            end
        elseif context.discard then
            if not context.other_card:is_suit("Spades") then
                if Holo.chance('Mumei', card.ability.extra.odds) then
                    return {
                        remove = true,
                        sound='slice1',
                    }
                end
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = card.ability.extra.Xmult,
                message='Civilization!',
                colour=Holo.C.Mumei,
                sound = 'gong',
            }
        end
    end
}

Holo.Relic_Joker{ -- Hakos Baelz
    member = "Bae",
    key = "Relic_Bae",
    loc_txt = {
        name = "Rolling Dice of the Scarlet Rat",
        text = {
            'Roll a {V:1}six-sided die',
            'after each played hand.',
            'Multiplies all listed {C:green}probabilities',
            'with the number it lands.',
            'Gain {X:mult,C:white}X#2#{} mult when it lands on {C:green}1{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult and {C:green}X#3#{C:inactive} Chance)'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Pmult = 6,
        Xmult = 6, Xmult_mod = 2,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Roll!',
        }
    } },
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return { vars = {
            cae.Xmult, cae.Xmult_mod,
            cae.Pmult,
            colours = {Holo.C.Bae}
        }}
    end,

    atlas = 'Relic_Promise',
    pos = { x = 5, y = 0 },
    soul_pos = { x = 5, y = 1 },

    add_to_deck = function(self, card, from_debuff)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.Pmult
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.Pmult
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        local prob = G.GAME.probabilities
        if context.after and context.cardarea == G.jokers and not context.blueprint then
            prob.normal = prob.normal / cae.Pmult
            card:juice_up()
            cae.Pmult = pseudorandom('Hakos Baelz', 1, 6)
            prob.normal = prob.normal * cae.Pmult
            if cae.Pmult == 1 then
                holo_card_upgrade(card)
            else
                return {
                    message="Roll!",
                    colour = Holo.C.Bae,
                }
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                message = 'Chaos!',
                colour = Holo.C.Bae,
                sound = 'gong',
            }
        end
    end
}

----