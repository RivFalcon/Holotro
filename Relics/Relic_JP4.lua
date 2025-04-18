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
        name = "Glove of the Other-side Angel",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Force',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
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
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Force',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Tsunomaki Watame
    member = "Watame",
    key = "Relic_Watame",
    loc_txt = {
        name = "Lyre of the Smuggy Sheep",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Force',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Tokoyami Towa
    member = "Towa",
    key = "Relic_Towa",
    loc_txt = {
        name = "Rifle of the Eternal Devil",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Force',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
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
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Force',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
    end
}

----