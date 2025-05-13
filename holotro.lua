---------------------------------------
------------MOD CODE ------------------

SMODS.Atlas({
    key = "modicon",
    path = "HoloIcon.png",
    px = 32,
    py = 32
})

SMODS.current_mod.optional_features = {
    --retrigger_joker = true
}

assert(SMODS.load_file("holo_globals.lua"))()
assert(SMODS.load_file("holo_functions.lua"))()

Holo.mod_dir = ''..SMODS.current_mod.path
Holo.mod_config = SMODS.current_mod.config

assert(SMODS.load_file("Fans/Fandom_Loader.lua"))()
assert(SMODS.load_file("Memes/Meme_Loader.lua"))()
assert(SMODS.load_file("Relics/Relic_Loader.lua"))()

local ffiles = NFS.getDirectoryItems(Holo.mod_dir.."Miscellaneous")
for _, file in ipairs(ffiles) do assert(SMODS.load_file("Miscellaneous/"..file))()end

---------------------------------------
------------MOD CODE END---------------