----

Holo.Fan_card{ -- Novelite
    member = 'Shiori',
    order = 59,
    key = 'fans_novelite',
    loc_txt = {
        name = 'Novelite',
        text = {
            'Destroys at least {C:attention}#1#',
            'selected {C:attention}face cards',
            'and spawn a',
            '{C:attention}Spared Discard Tag{}.'
        }
    },
    config = { min_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_hololive_spared_discard
        return {vars={card.ability.min_highlighted}}
    end,
    effect = "Card Removal",
    atlas='holo_fandoms_4',
    pos={y=0,x=0},

    can_use = function (self, card)
        if #G.hand.highlighted < card.ability.min_highlighted then
            return false
        end
        for _,v in ipairs(G.hand.highlighted)do
            if not v:is_face() then return false end
        end
        return true
    end,
    use = function (self, card, area, copier)
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        Holo.reset_hand_text()
        Holo.juice_on_use(card)

        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_hololive_spared_discard'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Pebble
    member = 'Biboo',
    order = 60,
    key = 'fans_pebble',
    loc_txt = {
        name = 'Pebble',
        text = {
            'Enhances {C:attention}#1#{} selected',
            'cards to {C:attention}Stone Cards{}.'
        }
    },
    config = {
        max_highlighted = 3,
        mod_conv = 'm_stone',
    },
    loc_vars = function (self, info_queue, card)
        return {vars={card.ability.max_highlighted}}
    end,
    effect = "Enhance",
    atlas='holo_fandoms_4',
    pos={y=0,x=1},

    use = function (self, card, area, copier)
        Holo.reset_hand_text()
        Holo.juice_on_use(card)
        Holo.flip_cards_in_hand('high')
        delay(0.2)
    
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.ability.mod_conv])
            return true end }))
        end
        Holo.flip_cards_in_hand('high', true)
        Holo.unhighlight_all()
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Jailbird
    member = 'Nerissa',
    order = 61,
    key = 'fans_jailbird',
    loc_txt = {
        name = 'Jailbird',
        text = {
            'Destroys at least {C:attention}#1#',
            'selected {C:attention}face cards',
            'and spawn a',
            '{C:attention}Spared Hand Tag{}.'
        }
    },
    config = { min_highlighted = 3 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_hololive_spared_hand
        return {vars={card.ability.min_highlighted}}
    end,
    effect = "Card Removal",
    atlas='holo_fandoms_4',
    pos={y=0,x=2},

    can_use = function (self, card)
        if #G.hand.highlighted < card.ability.min_highlighted then
            return false
        end
        for _,v in ipairs(G.hand.highlighted)do
            if not v:is_face() then return false end
        end
        return true
    end,
    use = function (self, card, area, copier)
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        Holo.reset_hand_text()
        Holo.juice_on_use(card)

        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

        G.E_MANAGER:add_event(Event({
            func = function()
                add_tag(Tag('tag_hololive_spared_hand'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end
        }))
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Ruffian (B)
    member = 'Fuwawa',
    order = 62,
    key = 'fans_ruffian_b',
    loc_txt = {
        name = 'Ruffian (B)',
        text = {
            'Destroys {C:attention}1{} random {C:attention}face card{} in',
            'your hand, but add {C:attention}#1#{} random',
            '{C:attention}Enhanced {V:1}odd {}cards instead.'
        }
    },
    config = {remove_card = true, extra = 3},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_odd'}
        return {
            vars = {
                card.ability.extra,
                colours = {Holo.C.Fuwawa}
            }
        }
    end,
    atlas='holo_fandoms_4',
    pos={y=0,x=3},

    can_use = function (self, card)
        for _,v in ipairs(G.hand.cards)do
            if v:is_face() then return true end
        end
        return false
    end,
    use = function (self, card, area, copier)
        Holo.juice_on_use(card)

        local face_pool = {}
        for _,v in ipairs(G.hand.cards)do
            if v:is_face() then face_pool[#face_pool+1] = v end
        end
        local destroyed_cards = {}
        destroyed_cards[#destroyed_cards+1] = pseudorandom_element(face_pool, pseudoseed('Ruffian_Blue'))
        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.7,func = function()
            local cards = {}
            for i = 1, card.ability.extra do
                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' and not v.overrides_base_rank then
                        cen_pool[#cen_pool + 1] = v
                    end
                end
                local _suit = pseudorandom_element(SMODS.Suits, pseudoseed('Ruffian_B')).card_key
                local _rank = pseudorandom_element({'3','5','7','9','A'}, pseudoseed('Ruffian_b'))
                cards[i] = create_playing_card(
                    {front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))},
                    G.hand, nil, i ~= 1, { Holo.C.Fuwawa }
                )
            end
            playing_card_joker_effects(cards)
        return true end}))

        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Ruffian (P)
    member = 'Mococo',
    order = 63,
    key = 'fans_ruffian_p',
    loc_txt = {
        name = 'Ruffian (P)',
        text = {
            'Destroys {C:attention}1{} random {C:attention}face card{} in',
            'your hand, but add {C:attention}#1#{} random',
            '{C:attention}Enhanced {V:1}even {}cards instead.'
        }
    },
    config = {remove_card = true, extra = 3},
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_even'}
        return {
            vars = {
                card.ability.extra,
                colours = {Holo.C.Mococo}
            }
        }
    end,
    atlas='holo_fandoms_4',
    pos={y=0,x=4},

    can_use = function (self, card)
        for _,v in ipairs(G.hand.cards)do
            if v:is_face() then return true end
        end
        return false
    end,
    use = function (self, card, area, copier)
        Holo.juice_on_use(card)

        local face_pool = {}
        for _,v in ipairs(G.hand.cards)do
            if v:is_face() then face_pool[#face_pool+1] = v end
        end
        local destroyed_cards = {}
        destroyed_cards[#destroyed_cards+1] = pseudorandom_element(face_pool, pseudoseed('Ruffian_Pink'))
        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.7,func = function()
            local cards = {}
            for i = 1, card.ability.extra do
                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' and not v.overrides_base_rank then
                        cen_pool[#cen_pool + 1] = v
                    end
                end
                local _suit = pseudorandom_element(SMODS.Suits, pseudoseed('Ruffian_P')).card_key
                local _rank = pseudorandom_element({'2','4','6','8','T'}, pseudoseed('Ruffian_p'))
                cards[i] = create_playing_card(
                    {front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))},
                    G.hand, nil, i ~= 1, { Holo.C.Mococo }
                )
            end
            playing_card_joker_effects(cards)
        return true end}))

        holo_fan_cheers(self.member)
    end
}
----