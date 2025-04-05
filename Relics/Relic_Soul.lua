SMODS.ConsumableType{
    key = 'relicgacha',
    primary_colour = Holo.C.Hololive_dark,
    secondary_colour = Holo.C.Hololive,
    loc_txt = {
        name = "Relic Gacha",
        collection = "Hololive Relic Gacha",
        --undiscovered = {}
    },
    collection_rows = {5,5},
}

Holo.Relic_Gacha = SMODS.Consumable:extend{
    set = 'relicgacha',
    unlocked = false,
    discovered = false,
    gachapool = {key = 'order'},

    hidden = true,
    soul_set = 'Tarot',
    can_repeat_soul = true,

    in_pool = function(self, args)
        for _,J in ipairs(G.jokers.cards) do
            local _members = J.config.center.members or (J.config.center.member and {J.config.center.member,}) or {}
            for _,_member in ipairs(_members) do
                if (Holo.Members[_member] or {})[self.gachapool.key] == self.gachapool.val then return true end
            end
        end
    end,
    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
            return true
        else
            return false
        end
    end,
    keep_on_use = function(self, card)
        return false
    end,
    use = function(self, card, area, copier)
        local _member = pseudorandom_element(card.ability.extra.members, pseudoseed(card.ability.extra.pseudoseed))
        local _key = 'j_hololive_Relic_'.._member
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            SMODS.add_card({key = _key, area = G.jokers})
        return true end }))
    end,
}

SMODS.Atlas{
    key = "RelicGacha_HQ",
    path = "Relics/RelicGacha_HQ.png",
    px = 71,
    py = 95
}

local Gacha_default_rate = 0.04/#Holo.Members

Holo.Relic_Gacha{ -- Hololive
    key = 'RelicGacha_Hololive',
    loc_txt = {
        name = 'The Hololive',
        text = {
            "Creates a",
            "{V:1,E:1}#1# Relic",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = {
        members = Holo.memberlist,
        pseudoseed = 'Hololive',
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "Hololive",
                colours = { Holo.C.Hololive }
            }
        }
    end,
    unlocked = true,
    soul_rate = 0.02,

    atlas = 'RelicGacha_HQ',
    pos      = {x=0,y=0},
    soul_pos = {x=0,y=1},

    in_pool = function(self, args)
        for _,J in ipairs(G.jokers.cards) do
            local _members = J.config.center.members or (J.config.center.member and {J.config.center.member,}) or {}
            for _,_member in ipairs(_members) do
                if Holo.Members[_member] then return true end
            end
        end
    end,
}

Holo.Relic_Gacha{ -- JP
    key = 'RelicGacha_Branch_JP',
    loc_txt = {
        name = 'The Main',
        text = {
            "Creates a",
            "{V:1,E:1}#1# Relic",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = {
        members = Holo.Branches.JP.members,
        pseudoseed = 'JP',
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "Hololive JP",
                colours = { Holo.C.JP }
            }
        }
    end,
    unlocked = true,
    soul_rate = Gacha_default_rate*#Holo.Branches.JP.members,
    gachapool = {key = 'branch', val = 'JP'},

    atlas = 'RelicGacha_HQ',
    pos      = {x=1,y=0},
    soul_pos = {x=1,y=1},

}

Holo.Relic_Gacha{ -- ID
    key = 'RelicGacha_Branch_ID',
    loc_txt = {
        name = 'The Identity',
        text = {
            "Creates a",
            "{V:1,E:1}#1# Relic",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = {
        members = Holo.Branches.ID.members,
        pseudoseed = 'ID',
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "Hololive ID",
                colours = { Holo.C.ID }
            }
        }
    end,
    unlocked = true,
    soul_rate = Gacha_default_rate*#Holo.Branches.ID.members,
    gachapool = {key = 'branch', val = 'ID'},

    atlas = 'RelicGacha_HQ',
    pos      = {x=2,y=0},
    soul_pos = {x=2,y=1},

}

Holo.Relic_Gacha{ -- EN
    key = 'RelicGacha_Branch_EN',
    loc_txt = {
        name = 'The Main',
        text = {
            "Creates a",
            "{V:1,E:1}#1# Relic",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = {
        members = Holo.Branches.EN.members,
        pseudoseed = 'EN',
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "Hololive EN",
                colours = { Holo.C.EN }
            }
        }
    end,
    unlocked = true,
    soul_rate = Gacha_default_rate*#Holo.Branches.EN.members,
    gachapool = {key = 'branch', val = 'EN'},

    atlas = 'RelicGacha_HQ',
    pos      = {x=3,y=0},
    soul_pos = {x=3,y=1},

}

Holo.Relic_Gacha{ -- DI
    key = 'RelicGacha_Branch_DI',
    loc_txt = {
        name = 'The Devise',
        text = {
            "Creates a",
            "{V:1,E:1}#1# Relic",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = {
        members = Holo.Branches.DI.members,
        pseudoseed = 'DEV_IS',
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "DEV_IS",
                colours = { Holo.C.DI }
            }
        }
    end,
    unlocked = true,
    soul_rate = Gacha_default_rate*#Holo.Branches.DI.members,
    gachapool = {key = 'branch', val = 'DI'},

    atlas = 'RelicGacha_HQ',
    pos      = {x=4,y=0},
    soul_pos = {x=4,y=1},

}
