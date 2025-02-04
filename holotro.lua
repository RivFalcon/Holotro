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

local ffiles = NFS.getDirectoryItems(mod_dir.."Miscellaneous")
for _, file in ipairs(ffiles) do assert(SMODS.load_file(file))()end

local mfiles = NFS.getDirectoryItems(mod_dir.."Memes")
for _, file in ipairs(mfiles) do assert(SMODS.load_file(file))()end

assert(SMODS.load_file("Relics/Relic_Loader.lua"))()

---------------------------------------
------------MOD CODE END---------------