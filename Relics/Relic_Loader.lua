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
    path = "Relic_hololive.png",
    px = 71,
    py = 95
}

relic_files = {
    "Relics/Relic_ID1.lua",
    "Relics/Relic_EN4.lua"
}

for _,file in pairs(relic_files) do
    sendDebugMessage ("The file is: "..file)
    local relicjoker, load_error = SMODS.load_file(file)
    if load_error then
        sendDebugMessage ("The error is: "..load_error)
    else
        relicjoker()
    end
end

----