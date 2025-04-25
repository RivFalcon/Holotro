----

SMODS.Rarity{
    key = "Relic",
    loc_txt = { name = 'Relic' },
    default_weight = 0,
    badge_colour = HEX("33C9FE"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return 0
    end,
}

SMODS.Atlas{
    key = "Relic_hololive",
    path = "Relics/Relic_hololive.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker = SMODS.Joker:extend{
    required_params = { 'key', 'member', },

    unlocked = false,
    unlock_condition = {type = '', extra = '', hidden = true},

    rarity = "hololive_Relic",
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    atlas = 'Relic_hololive',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    set_badges = function(self, card, badges)
        Holo.set_member_badges(card, badges)
    end,
    inject = function(self)
        Holo.hooks.SMODS_Joker_inject(self)
        table.insert(Holo.H_Pool.Relics, self)
    end
}

Holo.Relic_dummytext = {
    'This relic {C:red}doesn\'t{} have',
    'any assigned effects {C:attention}yet{}.',
    '{C:dark_edition}Please wait{} for more contents',
    'in {C:attention}future updates{}.'
}
Holo.Relic_unlock_text = {
    "{E:1,s:1.3}?????",
}

for _,file in ipairs(Holo.gen_order) do assert(SMODS.load_file("Relics/Relic_"..file..".lua"))()end
assert(SMODS.load_file("Relics/Relic_Soul.lua"))()

----