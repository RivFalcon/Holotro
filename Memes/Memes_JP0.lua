----

SMODS.Atlas{
    key = "Suisei_TLLL",
    path = "Memes/Meme_Suisei_TLLL.png",
    px = 71,
    py = 95
}
Holo.Meme_Joker{ -- Suisei -- Talalala -- https://youtu.be/_RPkBzv2jYc
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
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    atlas = 'Suisei_TLLL',
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                return {mult=card.ability.extra.mult}
            end
        end
    end
}

SMODS.Atlas{
    key = "Miko_GMKRTA",
    path = "Memes/Meme_Miko_GMKRTA.png",
    px = 71,
    py = 95
}
Holo.Meme_Joker{ -- Miko -- Gomoku RTA -- https://youtu.be/0IYqY9I2LzI
    key = "Meme_Miko_GMKRTA",
    member = "Miko",
    loc_txt = {
        name = "Connect-Five Speedrun",
        text = {
            "{C:mult}+23.76{} Mult",
            "on {C:attention}first hand{} of round",
            "if it has {C:attention}exactly",
            "{C:attention}five{} scoring cards."
        }
    },
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,
    config = { extra = {  } },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    atlas = 'Miko_GMKRTA',
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.joker_main then
            if (G.GAME.current_round.hands_played == 0) and (#context.scoring_hand == 5) then
                return {mult=23.76}
            end
        end
    end
}
----