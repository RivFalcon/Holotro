----
SMODS.Atlas{
    key = "Relic_HoloH3ro",
    path = "Relics/Relic_HoloH3ro.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Vestia Zeta
    member = "Zeta",
    key = "Relic_Zeta",
    loc_txt = {
        name = "Pistol of the Secret Agent",
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

    atlas = 'Relic_HoloH3ro',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Kaela Kovalskia
    member = "Kaela",
    key = "Relic_Kaela",
    loc_txt = {
        name = "Hammer of the Blacksmith",
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

    atlas = 'Relic_HoloH3ro',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Kobo Kanaeru
    member = "Kobo",
    key = "Relic_Kobo",
    loc_txt = {
        name = "Umbrella of the Rain Shaman",
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

    atlas = 'Relic_HoloH3ro',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

----