----

Holo.Fan_card{ -- Rosarian
    member = 'Elizabeth',
    order = 69,
    key = 'fans_rosarian',
    loc_txt = {
        name = 'Rosarian',
        text = {
            'Enhances {C:attention}#1#{} selected',
            'cards to {C:attention}Glass Cards{}.'
        }
    },
    config = {
        max_highlighted = 3,
        mod_conv = 'm_glass',
    },
    loc_vars = function (self, info_queue, card)
        return {vars={card.ability.max_highlighted}}
    end,
    effect = "Enhance",
    atlas='holo_fandoms_4',
    pos={y=2,x=0},

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

Holo.Fan_card{ -- Gremurin
    member = 'Gigi',
    order = 70,
    key = 'fans_gremurin',
    loc_txt = {
        name = 'Gremurin',
        text = {
            'Enhances all cards in hand',
            'to {C:attention}Glass Cards{}, but',
            'each has {C:green}#1# in #2#{} chance',
            'to {C:dark_edition}shatter{} on the spot.'
        }
    },
    config = { extra = 4 },
    loc_vars = function (self, info_queue, card)
        return {vars={Holo.prob_norm(),card.ability.extra}}
    end,
    effect = "Enhance",
    atlas='holo_fandoms_4',
    pos={y=2,x=1},

    can_use = function (self, card)
        if G.hand and G.hand.cards and G.hand.cards[1] then return true end
    end,
    use = function (self, card, area, copier)
        Holo.juice_on_use(card)
        Holo.flip_cards_in_hand('all')

        for i=1, #G.hand.cards do
            G.hand.cards[i]:set_ability(G.P_CENTERS.m_glass, nil, true)
        end
        Holo.flip_cards_in_hand('all', true)
        delay(0.5)

        local destroyed_cards = {}
        for i=#G.hand.cards, 1, -1 do
            if Holo.chance('gremurin', card.ability.extra) then
                destroyed_cards[#destroyed_cards+1] = G.hand.cards[i]
            end
        end

        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

        holo_fan_cheers(self.member)
    end
}

Holo.Atlas_7195{ -- Cecilia Immergreen: Durable
    key = "Sticker_Durable",
    path = "textures/Sticker_Durable.png",
}
SMODS.Sticker{ -- Cecilia Immergreen: Durable
    member = 'Ceci',
    key = 'durable',
    loc_txt = {
        name = 'Durable',
        text = {
            'This card is',
            'very {V:1}Durable{}.',
            '{C:inactive}Returns back to your deck',
            '{C:inactive}if you try to destroy this card.'
        }
        ,boxes={2,2}
    },
    loc_vars = function (self, info_queue, card)
        return {vars={colours={Holo.C.Ceci}}}
    end,
    atlas = 'Sticker_Durable',
    pos = {x=0,y=0},
    badge_colour=Holo.C.Caci,
    should_apply = function(self, card, center, area, bypass_roll)
        local is_playing_card = card and card.playing_card or false
        local has_glass_enhancement = SMODS.has_enhancement(card, 'm_glass') or false
        local is_held_in_hand = (area==G.hand) or false
        return is_playing_card and has_glass_enhancement and(is_held_in_hand or bypass_roll)
    end,
}
Holo.Fan_card{ -- Otomo
    member = 'Ceci',
    order = 71,
    key = 'fans_otomo',
    loc_txt = {
        name = 'Otomo',
        text = {
            'Applies {V:1}Durable{} effect',
            'on {C:attention}1{} selected {C:attention}Glass Card{}.'
        }
    },
    config = {max_highlighted = 1},
    loc_vars = function (self, info_queue, card)
        return{vars={colours={Holo.C.Ceci}}}
    end,
    atlas='holo_fandoms_4',
    pos={y=2,x=2},

    can_use=function (self, card)
        if #G.hand.highlighted~=1 then return false end
        if SMODS.has_enhancement(G.hand.highlighted[1], 'm_glass')then return true end
    end,
    use = function (self, card, area, copier)
        Holo.reset_hand_text()
        Holo.juice_on_use(card)

        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand.highlighted[1]:add_sticker('hololive_durable')
                G.hand.highlighted[1]:juice_up()
                return true
            end
        }))

        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Chattino
    member = 'Raora',
    order = 72,
    key = 'fans_chattino',
    loc_txt = {
        name = 'Chattino',
        text = {
            'Select up to {V:1}#1# {C:attention}Glass Cards{},',
            'increases their {X:mult,C:white}Xmult{} by {X:mult,C:white}X#2#{} Mult.'
        }
    },
    config = {
        min_highlighted = 1,
        max_highlighted = 3,
        extra = 0.1,
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.max_highlighted,
                card.ability.extra,
                colours = {Holo.C.Raora}
            }
        }
    end,
    atlas='holo_fandoms_4',
    pos={y=2,x=3},

    can_use = function (self, card)
        if #G.hand.highlighted>card.ability.max_highlighted then return false end
        if #G.hand.highlighted<card.ability.min_highlighted then return false end
        for _,v in ipairs(G.hand.highlighted) do
            if not SMODS.has_enhancement(v,'m_glass')then return false end
        end
        return true
    end,
    use = function (self, card, area, copier)
        Holo.reset_hand_text()
        Holo.juice_on_use(card)

        for _,v in ipairs(G.hand.highlighted) do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                v.ability.x_mult = v.ability.x_mult + card.ability.extra
                v.ability.Xmult = v.ability.x_mult
                v:juice_up()
            return true end }))
        end

        Holo.unhighlight_all()
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

----