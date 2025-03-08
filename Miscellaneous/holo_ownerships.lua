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
            local is_eyed = next(find_joker('j_hololive_Relic_Shion')) and card:get_id()==14
            return { vars = {
                Holo.prob_norm(),
                card.ability.extra.mult, is_eyed and 1 or 5,
                card.ability.extra.p_dollars, is_eyed and 3 or 15,
            } }
        end,
        atlas = "enhance_Lucky_Eye",
        pos = {x=0,y=0}
    }
)

----
