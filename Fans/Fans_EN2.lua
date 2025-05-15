----

Holo.Fan_card{ -- IRyStocrat
    member = 'IRyS',
    order = 45,
    key = 'fans_irystocrat',
    loc_txt = {
        name = 'Irystocrat',
        text = {
            'Gives {V:1}#3#{} times the total',
            'sell value of all',
            'current {C:attention}consumeables{}.',
            '{C:inactive}(Max of {C:money}$#1#{C:inactive}, currently {C:money}$#2#{C:inactive})'
        }
    },
    config = {
        money = 0,
        max_dollars = 37,
        money_mult = 6,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.max_dollars,
                card.ability.money,
                card.ability.money_mult,
                colours = {Holo.C.IRyS}
            }
        }
    end,
    effect = "Consumeable Payout",
    atlas='holo_fandoms_3',
    pos={y=1,x=4},

    can_use = function (self, card)
        return true
    end,
    update = function (self, card, dt)
        if G.STAGE == G.STAGES.RUN then
            local total_sell_value = 0
            for _,v in ipairs(G.consumeables.cards) do
                if v.ability.consumeable then
                    total_sell_value = total_sell_value + v.sell_cost
                end
            end
            card.ability.money = math.min(total_sell_value * card.ability.money_mult, card.ability.max_dollars)
        end
    end,
    use = function(self, card, area, copier)
        Holo.juice_on_use(card)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            ease_dollars(card.ability.money, true)
            return true end
        }))
        delay(0.6)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Sanalite
    member = 'Sana',
    order = 46,
    key = 'fans_sanallite',
    loc_txt = {
        name = 'Sanallite',
        text = {
            'Creates {C:attention}2 {C:dark_edition}Negative{} copies',
            'of the last {C:planet}Planet{} card',
            'used during this run.'
        }
    },
    config = {},
    loc_vars = function (self, info_queue, card)
        local bread_c = G.GAME.last_planet and G.P_CENTERS[G.GAME.last_planet] or nil
        local last_planet = bread_c and localize{type = 'name_text', key = bread_c.key, set = bread_c.set} or localize('k_none')
        local colour = (not bread_c) and G.C.RED or G.C.GREEN
        local main_end = {
            {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                    {n=G.UIT.T, config={text = ' '..last_planet..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }
        if bread_c then
            info_queue[#info_queue+1] = bread_c
        end
        return { main_end = main_end }
    end,
    effect = "Card Creation",
    atlas='holo_fandoms_3',
    pos={y=2,x=0},

    can_use = function(self, card)
        if G.GAME.last_planet then return true end
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            for _=1,2 do
                play_sound('timpani')
                SMODS.add_card({key = G.GAME.last_planet, area = G.consumeables, edition = 'e_negative'})
                card:juice_up(0.3, 0.5)
            end
        return true end}))
        delay(0.6)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Sapling
    member = 'Fauna',
    order = 47,
    key = 'fans_sapling',
    loc_txt = {
        name = 'Sapling',
        text = {
            'Select {C:attention}2{} cards with',
            '{C:attention}different ranks{}, randomly',
            'converts all cards in hand',
            'to {C:attention}ranks{} of {C:attention}selected cards{}.'
        }
    },
    effect = "Rank Conversion",
    atlas='holo_fandoms_3',
    pos={y=2,x=1},

    can_use = function (self, card)
        if not G.hand or not G.hand.highlighted then return false end
        if #G.hand.highlighted ~= 2 then return false end
        local c1, c2 = G.hand.highlighted[1], G.hand.highlighted[2]
        local r1, r2 = Holo.rank_suffice[c1:get_id()], Holo.rank_suffice[c2:get_id()]
        if r1 and r2 and (r1~=r2) then return true end
    end,
    use = function(self, card, area, copier)
        update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        Holo.juice_on_use(card)
        local unselected_cards = Holo.flip_cards_in_hand('low')
        delay(0.2)

        local _ranks = {G.hand.highlighted[1]:get_id(), G.hand.highlighted[2]:get_id()}
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for _,v in ipairs(unselected_cards) do
                Holo.change_rank(v, pseudorandom_element(_ranks, pseudoseed('Sapling')))
            end
        return true end }))

        Holo.flip_cards_in_hand('low',true)
        Holo.unhighlight_all()
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Kronie
    member = 'Kronii',
    order = 48,
    key = 'fans_kronie',
    loc_txt = {
        name = 'Kronie',
        text = {
            'Converts all',
            'cards in hand',
            'to {C:spades}Spades{}.'
        }
    },
    config = {suit_conv = 'Spades'},
    effect = "Suit Conversion",
    atlas='holo_fandoms_3',
    pos={y=2,x=2},

    can_use = function(self, card)
        if G.hand and G.hand.cards and #G.hand.cards>0 then
            return true
        end
    end,
    use = function(self, card, area, copier)
        Holo.juice_on_use(card)
        Holo.flip_cards_in_hand('all')
        delay(0.2)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for _,v in ipairs(G.hand.cards) do
                v:change_suit(self.config.suit_conv)
            end
        return true end }))
        Holo.flip_cards_in_hand('all',true)
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Hooman
    member = 'Mumei',
    order = 49,
    key = 'fans_hooman',
    loc_txt = {
        name = 'Hooman',
        text = {
            'Sacrifices up to {C:attention}#1#{} selected',
            '{C:attention}non{}-{C:spades}Spade{} cards',
            'for the civilization.',
            'Rerolls the next {C:attention}Boss Blind',
            'if no cards were selected.'
        }
        ,boxes={3,2}
    },
    config = {max_highlighted = 3},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_boss
        return {vars={card.ability.max_highlighted}}
    end,
    effect = "Card Removal",
    atlas='holo_fandoms_3',
    pos={y=2,x=3},

    can_use = function (self, card)
        if #G.hand.highlighted > card.ability.max_highlighted then
            return false
        end
        if #G.hand.highlighted >= 1 then
            for _,v in ipairs(G.hand.highlighted)do
                if v:is_suit('Spades')then
                    return false
                end
            end
            return true
        end
        if G.GAME.blind:get_type() ~= 'Boss' then
            return true
        end
    end,
    use = function (self, card, area, copier)
        if #G.hand.highlighted >= 1 then
            local destroyed_cards = {}
            for i=#G.hand.highlighted, 1, -1 do
                destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
            end
            update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
            Holo.juice_on_use(card)

            Holo.delayed_destruction(destroyed_cards)
            delay(0.3)
            SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
        else
            Holo.juice_on_use(card)
            G.from_boss_tag = true
            G.FUNCS.reroll_boss()
        end
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- BRat
    member = 'Bae',
    order = 50,
    key = 'fans_brat',
    loc_txt = {
        name = 'BRat',
        text = {
            'Increases {V:1}Rat Index',
            'by {C:green}X1{} for this run.'
        }
    },
    loc_vars = function (self, info_queue, card)
        if G.GAME then
            G.GAME.holo_rat_index = G.GAME.holo_rat_index or 1
        end
        info_queue[#info_queue+1] = {set='Other',key='holo_info_rat_index',vars={(G.GAME or{}).holo_rat_index or 1},}
        return {
            vars = {
                colours = {Holo.C.Bae}
            }
        }
    end,
    atlas='holo_fandoms_3',
    pos={y=2,x=4},

    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        Holo.juice_on_use(card)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,func = function()
            local prob = G.GAME.probabilities
            G.GAME.holo_rat_index = G.GAME.holo_rat_index or 1
            prob.normal = prob.normal / G.GAME.holo_rat_index
            G.GAME.holo_rat_index = G.GAME.holo_rat_index + 1
            prob.normal = prob.normal * G.GAME.holo_rat_index
        return true end}))
        holo_fan_cheers(self.member)
    end
}

----