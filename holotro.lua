--- STEAMMODDED HEADER
--- MOD_NAME: holotro
--- MOD_ID: HOLOTRO
--- MOD_DESCRIPTION: A Hololive-themed fanmade Balatro mod
--- PREFIX: holotro
--- MOD_AUTHOR: [Riv_Falcon, and potentially others]
--- VERSION: alpha-whoamikiddingihaventevenfinishedthemod

---------------------------------------
------------MOD CODE ------------------

mod_dir = ''..SMODS.current_mod.path
holo_config = SMODS.current_mod.config

local hsprite, load_error = SMODS.load_file("holosprite.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
else
    hsprite()
end

SMODS.Rarity{
    key = "Relic",
    loc_txt = { name = 'Relic' },
    default_weight = 0,
    badge_colour = HEX("266AFF"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

local mfiles = NFS.getDirectoryItems(mod_dir.."Memes")
for _, file in ipairs(mfiles) do
    sendDebugMessage ("The file is: "..file)
    local memejoker, load_error = SMODS.load_file("Memes/"..file)
    if load_error then
        sendDebugMessage ("The error is: "..load_error)
    else
        memejoker()
    end
end

if false then
    local rfiles = NFS.getDirectoryItems(mod_dir.."Relics")
    for _, file in ipairs(rfiles) do
        sendDebugMessage ("The file is: "..file)
        local relicjoker, load_error = SMODS.load_file("Relics/"..file)
        if load_error then
            sendDebugMessage ("The error is: "..load_error)
        else
            relicjoker()
        end
    end
end

---------------------------------------
------------MOD CODE END---------------