----

SMODS.ConsumableType{
    key = 'holo_fandom',
    primary_colour = Holo.C.Hololive_bright,
    secondary_colour = Holo.C.Hololive,
    loc_txt = {
        name = "Fandom",
        collection = "Hololive Fandom",
        undiscovered = {
            name = "Not Discovered",
            text = {
                'Purchase or use',
                'this card in an',
                'unseeded run to',
                'learn what it does.'
            }
        }
    },
    collection_rows = {5,6},
    shop_rate = 4,
}
Holo.Atlas_7195{
    key = 'holo_fandoms_1',
    path = 'textures/holo_fandoms_1_012G.png'
}
Holo.Atlas_7195{
    key = 'holo_fandoms_2',
    path = 'textures/holo_fandoms_2_34A5.png'
}
Holo.Atlas_7195{
    key = 'holo_fandoms_3',
    path = 'textures/holo_fandoms_3_MRPXH.png'
}
Holo.Atlas_7195{
    key = 'holo_fandoms_4',
    path = 'textures/holo_fandoms_4_ARJF.png'
}
Holo.Fan_card = SMODS.Consumable:extend{
    set = 'holo_fandom',
    unlocked = true,
    discovered = false,
    set_badges = function(self, card, badges)
        Holo.set_member_badges(card, badges)
    end,
    keep_on_use = function(self, card)
        return false
    end,
    calculate = function(self, card, context)
        local oshi_relics = find_joker('j_hololive_Relic_'..self.member)
        if G.GAME.used_vouchers.v_hololive_stage_response and next(oshi_relics) then
            return SMODS.blueprint_effect(card, oshi_relics[1], context)
        end
    end
}

local fandom_files = {
    --"JP0",
    --"JP1",
    --"JP2",
    --"JPG",

    --"JP3",
    --"JP4",
    --"ID1",
    --"JP5",

    "EN1",
    --"ID2",
    "EN2",
    --"JPX",
    --"ID3",

    "EN3",
    --"DI1",
    "EN4",
    --"DI2",
}
for _,file in ipairs(fandom_files) do assert(SMODS.load_file("Fans/Fans_"..file..".lua"))()end
----
