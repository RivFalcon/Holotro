----

--[[
Holo.Meme_Joker{
    member = "Elizabeth",
    key = "Meme_Elizabeth_VM",
    loc_txt = {
        name = "Voice Mimicry",
        text = {
        }
    },
    config = { extra = {} },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
            }
        }
    end,
    rarity = 3,
    cost = 8,

    calculate = function(self, card, context)
    end
}
]]

Holo.Atlas_7195{
    key = 'Gigi_BGB',
    path = 'Memes/Meme_Gigi_BGB.png',
}
Holo.Meme_Joker{
    member = "Gigi",
    key = "Meme_Gigi_BGB",
    loc_txt = {
        name = "Boat goes binted",
        text = {
            "First played {C:attention}face{} card gives",
            "{X:mult,C:white}X#1#{} Mult when scored."
        }
    },
    config = { extra = {} },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                ((pseudorandom('Gigi_BoatGoesBinted_isdisplaying')<0.5) and '???')
                or (pseudorandom('Gigi_BoatGoesBinted_display',10,33)/10),
            }
        }
    end,
    rarity = 1,
    cost = 5,
    atlas = "Gigi_BGB",pos={x=0,y=0},
    pixel_size = {h=80},

    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            local is_first_face = false
            for _,scoring_card in ipairs(context.scoring_hand) do
                if scoring_card:is_face() then
                    is_first_face = (scoring_card == context.other_card)
                    break
                end
            end
            if is_first_face then
                return {
                    Xmult = pseudorandom('Gigi_BoatGoesBinted',10,33)/10
                }
            end
        end
    end
}

Holo.Atlas_7195{
    key = 'Raora_Doom',
    path = 'Memes/Meme_Raora_Doom.png',
}
Holo.Meme_Joker{
    member = "Raora",
    key = "Meme_Raora_Doom",
    loc_txt = {
        name = "Doom",
        text = {
            'Create a {C:spectral}Black Hole{} at {C:attention}end of round{},',
            'destroying at most {C:attention}#2#{} random',
            'cards in hand in the process.',
            '{C:inactive}(If no room, accumulate[#1#] until there is.)',
        }
    },
    config = { extra = { kill = 2, accumulate = 0 } },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_black_hole
        return {
            vars = {
                card.ability.extra.accumulate,
                card.ability.extra.kill,
            }
        }
    end,
    rarity = 3,
    cost = 8,
    atlas = "Raora_Doom",pos={x=0,y=0},

    calculate = function (self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and (#G.hand.cards>=card.ability.extra.kill) then
            local N = #G.hand.cards
            local a = pseudorandom('Raora_Doom_1',1,N)
            local destroyed_cards = {G.hand.cards[a],}
            if N>=2 then
                local b = ( a + pseudorandom('Raora_Doom_2',1,N-1) ) % N
                destroyed_cards[2] = G.hand.cards[b]
            end

            Holo.delayed_destruction(destroyed_cards)
            delay(0.3)
            SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })

            card.ability.extra.accumulate = card.ability.extra.accumulate + 1
        end
        -- Release the Black Holes until the consumable slot is full.
        if card.ability.extra.accumulate > 0 then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                card.ability.extra.accumulate = card.ability.extra.accumulate - 1
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        card:juice_up()
                        --play_sound('hololive_sound_Raora_Doom')
                        SMODS.add_card({ key = 'c_black_hole', area = G.consumeables })
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
            end
        end
    end
}

----