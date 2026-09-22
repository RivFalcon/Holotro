----

Holo.Atlas_7195{
    key = 'holo_fandom_packs',
    path = 'textures/holo_fandom_packs.png',
}

Holo.Fandom_Pack = SMODS.Booster:extend{
    discovered = false,
    draw_hand = true,
    kind = "Hololive Fandom",
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    Holo.C.Hololive,
                }
            }
        }
    end,
    ease_background_colour = function (self)
        ease_colour(G.C.DYN_UI.MAIN,Holo.C.Hololive)
        ease_background_colour({
            new_colour = Holo.C.Hololive_bright,
            special_colour = Holo.C.Hololive_dark,
            contrast = 2,
        })
    end,
    -- 
    create_card = function (self, card, i)
        local _card = {set = "holo_fandom", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "holofan"}
        if i==1 then
            local _pool = {}
            for _,J in ipairs(G.jokers.cards)do
                if J.config.center.rarity == 'hololive_Relic' then
                    _pool[#_pool+1] = 'hololive_'..J.config.center.fandom
                end
            end
            if _pool[1] then
                _card.key = 'hololive_'..pseudorandom_element(pool,pseudoseed('holofancall'))
            end
        end
        return _card
    end,
}

Holo.Fandom_Pack_local_text = {
    "Choose {C:attention}#1#{} of up to",
    "{C:attention}#2#{V:1} Fandom{} cards to",
    "be used immediately",
}

Holo.Fandom_Pack{
    key = 'fandom_normal_1',
    loc_txt = {
        name = 'HoloPack',
        text = Holo.Fandom_Pack_local_text,
        group_name = 'Fandom Pack',
    },
    config = { extra = 3, choose = 1 },
    weight = 2,
    cost = 4,
    atlas = 'holo_fandom_packs',
    pos = {x=0,y=0},
}

Holo.Fandom_Pack{
    key = 'fandom_normal_2',
    loc_txt = {
        name = 'HoloPack',
        text = Holo.Fandom_Pack_local_text,
        group_name = 'Fandom Pack',
    },
    config = { extra = 3, choose = 1 },
    weight = 2,
    cost = 4,
    atlas = 'holo_fandom_packs',
    pos = {x=1,y=0},
}

Holo.Fandom_Pack{
    key = 'fandom_jumbo_1',
    loc_txt = {
        name = 'Jumbo HoloPack',
        text = Holo.Fandom_Pack_local_text,
        group_name = 'Fandom Pack',
    },
    config = { extra = 5, choose = 1 },
    weight = 1,
    cost = 6,
    atlas = 'holo_fandom_packs',
    pos = {x=2,y=0},
}

Holo.Fandom_Pack{
    key = 'fandom_mega_1',
    loc_txt = {
        name = 'Mega HoloPack',
        text = Holo.Fandom_Pack_local_text,
        group_name = 'Fandom Pack',
    },
    config = { extra = 5, choose = 2 },
    weight = 0.5,
    cost = 8,
    atlas = 'holo_fandom_packs',
    pos = {x=3,y=0},
}

----