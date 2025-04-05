
memes_files = {
    "JP0",
    "JP1",
    "JP2",

    "EN1",

    "ID3",
}
for _,file in ipairs(memes_files) do assert(SMODS.load_file("Memes/Memes_"..file..".lua"))()end
