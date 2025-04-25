----


Holo.Atlas_7195{
    key = 'Mumei_Nightmare',
    path = 'Memes/Meme_Mumei_Nightmare.png'
    -- credit: https://www.youtube.com/live/m42h-F5zhng?si=kVMcgs1qi6cLqlC5&t=3143
}
Holo.Meme_Joker{ -- Mumei: Nightmare
    member = 'Mumei',
    key = 'Meme_Mumei_Nightmare',
    loc_txt = {
        name = "\"a mistake\"",
        text = {
            'Played {C:attention}face{} cards with {C:spades}Spade{} suit',
            'give {C:chips}#1#{} chips when scored.'
        }
    },
    config = { extra = { chips = 95 }},
    -- The painting was sold for 9486 in-game dollars. -- https://www.youtube.com/live/m42h-F5zhng?si=yMVzwInoeEmJA0QY&t=3269
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    atlas = 'Mumei_Nightmare',
    pos = {x=0,y=0},

    calculate = function(self, card, context)
        if context.individual and context.cardarea==G.play then
            if context.other_card:is_suit('Spades') and context.other_card:is_face() then
                return { chips = card.ability.extra.chips }
            end
        end
    end
}


----
