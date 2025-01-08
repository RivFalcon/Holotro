--- STEAMMODDED HEADER
--- MOD_NAME: holotro
--- MOD_ID: HOLOTRO
--- MOD_DESCRIPTION: A Hololive-themed fanmade Balatro mod
--- PREFIX: holotro
--- MOD_AUTHOR: [Riv_Falcon, and potentially others]
--- VERSION: alpha-whoamikiddingihaventevenfinishedthemod

---------------------------------------
------------MOD CODE ------------------

SMODS.Rarity{
    key = "Relic",
    default_weight = 0,
    badge_colour = HEX("93A8AC"),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

SMODS.Atlas{
    key = "Fubuki_MFG",
    path = "Fubuki_MFG.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "Fubuki_MFG",
    loc_txt = {
        name = "Medical Fee Gamble",
        text = {
            'Every shop item has a',
            '{C:green}#1# in 6{} chance to be {C:attention}free{},',
            'otherwise the price',
            'would be {C:attention}doubled{}.'
        }
    },
    config = { extra = {} },
    rarity = 2,
    cost = 8,
    atlas = 'Fubuki_MFG',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal + 1,} }
    end,
    calculate = function(self, card, context)
        if G.shop_jokers and G.shop_booster then
            if pseudorandom('fubuki') < (G.GAME.probabilities.normal + 1)/6 then
                for k, v in pairs(G.shop_jokers.cards) do
                    v:set_cost()
                end
                for k, v in pairs(G.shop_booster.cards) do
                    v:set_cost()
                end
            else
                -- double the price
            end
        end
    end
}


---------------------------------------
------------MOD CODE END---------------
