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
            'Highest ranked scoring card',
            'gives {X:mult,C:white}X7{} Mult when scored',
            'if played hand is a {C:attention}High Card{}.',
            '{C:inactive}(Docchi, docchi?)'
        }
    },
    rarity = 3,
    cost = 7,
    atlas = 'Ayame_DCDC',
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.scoring_name == 'High Card' then
                local highest_rank = 0
                for _,v in ipairs(context.scoring_hand)do
                    highest_rank = math.max(highest_rank, v:get_id())
                end
                if context.other_card:get_id()==highest_rank then
                    return {
                        Xmult = 7,
                        colour = Holo.C.Ayame,
                    }
                end
            end
        end
    end
}

----