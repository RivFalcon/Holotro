----

SMODS.Atlas{
    key = "Fubuki_MFG",
    path = "Memes/Meme_Fubuki_MFG.png",
    px = 71,
    py = 95
}
Holo.Meme_Joker{
    key = "Meme_Fubuki_MFG",
    member = "Fubuki",
    loc_txt = {
        name = "Medical Fee Gamble",
        text = {
            'Every shop item has',
            '{C:green}#1# in 6{} chance to be {C:attention}free{},',
            'otherwise the price',
            'would be {C:attention}doubled{}.',
            '{C:inactive,s:0.8}(Does not work on: reroll)'
        }
    },
    config = { extra = {} },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    atlas = 'Fubuki_MFG',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { math.min(Holo.prob_norm() * 2 , 6 ) , } }
    end,
    calculate = function(self, card, context)
        if context.buying_card or context.hololive_buying_booster or context.hololive_buying_voucher then
            if Holo.chance('Fubuki',3) then
                context.card.cost = 0
                SMODS.calculate_effect({
                    message = 'Free!',
                    colour = G.C.MONEY,
                },context.card)
            else
                context.card.cost = context.card.cost * 2
                SMODS.calculate_effect({
                    message = 'Doubled!',
                    colour = G.C.MONEY,
                },context.card)
            end
        end
    end
}

----