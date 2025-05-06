----
SMODS.Atlas{
    key = "Relic_NePoLABo",
    path = "Relics/Relic_NePoLABo.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Yukihana Lamy
    member = "Lamy",
    key = "Relic_Lamy",
    loc_txt = {
        name = "Sake of the Snowy Elf",
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
    atlas = 'Relic_NePoLABo',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Momosuzu Nene
    member = "Nene",
    key = "Relic_Nene",
    loc_txt = {
        name = "Entomology Set of the Orange Seal",
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
    atlas = 'Relic_NePoLABo',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Shishiro Botan
    member = "Botan",
    key = "Relic_Botan",
    loc_txt = {
        name = "Goggles of the White Lionette",
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
    atlas = 'Relic_NePoLABo',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Mano Aloe
    member = "Aloe",
    key = "Relic_Aloe",
    loc_txt = {
        name = "Headphone of the Succubus",
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
    atlas = 'Relic_NePoLABo',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Omaru Polka
    member = "Polka",
    key = "Relic_Polka",
    loc_txt = {
        name = "Juggling Pins of the Circus Jester",
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
    atlas = 'Relic_NePoLABo',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

----