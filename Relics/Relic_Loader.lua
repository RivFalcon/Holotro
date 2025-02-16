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
    path = "Relics/Relic_hololive.png",
    px = 71,
    py = 95
}

local RJ_blocklist = {
    'gen_order',
}

function Live:Relic_Joker(t)
    _t = {
        key = 'Relic_'..t.member,
        unlocked = false,
        unlock_condition = {type = '', extra = '', hidden = true},
        rarity = "hololive_Relic",
        cost = 20,
        blueprint_compat = true,
        atlas = 'Relic_hololive',
        pos = { x = t.gen_order or 0, y = 0 },
        soul_pos = { x = t.gen_order or 0, y = 1 },
    }
    for k,v in pairs(t)do
        local skip = false
        for _,_k in ipairs(RJ_blocklist)do if k==_k then skip=true;break end end
        if not skip then _t[k]=v end
    end

    _t.set_badges = function(_self, card, badges)
        local _branch = self.Members[t.member].branch
        badges[#badges+1] = create_badge(_branch, G.C.WHITE, self.C[_branch], 1.2 )
        for _,gen_key in ipairs(self.Members[t.member].gen)do
            if self.C[gen_key] then
                badges[#badges+1] = create_badge(localize('k_hololive_'..gen_key), self.C[gen_key].back, self.C[gen_key].text, 1.2 )
            else
                badges[#badges+1] = create_badge(localize('k_hololive_'..gen_key), G.C.WHITE, self.C.Hololive , 1.2 )
            end
        end
    end

    SMODS.Joker(_t)
end

relic_files = {
    "JP3",
    "ID1",
    "EN1",
    "EN2",
    "EN3",
    "EN4",
}
for _,file in ipairs(relic_files) do assert(SMODS.load_file("Relics/Relic_"..file..".lua"))()end



----