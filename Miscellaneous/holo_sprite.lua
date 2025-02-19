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
        config = {
            mult=20, p_dollars = 20,
            mult_odds=5, p_dollars_odds=15
        },
        atlas = "Lucky_Eye",
        pos = {x=0,y=0}
    }
)
----