----

SMODS.Enhancement:take_ownership(
    'm_stone',
    {
        atlas = "enhance_Pebble",
        pos = {x=0,y=0}
    }
)

SMODS.Enhancement:take_ownership(
    'm_lucky',
    {
        loc_vars = function(self, info_queue, card)
            local is_ace = (card and card.base and card.base.id or 0)==14 or false
            local is_eyed = next(find_joker('j_hololive_Relic_Shion')) and is_ace
            return { vars = {
                Holo.prob_norm(),
                card.ability.mult, is_eyed and 1 or 5,
                card.ability.p_dollars, is_eyed and 3 or 15,
            } }
        end,
        atlas = "enhance_Lucky_Eye",
        pos = {x=0,y=0}
    }
)

----
