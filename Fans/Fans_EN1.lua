----

Holo.Fan_card{ -- Dead Beats
    member = 'Calli',
    order = 37,
    key = 'fans_deadbeat',
    loc_txt = {
        name = 'Dead Beat',
        text = {
            'Select up to {C:attention}#1#{} cards,',
            'each card has {C:green}#2# in #3#',
            'chance to be converted',
            'into the {C:attention}right-most{} card.',
            '{C:inactive}(Drag to rearrange)'
        }
    },
    config = {
        mod_conv = 'card',
        max_highlighted = 4,
        min_highlighted = 2,
        odds = 2,
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.max_highlighted,
            Holo.prob_norm(),
            card.ability.odds,
        }}
    end,
    effect = "Card Conversion",
    pos={y=8,x=0},

    use = function(self, card, area, copier)
        update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        Holo.juice_on_use(card)
        Holo.flip_cards_in_hand('high')
        delay(0.2)

        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x > rightmost.T.x then
                rightmost = G.hand.highlighted[i]
            end
        end
        for i=1, #G.hand.highlighted do
            if G.hand.highlighted[i] ~= rightmost then
                if Holo.chance('Dead Beat', card.ability.odds) then
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        copy_card(rightmost, G.hand.highlighted[i])
                    return true end}))
                end
            end
        end

        Holo.flip_cards_in_hand('high',true)
        Holo.unhighlight_all()
        delay(0.5)
    end,
}

Holo.Fan_card{ -- KFP
    member = 'Kiara',
    order = 38,
    key = 'fans_kfp',
    loc_txt = {
        name = 'KFP',
        text = {
            'Select up to {C:attention}#1#{} cards,',
            'cooks them into {V:1}fries',
            'and gain {C:money}$#2#{} per fry.'
        }
    },
    config = {
        remove_card = true,
        max_highlighted = 4,
        min_highlighted = 1,
        dollars = 3,
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            card.ability.max_highlighted,
            card.ability.dollars,
            colours = {Holo.C.Kiara}
        }}
    end,
    effect = "Card Removal",
    pos={y=8,x=1},

    use = function(self, card, area, copier)
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        Holo.juice_on_use(card)

        Holo.delayed_destruction(destroyed_cards)
        delay(0.3)
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
    end
}

Holo.Fan_card{ -- Takodachi
    member = 'Ina',
    order = 39,
    key = 'fans_takodachi',
    loc_txt = {
        name = 'Takodachi',
        text = {
            'Creates the last {C:spectral}Spectral',
            'card used during this run.',
            '{C:inactive}(Must have room)'
        }
    },
    config = {},
    loc_vars = function(self, info_queue, card)
        local tako_c = G.GAME.last_spectral and G.P_CENTERS[G.GAME.last_spectral] or nil
        local last_spectral = tako_c and localize{type = 'name_text', key = tako_c.key, set = tako_c.set} or localize('k_none')
        local colour = (not tako_c) and G.C.RED or G.C.GREEN
        local main_end = {
            {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                    {n=G.UIT.T, config={text = ' '..last_spectral..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                }}
            }}
        }
        if tako_c then
            info_queue[#info_queue+1] = tako_c
        end
        return { main_end = main_end }
    end,
    effect = "Card Creation",
    pos={y=8,x=2},

    can_use = function(self, card)
        if (#G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables)
        and G.GAME.last_spectral then return true end
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                SMODS.add_card({key = G.GAME.last_spectral, area = G.consumeables})
                card:juice_up(0.3, 0.5)
            end
        return true end}))
        delay(0.6)
    end
}

Holo.Fan_card{ -- Chumbuds
    member = 'Gura',
    order = 40,
    key = 'fans_chumbud',
    loc_txt = {
        name = 'Chumbud',
        text = {
            'Select {C:attention}1{} card,',
            'converts all cards in hand',
            'to {C:attention}random ranks',
            'within {C:blue}+2{}~{C:red}-2{} range of',
            'selected card\'s rank.'
        }
    },
    effect = "Rank Conversion",
    pos={y=8,x=3},

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            local _rank = G.hand.highlighted[1]:get_id()
            for i=2,14 do
                if _rank == i then
                    return true
                end
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        update_hand_text({immediate = true, nopulse = true, delay = 0}, {mult = 0, chips = 0, level = '', handname = ''})
        Holo.juice_on_use(card)
        local unselected_cards = Holo.flip_cards_in_hand('low')
        delay(0.2)

        local selected = G.hand.highlighted[1]
        local _rank = selected:get_id()
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            for _,v in ipairs(unselected_cards) do
                Holo.change_rank(v, pseudorandom('Chumbuds',_rank-4,_rank)%13 + 2)
            end
        return true end }))

        Holo.flip_cards_in_hand('low',true)
        Holo.unhighlight_all()
        delay(0.5)
    end
}

Holo.Fan_card{ -- Teamates
    member = 'Ame',
    order = 41,
    key = 'fans_teamate',
    loc_txt = {
        name = 'Teamate',
        text = {
            'Select {C:attention}1{} face card,',
            'creates {C:attention}2{} copies of it',
            'with random {C:attention}Enhancement{},',
            '{C:dark_edition}Edition{}, and {C:dark_edition}Seal{}.'
        }
    },
    pos={y=8,x=4},

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            if G.hand.highlighted[1]:is_face()then
                return true
            end
        end
    end,
    use = function(self, card, area, copier)
        Holo.juice_on_use(card)
        local _base = G.hand.highlighted[1].base
        local _front = G.P_CARDS[string.sub(_base.suit, 1, 1)..'_'..Holo.rank_strings[_base.id]]
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.7,func = function()
            local cards = {}
            for i=1, 2 do
                cards[i] = true
                local cen_pool = {}
                for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if v.key ~= 'm_stone' then 
                        cen_pool[#cen_pool+1] = v
                    end
                end

                local _card = create_playing_card(
                    {front = _front, center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))},
                    G.hand, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral}
                )

                local edition_rate = 2
                local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
                _card:set_edition(edition)

                local seal_rate = 10
                local seal_poll = pseudorandom(pseudoseed('stdseal'..G.GAME.round_resets.ante))
                if seal_poll > 1 - 0.02*seal_rate then
                    local seal_type = pseudorandom(pseudoseed('stdsealtype'..G.GAME.round_resets.ante))
                    if seal_type > 0.75 then _card:set_seal('Red')
                    elseif seal_type > 0.5 then _card:set_seal('Blue')
                    elseif seal_type > 0.25 then _card:set_seal('Gold')
                    else _card:set_seal('Purple')
                    end
                end
            end
            playing_card_joker_effects(cards)
        return true end }))
    end
}

----