----

SMODS.ConsumableType{
    key = 'holo_fandom',
    primary_colour = Holo.C.Hololive_bright,
    secondary_colour = Holo.C.Hololive,
    loc_txt = {
        name = "Fandom",
        collection = "Hololive Fandom",
        undiscovered = {
            name = "Fandom of ???",
            text = {
                "?????",
            }
        }
    },
    collection_rows = {5,6},
    shop_rate = 0,
}
Holo.Atlas_7195{
    key = 'hololive_fandoms',
    path = 'textures/holo_fandoms.png'
}
Holo.Fan_card = SMODS.Consumable:extend{
    set = 'holo_fandom',
    unlocked = true,
    discovered = false,
    in_pool = function(self, args)
        return false
    end,
    atlas = 'hololive_fandoms',
    pos = {x=0,y=0},
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

fandom_files = {
    "EN1",
    "EN2",
}
for _,file in ipairs(fandom_files) do assert(SMODS.load_file("Fans/Fans_"..file..".lua"))()end
----
