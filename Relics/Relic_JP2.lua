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
        name = "Cleaning Kits of the House Maid",
        text = {
            'If played hand has only {C:attention}one{} card,',
            'it gives {X:mult,C:white}X#1#{} mult when scored.',
            'Otherwise, lose {C:chips}#2#{} chips',
            'per played card {C:attention}more than one',
            'due to {C:inactive}social awkwardness{}.'
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
        elseif context.before and #context.full_hand > 1 then
            local lose_chips = card.ability.extra.chips * (#context.full_hand - 1)
            hand_chips = mod_chips(hand_chips - lose_chips)
            card_eval_status_text(card, 'jokers', nil, 1, nil,{
                message= localize{type='variable',key='a_chips_minus',vars={lose_chips}},
                colour = HEX('3c0024'), instant=true
            })
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
            'retrigger each scored card {C:attention}#1#{} times.',
            '+1 retrigger every {C:attention}7 Aces',
            'in your {C:attention}full deck{}.'
        }
        ,boxes={2,2}
        ,unlock={
            "{E:1,s:1.3}?????",
        }
    },
    config = { extra = { retriggers = 7 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self:get_retriggers(card),
            }
        }
    end,
    get_retriggers = function(self, card)
        local _retrigger = card.ability.extra.retriggers
        if G.playing_cards then
            local _tally = 0
            for k,v in pairs(G.playing_cards)do
                if v:get_id()==14 then
                    _tally = _tally + 1
                    if tally%7==0 then
                        _retrigger = _retrigger + 1
                    end
                end
            end
        end
        return _retrigger
    end,

    atlas = 'Relic_Exodia',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    upgrade = function(self, card)
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.scoring_name == "High Card" then
                return {
                    message = 'Hai!',
                    repetitions = self:get_retriggers(card),
                    card = card,
                    colour = HEX('c72554')
                }
            end
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
            'If injected card is an {C:attention}Ace{}, gain {X:mult,C:white}X#2#{} mult,',
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
            card_eval_status_text(context.other_card, 'extra', nil, 1, nil, {message="Inject!",colour = HEX('fe739c'),instant=true})
            if context.other_card:get_id()>=14 then
                self:upgrade(card)
            elseif pseudorandom('Choco') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    local _card = context.other_card
                    local suit_prefix = string.sub(_card.base.suit, 1, 1)..'_'
                    local rank_suffix = _card.base.id+1
                    if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
                    elseif rank_suffix == 10 then rank_suffix = 'T'
                    elseif rank_suffix == 11 then rank_suffix = 'J'
                    elseif rank_suffix == 12 then rank_suffix = 'Q'
                    elseif rank_suffix == 13 then rank_suffix = 'K'
                    elseif rank_suffix == 14 then rank_suffix = 'A'
                    end
                    _card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                return true end }))
            end
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