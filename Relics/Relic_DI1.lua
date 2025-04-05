----
SMODS.Atlas{
    key = "Relic_ReGloss",
    path = "Relics/Relic_ReGloss.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Hiodoshi Ao
    member = "Ao",
    key = "Relic_Ao",
    loc_txt = {
        name = "Writing Pen of the Azure Clubhost",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_ReGloss',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Otonose Kanade
    member = "Kanade",
    key = "Relic_Kanade",
    loc_txt = {
        name = "Recorder of the Gilted Musician",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_ReGloss',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Ichijou Ririka
    member = "Ririka",
    key = "Relic_Ririka",
    loc_txt = {
        name = "Extreme Meal of the Magenta CEO",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_ReGloss',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Juufuutei Raden
    member = "Raden",
    key = "Relic_Raden",
    loc_txt = {
        name = "Folding Fan of the Viridian Rakugoka",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_ReGloss',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Todoroki Hajime
    member = "Hajime",
    key = "Relic_Hajime",
    loc_txt = {
        name = "Jacket* of the Lilac Bancho",
        text = Holo.Relic_dummytext or {
            ''
        }
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_ReGloss',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
    end
}

----