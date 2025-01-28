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

SMODS.Atlas({
    key = "modicon",
    path = "HoloIcon.png",
    px = 32,
    py = 32
})

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

local relic_loader, load_error = SMODS.load_file("Relics/Relic_Loader.lua")
if load_error then
    sendDebugMessage ("The error is: "..load_error)
else
    relic_loader()
end

---------------------------------------
------------MOD CODE END---------------