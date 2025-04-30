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
        text = Holo.Relic_dummytext or {
            ''
        name = "Halo of the Other-side Angel",
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_judgement
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Force',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
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

    atlas = 'Relic_Force',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Tsunomaki Watame
    member = "Watame",
    key = "Relic_Watame",
    loc_txt = {
        name = "Lyre of the Cottony Sheep",
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
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_devil
        return {
            vars = {
            }
        }
    end,

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

    atlas = 'Relic_Force',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

----