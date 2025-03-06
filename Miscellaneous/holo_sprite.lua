----
SMODS.Atlas{
    key = "Pebble",
    path = "textures/Pebble.png",
    px = 71,
    py = 95
}
SMODS.Enhancement:take_ownership(
    'm_stone',
    {
        atlas = "Pebble",
        pos = {x=0,y=0}
    }
)

SMODS.Atlas{
    key = "Lucky_Eye",
    path = "textures/Lucky_Eye.png",
    px = 71,
    py = 95
}
SMODS.Enhancement:take_ownership(
    'm_lucky',
    {
        loc_vars = function(self, info_queue, card)
            local is_eyed = next(find_joker('j_hololive_Relic_Shion')) and card:get_id()==14
            return { vars = {
                G.GAME.probabilities.normal,
                card.ability.extra.mult, is_eyed and 1 or 5,
                card.ability.extra.p_dollars, is_eyed and 3 or 15,
            } }
        end,
        atlas = "Lucky_Eye",
        pos = {x=0,y=0}
    }
)
----