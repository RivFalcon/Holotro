----

Holo.Meme_Joker = SMODS.Joker:extend{
    required_params = { 'key', 'member', },
    blueprint_compat = true,
    inject = function(self)
        Holo.hooks.SMODS_Joker_inject(self)
        table.insert(Holo.H_Pool.Memes, self)
        table.insert(Holo.MemberJokerPools[self.member], self)
    end
}

local memes_files = {
    "JP0",
    "JP1",
    "JP2",
    --"JPG",

    --"JP3",
    --"JP4",
    --"ID1",
    --"JP5",

    "EN1",
    --"ID2",
    "EN2",
    --"JPX",
    "ID3",

    --"EN3",
    --"DI1",
    --"EN4",
    --"DI2",
}
for _,file in ipairs(memes_files) do assert(SMODS.load_file("Memes/Memes_"..file..".lua"))()end
