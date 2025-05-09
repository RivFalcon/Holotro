----

SMODS.Atlas{
    key = "Ayame_DCDC",
    path = "Memes/Meme_Ayame_DCDC.png",
    px = 71,
    py = 95
}
Holo.Meme_Joker{
    key = "Meme_Ayame_DCDC",
    member = "Ayame",
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
    blueprint_compat = true,
    atlas = 'Ayame_DCDC',
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.scoring_name == 'High Card' then
                if not context.other_card.debuff
                     and not SMODS.has_enhancement(context.other_card, "m_stone")
                     and not context.other_card.config.center.always_scores then
                    card:juice_up(0.5, 0.5)
                    return {
                        x_mult = 7,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { 7 } },
                        card = context.other_card
                    }
                end
            end
        end
    end
}

----