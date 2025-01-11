----

SMODS.Atlas{
    key = "Ayame_DCDC",
    path = "Ayame_DCDC.png",
    px = 71,
    py = 95
}
SMODS.Joker{
    key = "Ayame_DCDC",
    talent = "Ayame",
    loc_txt = {
        name = "Which way, which way?",
        text = {
            'Played card gives {X:mult,C:white} X7 {} Mult when scored',
            'if played hand is a {C:attention}High Card{}.',
            '{C:inactive}(Docchi, docchi?){}'
        }
    },
    config = { extra = {} },
    rarity = 3,
    cost = 7,
    atlas = 'Ayame_DCDC',
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.scoring_name == 'High Card' then
                return {
                    Xmult_mod = 7,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { 7 } },
                    card = context.other_card
                }
            end
        end
    end
}

----