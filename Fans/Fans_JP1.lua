----

Holo.Fan_card{ -- Kapumin
    member = 'Mel',
    order = 4,
    key = 'fans_kapumin',
    loc_txt = {
        name = 'Kapumin',
        text = {
            'Unenhance up to {C:attention}#1#{} selected',
            'enhanced cards, and gain',
            '{C:money}$#2#{} for each unenhancing.',
        }
    },
    config = {
        max_highlighted = 4,
        min_highlighted = 1,
        mod_conv = 'c_base',
        extra = 3,
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.max_highlighted,
                card.ability.extra,
            }
        }
    end,
    atlas='holo_fandoms_1',
    pos={y=1,x=0},

    can_use = function(self, card)
        if #G.hand.highlighted > card.ability.max_highlighted then return false end
        if #G.hand.highlighted < card.ability.min_highlighted then return false end
        for _,v in ipairs(G.hand.highlighted)do
            if SMODS.has_enhancement(v, 'c_base') then return false end
        end
        return true
    end,
    use = function(self, card, area, copier)
        Holo.reset_hand_text()
        Holo.juice_on_use(card)
        delay(0.2)

        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:juice_up()
                G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
                ease_dollars(card.ability.extra,true)
            return true end }))
        end

        Holo.unhighlight_all()
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Sukonbu
    member = 'Fubuki',
    order = 5,
    key = 'fans_sukonbu',
    loc_txt = {
        name = 'Sukonbu',
        text = {
            'Creates the last used',
            '{C:tarot}Tarot{}, {C:planet}Planet{}, or {C:spectral}Spectral',
            'card during this run.',
            '{C:inactive}(Must have room)',
        }
    },
    config = {},
    loc_vars = function(self, info_queue, card)
        local last_used = G.GAME and G.GAME.last_used or {}
        local main_end = {}
        for _,set in ipairs({'Tarot','Planet','Spectral'})do
            if last_used[set] then
                local _c = last_used[set]
                local last_c = localize{type = 'name_text', key = _c, set = set}
                main_end[#main_end+1] = Holo.create_main_end_node(last_c,G.C.SECONDARY_SET[set])
                info_queue[#info_queue+1] = G.P_CENTERS[_c]
            end
        end
        if #main_end == 0 then
            main_end[#main_end+1] = Holo.create_main_end_node()
        end

        return {
            main_end = G.GAME and G.GAME.last_used and main_end or nil,
        }
    end,
    effect = "Create last used consumeable",
    atlas='holo_fandoms_1',
    pos={y=1,x=1},

    can_use = function(self, card)
        local have_room = (#G.consumeables.cards < G.consumeables.config.card_limit) or false
        local last_used = G.GAME and G.GAME.last_used or {}
        if (have_room or (card.area == G.consumeables and not (card.edition or {}).negative))
        and (last_used.Tarot or last_used.Planet or last_used.Spectral) then return true end
    end,
    use = function(self, card, area, copier)
        local last_used = G.GAME and G.GAME.last_used or {}
        local used_vouchers = G.GAME.used_vouchers or {}
        local weight_table = {}
        if last_used.Tarot then
            weight_table[last_used.Tarot] = (used_vouchers.v_tarot_tycoon and 8) or (used_vouchers.v_tarot_merchant and 4) or 2
        end
        if last_used.Planet then
            weight_table[last_used.Planet] = (used_vouchers.v_planet_tycoon and 8) or (used_vouchers.v_planet_merchant and 4) or 2
        end
        if last_used.Spectral then
            weight_table[last_used.Spectral] = ((G.GAME.selected_back.name == 'Ghost Deck') and 4) or 1
        end
        local _key = Holo.pseudorandom_weighted_element(weight_table,'Sukonbu')
        if (_key == last_used.Tarot)and last_used.Spectral and used_vouchers.v_omen_globe then
            if pseudorandom('omen_globe_sukonbu')>0.8 then
                _key = last_used.Spectral
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('timpani')
            SMODS.add_card({key = _key, area = G.consumeables})
            card:juice_up(0.3, 0.5)
        return true end}))
        delay(0.6)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Matsurisu
    member = 'Matsuri',
    order = 6,
    key = 'fans_matsurisu',
    loc_txt = {
        name = 'Matsurisu',
        text = {
            'Destroys {C:attention}1{} random card in',
            'your hand, but adds {C:attention}#1#{} random',
            '{C:attention}Unenhanced {C:hearts}Heart {}cards.',
        }
    },
    config = {extra = 5},
    loc_vars = function(self, info_queue, card)
        return {vars={card.ability.extra}}
    end,
    effect = "",
    atlas='holo_fandoms_1',
    pos={y=1,x=2},

    can_use = function(self, card)
        if G.hand and G.hand.cards and #G.hand.cards>0 then
            return true
        end
    end,
    use = function(self, card, area, copier)
        Holo.juice_on_use(card)

        local destroyed_cards = {}
        destroyed_cards[#destroyed_cards+1] = pseudorandom_element(G.hand.cards, pseudoseed('Matsurisu_destroy'))
        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.7,func = function()
            local cards = {}
            for i = 1, card.ability.extra do
                local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('Matsurisu_rank')).card_key
                cards[i] = create_playing_card(
                    {front = G.P_CARDS['H_'.._rank], center = G.P_CENTERS.c_base},
                    G.hand, nil, i ~= 1, { Holo.C.Matsuri }
                )
            end
            playing_card_joker_effects(cards)
        return true end}))

        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Rose-tai
    member = 'Aki',
    order = 7,
    key = 'fans_rosetai',
    loc_txt = {
        name = 'Rose-tai',
        text = {
            'Increases {C:money}sell value{} of',
            'each current Joker by {C:money}$1{}.',
            'If a Joker is {C:attention}selected{},',
            'increases the {C:money}sell value{}',
            'of this Joker by {C:money}$1',
            'for each current Joker.',
        }
        ,boxes={2,4}
    },
    config = {},
    loc_vars = function(self, info_queue, card)
        return {

        }
    end,
    --effect = "",
    atlas='holo_fandoms_1',
    pos={y=1,x=3},

    can_use = function(self, card)
        return (#G.jokers.cards > 0)
    end,
    use = function(self, card, area, copier)
        Holo.juice_on_use(card)
        local selected = G.jokers and G.jokers.highlighted and G.jokers.highlighted[1] or nil

        for _,v in ipairs(G.jokers.cards) do
            local J = selected or v
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.7,func = function()
                v:juice_up()
                play_sound('timpani')
                J.sell_cost = J.sell_cost + 1
            return true end}))
            SMODS.calculate_effect({message='+$1',colour=G.C.MONEY,sound='coin1'},J)
        end

        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{
    member = 'Haato',
    order = 8,
    key = 'fans_haaton',
    loc_txt = {
        name = 'Haaton',
        text = {
            'Converts all',
            'cards in hand',
            'to {C:hearts}Hearts{}.'
        }
    },
    config = {suit_conv = 'Hearts'},
    effect = "Suit Conversion",
    atlas='holo_fandoms_1',
    pos={y=1,x=4},

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

----