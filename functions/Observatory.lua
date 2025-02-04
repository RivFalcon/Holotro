----

local LUH = level_up_hand
function level_up_hand(card, hand, instant, amount)
    LUH(card, hand, instant, amount)
    for _,J in ipairs(G.jokers.cards) do
        J:calculate_joker({level_up_hand = hand, level_up_amount = amount})
    end
end

----