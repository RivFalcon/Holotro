----

SMODS.Rarity{
    key = "Relic",
    loc_txt = { name = 'Relic' },
    default_weight = 0,
    badge_colour = HEX("33C9FE"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Atlas{
    key = "Relic_hololive",
    path = "Relics/Relic_hololive.png",
    px = 71,
    py = 95
}

relic_files = {
    "Relics/Relic_JP3.lua",
    "Relics/Relic_ID1.lua",
    "Relics/Relic_EN1.lua",
    "Relics/Relic_EN2.lua",
    "Relics/Relic_EN3.lua",
    "Relics/Relic_EN4.lua"
}
for _,file in ipairs(relic_files) do assert(SMODS.load_file(file))()end



----