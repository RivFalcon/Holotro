----

SMODS.Atlas{
    key = "Suisei_TLLL",
    path = "Meme_Suisei_TLLL.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "Meme_Suisei_TLLL",
    member = "Suisei",
    loc_txt = {
        name = "Talalala",
        text = {
            "Played cards with",
            "{C:diamonds}Diamond{} suit give",
            "{C:mult}+#1#{} Mult when scored.",
            "{C:inactive,s:0.8}(credit: reiruka@hana87z)"
        }
    },
    config = { extra = { mult = 10 } },
    rarity = 2,
    cost = 5,
    atlas = 'Suisei_TLLL',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                return {mult=card.ability.extra.mult}
            end
        end
    end
}

----