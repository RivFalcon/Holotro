----
SMODS.Atlas{
    key = "Relic_Exodia",
    path = "Relics/Relic_Exodia.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Minato Aqua
    member = "Aqua",
    key = "Relic_Aqua",
    loc_txt = {
        name = "Headpiece of the House Maid",
        text = {
            'If played hand has only {C:attention}one{} card,',
            'it gives {X:mult,C:white}X#1#{} mult when scored.',
            'Clean away {C:attention}lowest{} ranked card',
            'held in hand at {C:attention}end of round',
            'if your hand contains {C:attention}more than one{} rank.'
        }
        ,boxes={2,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { Xmult = 44.5, chip_mod = 10 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.chip_mod,
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and #context.full_hand <= 1 then
            card:juice_up()
            return {Xmult=card.ability.extra.Xmult}
        elseif context.end_of_round and context.cardarea == G.jokers then
            local _card_min = G.hand.cards[1]
            local _card_max_rank = G.hand.cards[1]:get_id()
            for i=2,#G.hand.cards do
                if not SMODS.has_no_rank(G.hand.cards[i]) then
                    if G.hand.cards[i]:get_id() <= _card_min:get_id() then
                        _card_min = G.hand.cards[i]
                    end
                    if G.hand.cards[i]:get_id() > _card_max_rank then
                        _card_max_rank = G.hand.cards[i]:get_id()
                    end
                end
            end
            if _card_min:get_id() < _card_max_rank then
                play_sound('whoosh')
                _card_min:juice_up()
                _card_min:start_dissolve(nil, true)
                for _,J in ipairs(G.jokers.cards) do
                    eval_card(J, {cardarea = G.jokers, remove_playing_cards = true, removed = {_card_min,}})
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Murasaki Shion
    member = "Shion",
    key = "Relic_Shion",
    loc_txt = {
        name = "Eye of the Magician",
        text = {
            '{C:attention}Lucky Aces {C:green}guarantee{} to give {C:mult}+#3#{} mult',
            'and have {C:green}#4# in #5#{} chance to win {C:money}$#6#',
            'instead when scored.',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The Magician{} card used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 2, Xmult_mod = 0.25,
        new_mult_odds = 1, new_p_dollars_odds = 3,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Magic!',
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_magician
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.P_CENTERS.m_lucky.config.mult,
                Holo.prob_norm(),
                3,
                G.P_CENTERS.m_lucky.config.p_dollars
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        holo_card_upgrade_by_consumeable(card, context, 'c_magician')
        if context.joker_main then
            card:juice_up()
            return {Xmult=card.ability.extra.Xmult}
        end
    end
}

Holo.Relic_Joker{ -- Nagiri Ayame
    member = "Ayame",
    key = "Relic_Ayame",
    loc_txt = {
        name = "Mask of the Oni",
        text = {
            'If played hand is a {C:attention}High Card{},',
            'retrigger each scored card {C:attention}#5#{} times.',
            'Each {C:attention}Ace{} held in hand has',
            '{C:green}#3# in #4#{} chance to give {X:mult,C:white}X#1#{} Mult.',
            'Gain {X:mult,C:white}X#2#{} mult when {C:attention}Boss Blind{} is defeated.'
        }
        ,boxes={2,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 2, Xmult_mod = 0.1,
        retriggers = 7,
        odds = 2,
        count_up = 0,
        upgrade_args = {
            scale_var = 'Xmult',
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                Holo.prob_norm(),
                card.ability.extra.odds,
                card.ability.extra.retriggers,
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.scoring_name == "High Card" then
                return {
                    message = 'Hai!',
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    colour = Holo.C.Ayame
                }
            end
        elseif context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id()==14 then
                if Holo.chance('Yo~dayo', card.ability.extra.odds) then
                    return {
                        message='Yo!',
                        colour=Holo.C.Ayame,
                        Xmult=card.ability.extra.Xmult
                    }
                end
            end
        elseif context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss and not context.blueprint then
            holo_card_upgrade(card)
        end
    end
}

Holo.Relic_Joker{ -- Yuzuki Choco
    member = "Choco",
    key = "Relic_Choco",
    loc_txt = {
        name = "Syringe of the Demon Nurse",
        text = {
            'Each card held in hand gets {C:attention}injected',
            'with a syringe at {C:attention}end of round{}.',
            'If injected card is an {C:attention}Ace{}, gain {X:mult,C:white}X#2#{} mult;',
            'othrerwise each injected card has',
            '{C:green}#3# in #4#{} chance to increase its {C:attention}rank{}.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,4}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 2, Xmult_mod = 0.2,
        odds = 2,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Love!',
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                Holo.prob_norm(),
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        if context.end_of_round and context.individual then
            context.other_card:juice_up()
            if context.other_card:get_id()>=14 then
                holo_card_upgrade(card)
            elseif not SMODS.has_no_rank(context.other_card) then
                if Holo.chance('Chocosen', card.ability.extra.odds) then
                    local rank_shift_string = {'2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace'}
                    assert(SMODS.change_base(context.other_card, nil, rank_shift_string[context.other_card.base.id]))
                end
            end
            return {
                message="Inject!",
                colour = HEX('fe739c'),
                card=context.other_card
            }
        elseif context.joker_main then
            card:juice_up()
            return {Xmult=card.ability.extra.Xmult}
        end
    end
}

SMODS.Atlas{ -- Oozora Subaru: Handcuff Sprite
    key = "Sticker_Handcuff",
    path = "textures/Sticker_Handcuff.png",
    px = 71,
    py = 95
}
SMODS.Sticker{ -- Oozora Subaru: Handcuff
    member = "Subaru",
    key = "handcuff",
    loc_txt = {
        name = "Handcuff mark",
        text = {
            'The card with this mark',
            'get sent to jail when discarded.',
            '{C:inactive}(Remove this sticker',
            '{C:inactive}by scoring this card.)'
        }
    },
    atlas='hololive_Sticker_Handcuff',
    pos={x=0,y=0},
    badge_colour=Holo.C.Subaru,
    default_compat=true,
    should_apply = function(self, card, center, area, bypass_roll)
        return (area==G.play)
    end,
    calculate = function(self, card, context)
        if context.before and SMODS.in_scoring(card, context.scoring_hand) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:remove_sticker('hololive_handcuff')
                    return true
                end
            }))
            return {
                message='Released!',
                colour=Holo.C.Subaru,
            }
        elseif context.discard then
            if context.other_card == card then
                return {remove=true}
            end
        end
    end
}

Holo.Relic_Joker{ -- Oozora Subaru
    member = "Subaru",
    key = "Relic_Subaru",
    loc_txt = {
        name = "Whistle of the Duck Officer",
        text = {
            'Played card that {C:red}did not score',
            'will be {C:attention}arrested{}.',
            'Gain {X:mult,C:white}X#2#{} mult when playing a hand',
            'with {C:attention}no{} cards arrested.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult=2, Xmult_mod=0.5,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Peace!'
        }
    }},
    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue+1] = {set='Sticker',key='hololive_handcuff'}
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.before then
            local peace = true
            for _,played_card in ipairs(context.full_hand)do
                if not SMODS.in_scoring(played_card, context.scoring_hand) then
                    peace = false
                    if not played_card.ability.hololive_handcuff then
                        SMODS.calculate_effect(
                            {
                                message='Arrested!',
                                colour=Holo.C.Subaru
                            },
                            played_card
                        )
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                played_card:add_sticker('hololive_handcuff')
                                return true
                            end
                        }))
                    end
                end
            end
            if peace then
                -- This can also be "if #context.full_hand==#context.scoring_hand then",
                -- but I'm very afraid if something would go wrong, so...
                G.E_MANAGER:add_event(Event({
                    func = function()
                        holo_card_upgrade(card)
                        return true
                    end
                }))
            end
        elseif context.joker_main then
            return{Xmult=card.ability.extra.Xmult}
        end
    end
}

----