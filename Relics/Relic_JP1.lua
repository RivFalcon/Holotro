----
SMODS.Atlas{
    key = "Relic_First",
    path = "Relics/Relic_First.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "Relic_Gamers",
    path = "Relics/Relic_Gamers.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Yozora Mel
    member = "Mel",
    key = "Relic_Mel",
    loc_txt = {
        name = "Bite of the Vampire",
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

    atlas = 'Relic_First',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Shiragami Fubuki
    member = "Fubuki",
    key = "Relic_Fubuki",
    loc_txt = {
        name = "Pentagram Emblem of the King Fox",
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

    atlas = 'Relic_Gamers',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Natsuiro Matsuri
    member = "Matsuri",
    key = "Relic_Matsuri",
    loc_txt = {
        name = "Taiko of the Summer Festival",
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

    atlas = 'Relic_First',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Aki Rosenthal
    member = "Aki",
    key = "Relic_Aki",
    loc_txt = {
        name = "??? of the ??? Elf",
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

    atlas = 'Relic_First',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Akai Haato / Haachama
    member = "Haato",
    key = "Relic_Haato",
    loc_txt = {
        name = "incREDible Heart of the Strongest Idol",
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

    atlas = 'Relic_First',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
    end
}

----