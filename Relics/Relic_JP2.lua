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
        ,unlock={
            "{E:1,s:1.3}?????",
        }
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

    upgrade = function(self, card)
    end,
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
        ,unlock={
            "{E:1,s:1.3}?????",
        }
    },
    config = { extra = { Xmult = 2, Xmult_mod = 0.25, new_mult_odds = 1, new_p_dollars_odds = 3} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_magician
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.P_CENTERS.m_lucky.config.mult,
                G.GAME.probabilities.normal,
                card.ability.extra.new_p_dollars_odds,
                G.P_CENTERS.m_lucky.config.p_dollars
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    add_to_deck = function(self, card, from_debuff)
        for k,v in pairs(G.playing_cards)do
            if SMODS.has_enhancement(v,'m_lucky') and v:get_id()==14 then
                v.ability.config.mult_odds = card.ability.extra.mult_odds
                v.ability.config.p_dollars_odds = card.ability.extra.p_dollars_odds
            end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k,v in pairs(G.playing_cards)do
            if SMODS.has_enhancement(v,'m_lucky') then
                v.ability.config.mult_odds = 5
                v.ability.config.p_dollars_odds = 15
            end
        end
    end,
    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Magic!",colour = HEX('8565fc')})
    end,
    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.config.center.key == 'c_magician' then
                self:upgrade(card)
            end
        elseif context.joker_main then
            card:juice_up()
            return {Xmult=card.ability.extra.Xmult}
        end
        for k,v in pairs(G.playing_cards)do
            if SMODS.has_enhancement(v,'m_lucky') then
                if v:get_id()==14 then
                    v.ability.config.mult_odds = card.ability.extra.mult_odds
                    v.ability.config.p_dollars_odds = card.ability.extra.p_dollars_odds
                else
                    v.ability.config.mult_odds = 5
                    v.ability.config.p_dollars_odds = 15
                end
            end
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
        ,unlock={
            "{E:1,s:1.3}?????",
        }
    },
    config = { extra = {
        Xmult = 2,
        Xmult_mod = 0.1,
        retriggers = 7,
        odds = 2,
        count_up = 0
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.GAME.probabilities.normal,
                card.ability.extra.odds,
                card.ability.extra.retriggers,
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.scoring_name == "High Card" then
                return {
                    message = 'Hai!',
                    repetitions = card.ability.extra.get_retriggers(),
                    card = card,
                    colour = HEX('c72554')
                }
            end
        elseif context.individual and context.cardarea == G.hand and not context.end_of_round then
            if holo_chance('Yo~dayo', card.ability.extra.odds) then
                return {
                    message='Yo!',
                    colour=HEX('c72554'),
                    Xmult=card.ability.extra.Xmult
                }
            end
        elseif context.end_of_round and G.GAME.blind.boss then
            self:upgrade(card)
            return {
                message=localize('k_upgrade_ex'),
                colour=HEX('c72554')
            }
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
        ,unlock={
            "{E:1,s:1.3}?????",
        }
    },
    config = { extra = { Xmult = 2, Xmult_mod = 0.2, odds = 2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.GAME.probabilities.normal,
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Love!",colour = HEX('fe739c')})
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.individual then
            context.other_card:juice_up()
            if context.other_card:get_id()>=14 then
                self:upgrade(card)
            elseif not SMODS.has_no_rank(context.other_card) then
                if holo_chance('Chocosen', card.ability.extra.odds) then
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

SMODS.Atlas{ -- Oozora Subaru
    key = "Sticker_Handcuff",
    path = "textures/Sticker_Handcuff.png",
    px = 71,
    py = 95
}
SMODS.Sticker{ -- Oozora Subaru
    key = "handcuff",
    loc_txt = {
        name = "Handcuff mark",
        text = {
            'Arrested time: #1#',
            'This card will go to jail',
            'on its third arrest.'
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            card.ability.arrested,
        }
    end,
    atlas='hololive_Sticker_Handcuff',
    pos={x=0,y=0},
    hide_badge=true,
    default_compat=true,
    sets={
        Default = true,
        Enhanced = true,
    },
}

Holo.Relic_Joker{ -- Oozora Subaru
    member = "Subaru",
    key = "Relic_Subaru",
    loc_txt = {
        name = "Whistle of the Duck Officer",
        text = {
            'Played card that didn\'t score will be {C:attention}arrested{}.',
            'Playing cards {C:red}go to jail{} on their {C:attention}third{} arrest.',
            'Gain {X:mult,C:white}X#2#{} mult if {C:attention}no card{} is arrested',
            'in current played hand. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,2}
        ,unlock={
            "{E:1,s:1.3}?????",
        }
    },
    config = { extra = { Xmult=2, Xmult_mod=0.5 } },
    loc_vars = function(self, info_queue, card)
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

    remove_from_deck = function(self, card, from_debuff)
        for k,v in ipairs(G.playing_cards)do
            v:remove_sticker('hololive_handcuff')
        end
    end,
    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Peace!",colour = HEX('e5ed76')})
    end,
    calculate = function(self, card, context)
        if context.after then
            if #context.full_hand > #context.scoring_hand then
                local is_scoring_card
                for _,played_card in ipairs(context.full_hand)do
                    is_scoring_card = false
                    for _,scoring_card in ipairs(context.scoring_hand)do
                        if played_card == scoring_card then
                            is_scoring_card = true
                            break
                        end
                    end
                    if not is_scoring_card then
                        if played_card.ability.arrested == nil then
                            played_card:add_sticker('hololive_handcuff')
                            played_card.ability.arrested = 1
                        elseif played_card.ability.arrested == 1 then
                            played_card.ability.arrested = 2
                        elseif played_card.ability.arrested == 2 then
                            played_card:juice_up()
                            played_card:start_dissolve(nil, true)
                            for _,J in ipairs(G.jokers.cards) do
                                eval_card(J, {cardarea = G.jokers, remove_playing_cards = true, removed = {played_card,}})
                            end
                        end
                    end
                end
            else
                self:upgrade(card)
            end
        elseif context.joker_main then
            card:juice_up()
            return{Xmult=card.ability.extra.Xmult}
        end
    end
}

----