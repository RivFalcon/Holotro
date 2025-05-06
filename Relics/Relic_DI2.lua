----
SMODS.Atlas{
    key = "Relic_FlowGlow",
    path = "Relics/Relic_FlowGlow.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Isaki Riona
    member = "Riona",
    key = "Relic_Riona",
    loc_txt = {
        name = "Ribbon of the Cerise Rapper",
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

    no_collection = true,
    atlas = 'Relic_FlowGlow',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Koganei Niko
    member = "Niko",
    key = "Relic_Niko",
    loc_txt = {
        name = "Shades of the Smiling Tiger",
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

    no_collection = true,
    atlas = 'Relic_FlowGlow',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Mizumiya Su
    member = "Suu",
    key = "Relic_Suu",
    loc_txt = {
        name = "Aura of the Turquoise Manager",
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

    no_collection = true,
    atlas = 'Relic_FlowGlow',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Rindo Chihaya
    member = "Chihaya",
    key = "Relic_Chihaya",
    loc_txt = {
        name = "Car Key of the Teal Driver",
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

    no_collection = true,
    atlas = 'Relic_FlowGlow',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Kikirara Vivi
    member = "Vivi",
    key = "Relic_Vivi",
    loc_txt = {
        name = "Toolkits of the Fuchsia Makeup Artisan",
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

    no_collection = true,
    atlas = 'Relic_FlowGlow',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
    end
}

----