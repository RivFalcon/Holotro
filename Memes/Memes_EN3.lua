----

SMODS.Joker{
    member = "Nerissa",
    key = "Meme_Nerissa_tRB",
    loc_txt = {
        name = "The Raven Bunch",
        text = {
            '{X:mult,C:white}X6{} Mult if played hand',
            'contains a {C:attention}Four of a Kind{}.'
        }
    },
    config = { extra = {} },
    rarity = 3,
    cost = 10,
    --atlas = 'Meme_Nerissa_tRB',
    --pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands['Four of a Kind']) then
            return {Xmult=6}
        end
    end
}

----