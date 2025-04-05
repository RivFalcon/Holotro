----
SMODS.Atlas{
    key = "Relic_HoloX",
    path = "Relics/Relic_HoloX.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- La+ Darkness
    member = "Laplus",
    key = "Relic_Laplus",
    loc_txt = {
        name = "X of the Commander Chief",
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

    atlas = 'Relic_HoloX',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Takane Lui
    member = "Lui",
    key = "Relic_Lui",
    loc_txt = {
        name = "X of the Sage Hawk",
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

    atlas = 'Relic_HoloX',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Hakui Koyori
    member = "Koyori",
    key = "Relic_Koyori",
    loc_txt = {
        name = "X of the Chemist Coyote",
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

    atlas = 'Relic_HoloX',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Sakamata Chloe
    member = "Chloe",
    key = "Relic_Chloe",
    loc_txt = {
        name = "X of the Cleaner Orca",
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

    atlas = 'Relic_HoloX',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
    end
}

Holo.Relic_Joker{ -- Kazama Iroha
    member = "Iroha",
    key = "Relic_Iroha",
    loc_txt = {
        name = "X of the Bodyguard Samurai",
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

    atlas = 'Relic_HoloX',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
    end
}

----