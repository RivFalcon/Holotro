
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
        return { vars = { G.GAME.probabilities.normal * 2 , } }
    end,
    calculate = function(self, card, context)
        if G.shop_jokers then
            for k, v in pairs(G.shop_jokers.cards) do
                if pseudorandom('fubuki') < G.GAME.probabilities.normal / 3 then
                    v.cost = 0
                else
                    v.cost = v.cost * 2
                end
        if G.shop_booster then
            for k, v in pairs(G.shop_booster.cards) do
                if pseudorandom('fubuki') < G.GAME.probabilities.normal / 3 then
                    v.cost = 0
                else
                    v.cost = v.cost * 2
                end
            end
        end
    end
}
