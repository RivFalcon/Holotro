----

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
    config = { extra = { activating = false } },
    rarity = 2,
    cost = 8,
    atlas = 'Fubuki_MFG',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(G.GAME.probabilities.normal * 2 , 6 ) , } }
    end,
    calculate = function(self, card, context)
        if context.buying_card or context.open_booster then
            delay(0.2)
            play_sound('timpani')
            if pseudorandom('fubuki') < G.GAME.probabilities.normal / 3 then
                ease_dollars(context.card.cost)
            else
                ease_dollars(-context.card.cost)
            end
        end
    end
}

----