---------------------------------------
------------MOD CODE ------------------

assert(SMODS.load_file("holo_globals.lua"))()

SMODS.Atlas({
    key = "modicon",
    path = "HoloIcon.png",
    px = 32,
    py = 32
})

mod_dir = ''..SMODS.current_mod.path
holo_config = SMODS.current_mod.config

local mfiles = NFS.getDirectoryItems(mod_dir.."Memes")
for _, file in ipairs(mfiles) do assert(SMODS.load_file("Memes/"..file))()end

assert(SMODS.load_file("Relics/Relic_Loader.lua"))()

local ffiles = NFS.getDirectoryItems(mod_dir.."Miscellaneous")
for _, file in ipairs(ffiles) do assert(SMODS.load_file("Miscellaneous/"..file))()end

---------------------------------------
------------MOD CODE END---------------