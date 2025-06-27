----

Holo.Fan_card{ -- Soratomo
    member = 'Sora',
    order = 1,
    key = 'fans_soratomo',
    loc_txt = {
        name = 'Soratomo',
        text = {
            'Creates {C:attention}#1#{} copies of',
            '{C:attention}1{} selected {C:diamonds}Diamond',
            'card in your hand.',
        }
    },
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = 2
    },
    loc_vars = function (self, info_queue, card)
        return {vars = {card.ability.extra,card.ability.max_highlighted}}
    end,
    atlas='holo_fandoms_1',
    pos={y=0,x=0},

    can_use = function (self, card)
        if #G.hand.highlighted > card.ability.max_highlighted then return false end
        if #G.hand.highlighted < card.ability.min_highlighted then return false end
        return G.hand.highlighted[1]:is_suit('Diamonds')
    end,
    use = function (self, card, area, copier)
        Holo.create_card_copy(G.hand.highlighted[1], card.ability.extra)
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Robosa
    member = 'Roboco',
    order = 2,
    key = 'fans_robosa',
    loc_txt = {
        name = 'Robosa',
        text = {
            'Enhances {C:attention}#1# {}cards',
            'into {C:attention}Steel cards{}.',
            'If a selected card is',
            'already a {C:attention}Steel Card{},',
            'increases its {X:mult,C:white}Xmult',
            'by {X:mult,C:white}X#2#{} mult.'
        }
        ,boxes={2,4}
    },
    config = {
        max_highlighted = 3,
        min_highlighted = 1,
        extra = 0.3,
    },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.max_highlighted,card.ability.extra}}
    end,
    atlas='holo_fandoms_1',
    pos={y=0,x=1},

    use = function (self, card, area, copier)
        Holo.reset_hand_text()
        Holo.juice_on_use(card)
        Holo.flip_cards_in_hand('high')

        for _,v in ipairs(G.hand.highlighted)do
            if SMODS.has_enhancement(v,'m_steel') then
                v.ability.h_x_mult = v.ability.h_x_mult + card.ability.extra
                SMODS.calculate_effect({
                    message = localize('k_upgrade_ex'),
                    colour = Holo.C.Roboco
                },v)
            else
                v:set_ability(G.P_CENTERS.m_steel, nil, true)
            end
        end

        Holo.flip_cards_in_hand('high',true)
        Holo.unhighlight_all()
        delay(0.5)
        holo_fan_cheers(self.member)
    end
}

Holo.Fan_card{ -- Hoshiyomi
    member = 'Suisei',
    order = 3,
    key = 'fans_hoshiyomi',
    loc_txt = {
        name = 'Hoshiyomi',
        text = {
            'Converts all',
            'cards in hand',
            'to {C:diamonds}Diamonds{}.'
        }
    },
    config = {suit_conv = 'Diamonds'},
    effect = "Suit Conversion",
    atlas='holo_fandoms_1',
    pos={y=0,x=2},

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

Holo.Fan_card{ -- 35P
    member = 'Miko',
    order = 9,
    key = 'fans_35p',
    loc_txt = {
        name = '35P',
        text = {
            'Destroys {C:attention}1{} random card in',
            'your hand, but adds {C:attention}#1#{} random',
            '{C:attention}Enhanced {C:diamonds}Diamond {}cards.',
        }
    },
    config = {extra = 3},
    loc_vars = function (self, info_queue, card)
        return {vars={card.ability.extra}}
    end,
    atlas='holo_fandoms_1',
    pos={y=0,x=3},

    can_use = function(self, card)
        if G.hand and G.hand.cards and #G.hand.cards>0 then
            return true
        end
    end,
    use = function (self, card, area, copier)
        Holo.juice_on_use(card)

        local destroyed_cards = {}
        destroyed_cards[#destroyed_cards+1] = pseudorandom_element(G.hand.cards, pseudoseed('35P_destroy'))
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
                local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('35P_rank')).card_key
                cards[i] = create_playing_card(
                    {front = G.P_CARDS['D_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))},
                    G.hand, nil, i ~= 1, { Holo.C.Miko }
                )
            end
            playing_card_joker_effects(cards)
        return true end}))

        holo_fan_cheers(self.member)
    end
}

Holo.Atlas_7195{
    key = 'Seal_GeoPin',
    path = 'textures/Seal_GeoPin.png'
}
SMODS.Seal{ -- Geo-Pin
    member = 'AZKi',
    key = 'geopin',
    loc_txt = {
        name = 'Geo-Pin Seal',
        text = {
            'Retrigger this card {V:1}twice',
            'if this card was drawn',
            'in {C:attention}first hand{} of round.',
        }
    },
    config = {
        azki_guessed=false,
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars={colours={Holo.C.AZKi}},
        }
    end,
    badge_colour = Holo.C.AZKi,
    atlas = 'hololive_Seal_GeoPin',

    update = function (self, card, dt)
        local on_table = ((card.area == G.hand)or(card.area == G.play))and G.GAME.facing_blind
        if card.ability.azki_guessed and not on_table then
            card.ability.azki_guessed = false
        end
    end,
    calculate = function (self, card, context)
        if context.first_hand_drawn then
            card.ability.azki_guessed = true
            SMODS.calculate_effect({
                message = 'Guess!',
                colour = Holo.C.AZKi,
                sound = 'hololive_sound_AZKi_Guess'..pseudorandom('AZKi_Guess',1,4)
            },card)
            local eval = function(_c)
                return _c.ability.azki_guessed and (_c.area == G.hand) and G.GAME.facing_blind and not G.RESET_JIGGLES
            end
            juice_card_until(card, eval, true)
        elseif context.repetition_only and card.ability.azki_guessed then
            return {
                repetitions = 2,
                colour = Holo.C.AZKi,
            }
        end
    end
}
Holo.Fan_card{ -- Pioneer
    member = 'AZKi',
    order = 15,
    key = 'fans_kaitakusha',
    loc_txt = {
        name = 'Pioneer',
        text = {
            'Adds a {V:1}Geo-Pin Seal',
            'to {C:attention}#1#{} selected card.'
        }
    },
    config = {
        max_highlighted = 1,
        min_highlighted = 1,
        extra = 'hololive_geopin'
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.max_highlighted,
                colours = {Holo.C.AZKi}
            }
        }
    end,
    atlas='holo_fandoms_1',
    pos={y=0,x=4},

    use = function (self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        Holo.juice_on_use(card)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            conv_card:set_seal(card.ability.extra, nil, true)
        return true end }))
        delay(0.5)
        Holo.unhighlight_all()
        holo_fan_cheers(self.member)
    end
}

---- Appendix ----

SMODS.Sound{
    key = 'sound_AZKi_Guess1',
    path = 'AZKi_Guess1.ogg',
    -- source: https://www.youtube.com/watch?v=zDxXSgGtPFE
}
SMODS.Sound{
    key = 'sound_AZKi_Guess2',
    path = 'AZKi_Guess2.ogg',
    -- source: https://www.youtube.com/watch?v=zDxXSgGtPFE
}
SMODS.Sound{
    key = 'sound_AZKi_Guess3',
    path = 'AZKi_Guess3.ogg',
    -- source: https://www.youtube.com/watch?v=zDxXSgGtPFE
}
SMODS.Sound{
    key = 'sound_AZKi_Guess4',
    path = 'AZKi_Guess4.ogg',
    -- source: https://www.youtube.com/watch?v=zDxXSgGtPFE
}

----