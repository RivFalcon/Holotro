----
SMODS.Atlas{
    key = "Relic_Force",
    path = "Relics/Relic_Force.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Amane Kanata
    member = "Kanata",
    key = "Relic_Kanata",
    loc_txt = {
        name = "Halo of the Other-side Angel",
        text = {
            '{C:green}#3# in #4#{} chance to gain {V:1}+1{} handsize',
            'when acquire a joker. (Currently {V:1}+#5#{}, Max:{V:1}50{})',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}Judgement{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.5,
        odds = 5, grip = 0,
        upgrade_args = {
            scale_var = 'Xmult',
        },
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_judgement
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                Holo.prob_norm(), cae.odds,
                cae.grip,
                colours = {Holo.C.Kanata,}
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_Force',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    add_to_deck = function (self, card, from_debuff)
        G.hand:change_size(card.ability.extra.grip)
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.grip)
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_judgement')
        if context.card_added and not context.blueprint then
            if (context.card.ability.set=='Joker')and(cae.grip<=50) then
                if Holo.chance('Kanata',cae.odds)then
                    cae.grip = cae.grip + 1
                    G.hand:change_size(1)
                end
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                colour = Holo.C.Kanata,
            }
        end
    end
}

SMODS.Sound{
    key = 'sound_Coco_NextMeme',
    path = 'Coco_NextMeme.ogg'
    -- source: https://www.myinstants.com/en/instant/kiryu-coco-next-meme-55641/
}
SMODS.Sound{
    key = 'sound_Coco_GMMF',
    path = 'Coco_GMMF.ogg'
    -- source: https://www.youtube.com/watch?v=Tgy_irBdBRM
}

Holo.Relic_Joker{ -- Kiryu Coco
    member = "Coco",
    key = "Relic_Coco",
    loc_txt = {
        name = "Morning Greeting of the Legendary Dragon",
        text = {
            'Greet you morning and create a {V:3}Meme{} joker',
            'for every {V:1}#3#{} cards held in hand at {C:attention}start of round{}.',
            '{C:inactive}(Must have room)',
            'Gain {X:mult,C:white}X#2#{} mult whenever your {V:2}handsize increases{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.5,
        count = 6, grip = 8,
        upgrade_args = {
            scale_var = 'Xmult',
        },
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.count,
                colours = {
                    Holo.C.Coco,
                    Holo.C.Kanata,
                    Holo.C.Hololive_bright,
                }
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_Force',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    add_to_deck = function (self, card, from_debuff)
        card.ability.extra.grip = G.hand.config.card_limit
        if Holo.mod_config.allow_profanity then
            play_sound('hololive_sound_Coco_GMMF')
        end
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        local h_size = G.hand.config.card_limit
        if (cae.grip ~= h_size)and(not context.blueprint)then
            if cae.grip < h_size then
                holo_card_upgrade(card)
            end
            cae.grip = h_size
        end
        if context.first_hand_drawn then
            local meme_joker_pool = {}
            for k,v in pairs(Holo.H_Pool.Memes)do
                if v:in_pool()then table.insert(meme_joker_pool,v)end
            end

            local meme_number = math.floor(#G.hand.cards/cae.count)
            local empty_joker_slot_number = G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer)
            for _=1,math.min(meme_number, empty_joker_slot_number)do
                local next_meme = pseudorandom_element(meme_joker_pool, pseudoseed('Coco'))
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        SMODS.add_card({ key = next_meme.key, area = G.jokers})
                        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                        return true
                    end
                }))
            end
            return {
                message = 'Next Meme!',
                colour = Holo.C.Coco,
                sound = 'hololive_sound_Coco_NextMeme',
            }
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                colour = Holo.C.Coco,
            }
        end
    end
}

Holo.Relic_Joker{ -- Tsunomaki Watame
    member = "Watame",
    key = "Relic_Watame",
    loc_txt = {
        name = "Harp of the Cottony Sheep",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_Force',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Tokoyami Towa
    member = "Towa",
    key = "Relic_Towa",
    loc_txt = {
        name = "Assault Rifle of the Eternal Devil",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.25,
        upgrade_args = {
            scale_var = 'Xmult',
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_devil
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_Force',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_devil')
    end
}

Holo.Relic_Joker{ -- Himemori Luna
    member = "Luna",
    key = "Relic_Luna",
    loc_txt = {
        name = "Sweet Saber of the Candyland Princess",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_Force',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

----