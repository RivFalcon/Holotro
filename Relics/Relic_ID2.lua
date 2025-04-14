----
SMODS.Atlas{
    key = "Relic_Holoro",
    path = "Relics/Relic_Holoro.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Kureiji Ollie
    member = "Ollie",
    key = "Relic_Ollie",
    loc_txt = {
        name = "\"Serenity\" of the Undead",
        text = Holo.Relic_dummytext or {
            ''
        }
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

    atlas = 'Relic_Holoro',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Anya Melfissa
    member = "Anya",
    key = "Relic_Anya",
    loc_txt = {
        name = "True Form of the Ancient Keris",
        text = Holo.Relic_dummytext or {
            ''
        }
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

    atlas = 'Relic_Holoro',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Pavolia Reine
    member = "Reine",
    key = "Relic_Reine",
    loc_txt = {
        name = "Megaphone of the Attendant Peafowl",
        text = Holo.Relic_dummytext or {
            ''
        }
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

    atlas = 'Relic_Holoro',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

----