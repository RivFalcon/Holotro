----
SMODS.Atlas{
    key = "Relic_Origin",
    path = "Relics/Relic_Origin.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Tokino Sora
    member = "Sora",
    key = "Relic_Sora",
    loc_txt = {
        name = "Starlight of the First Idol",
        text = {
            'Each played card with {C:diamonds}Diamond{} suit',
            'that has the {C:attention}same rank{}',
            'as the {C:attention}first{} played card',
            'gives {X:mult,C:white}X#1#{} Mult when scored.',
            'Gain {X:mult,C:white}X#2#{} Mult before scoring',
            'if first played card is {C:diamonds}Diamond{} suit.'
        }
        ,boxes={4,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult=2, Xmult_mod=0.2,
        upgrade_args = {
            scale_var = 'Xmult',
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') and context.other_card:get_id()==context.full_hand[1]:get_id() then
                return {
                    Xmult=card.ability.extra.Xmult,
                    colour=Holo.C.Sora
                }
            end
        elseif context.before then
            if context.full_hand[1]:is_suit('Diamonds') then
                holo_card_upgrade(card)
            end
        end
    end
}

Holo.Relic_Joker{ -- Roboco
    member = "Roboco",
    key = "Relic_Roboco",
    loc_txt = {
        name = "Maintenance Tools of the High-spec Robot",
        text = {
            '{C:attention}Steel cards{} held in hand have',
            '{C:green}#3# in #4#{} chance to upgrade their Xmult',
            'by {X:mult,C:white}X#1#{} mult when triggered.',
            '{C:attention}Steel cards{} with {C:diamonds}Diamond{} suit are',
            '{C:green}guaranteed{} to be upgraded.'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { Xmult_mod=0.1, Xmult_mod_mod=0.02, odds=5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return {
            vars = {
                card.ability.extra.Xmult_mod,
                card.ability.extra.Xmult_mod_mod,
                Holo.prob_norm(),
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                local _tick = false
                if context.other_card:is_suit('Diamonds') then
                    _tick = true
                elseif Holo.chance('Roboco', card.ability.extra.odds) then
                    _tick = true
                end
                if _tick then
                    context.other_card.ability.h_x_mult = context.other_card.ability.h_x_mult + card.ability.extra.Xmult_mod
                    return {
                        message = localize('k_upgrade_ex'),
                        card = context.other_card
                    }
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Hoshimachi Suisei
    member = "Suisei",
    key = "Relic_Suisei",
    loc_txt = {
        name = "Golden Axe of the Stellar Diva",
        text = {
            'Each played card with {C:diamonds}Diamond{} suit,',
            'generates {C:attention}#3#~#4#{} stardust when scored.',
            'Collect {C:attention}18 {C:inactive}[#5#]{} stardust to form a {C:tarot}Star{}.',
            '(If no room, accumulate them {C:inactive}[#6#]{} until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The Star{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={4,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult=3, Xmult_mod=1,
        dust_min=1, dust_max=3,
        accumulate=0,
        upgrade_args = {
            scale_var = 'Xmult',
        },
        count_args = {
            down = 18,
            init = 18
        }
    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.dust_min,
                card.ability.extra.dust_max,
                card.ability.extra.count_args.down,
                card.ability.extra.accumulate
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_star')
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                local stardust = pseudorandom('Suisei', cae.dust_min, cae.dust_max)
                if holo_card_counting(card, stardust) then
                    cae.accumulate = cae.accumulate + 1
                    holo_card_disaccumulate(cae, 'c_star')
                    return {
                        message='Star!',
                        colour=HEX('7bacec')
                    }
                else
                    return {
                        message='Stardust! +'..stardust
                    }
                end
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult=cae.Xmult
            }
        end
        holo_card_disaccumulate(cae, 'c_star')
    end
}

Holo.Relic_Joker{ -- Sakura Miko
    member = "Miko",
    key = "Relic_Miko",
    loc_txt = {
        name = "Gohei of the Shrine Maiden",
        text = {
            'Each {C:red}discarded{} card with {C:attention}non{}-{C:diamonds}Diamond{} suits',
            'is thrown into {C:attention}lava{} and burned into {C:attention}#3#~#4#{} crisps.',
            'Collect {C:attention}#1# {C:inactive}[#2#]{} burnt crisp to create a {C:tarot}Star{}.',
            '(If no room, accumulate them {C:inactive}[#5#]{} until there is.)',
            'Earn {C:money}$35{} at end of round if your {C:attention}full deck',
            'has more {C:diamonds}Diamond{} cards',
            'than other suits combined.'
        }
        ,boxes={4,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        crisp_min=3, crisp_max=5,
        count_args={
            down=35, init=35
        },
        dummy_parameter = 0,
        accumulate = 0,
        upgrade_args = {
            scale_var = 'dummy_parameter'
        }
    }},
    upgrade_func = function(card)
        if not Holo.try_add_consumeable('c_star') then
            card.ability.extra.accumulate = card.ability.extra.accumulate + 1
        end
    end,
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        return {
            vars = {
                cae.count_args.init,
                cae.count_args.down,
                cae.crisp_min,
                cae.crisp_max,
                cae.accumulate,
            }
        }
    end,
    blueprint_compat = false,

    atlas = 'Relic_Origin',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.discard then
            if not context.other_card:is_suit('Diamonds')then
                local lavacrisp = pseudorandom('Miko', cae.crisp_min, cae.crisp_max)
                if holo_card_counting(card, lavacrisp) then
                    holo_card_upgrade(card)
                end
                return {
                    message='BURN! +'..lavacrisp,
                    remove=true
                }
            end
        end
        holo_card_disaccumulate(cae, 'c_star')
    end,
    calc_dollar_bonus = function(self, card)
        local D=0
        for _,v in ipairs(G.playing_cards)do
            if v:is_suit('Diamonds') then D=D+2 end
        end
        if D>#G.playing_cards then return 35 end
        return 0
    end
}

Holo.Relic_Joker{ -- AZKi
    member = "AZKi",
    key = "Relic_AZKi",
    loc_txt = {
        name = "Mic and Map of the Navigator Diva",
        text = {
            'Each {C:diamonds}Diamond{} card held in hand',
            'is retriggered {C:attention}#1#{} times.',
            'Gain {C:attention}1{} retrigger if',
            '{C:attention}first drawn hand{} of round',
            'contains a {C:attention}#2#{} of {C:diamonds}Diamond{}.',
            'Rank changes at end of round.'
        }
        ,boxes={2,3,1}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers=2, rank='Ace', id = 14,
        upgrade_args = {
            scale_var = 'retriggers',
            message = 'Guess!',
        }
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers,
                localize(card.ability.extra.rank, 'ranks'),
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand then
            if context.other_card:is_suit('Diamonds') then
                return {
                    message=localize('k_again_ex'),
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                    colour=Holo.C.AZKi
                }
            end
        elseif context.first_hand_drawn then
            for _,v in ipairs(G.hand.cards) do
                if v:get_id()==card.ability.extra.id and v:is_suit('Diamonds') then
                    holo_card_upgrade(card)
                    break
                end
            end
        elseif context.end_of_round and context.cardarea == G.jokers then
            local pool = {}
            for _,v in ipairs(G.playing_cards)do
                if v:is_suit('Diamonds') and not SMODS.has_no_rank(v) then
                    pool[#pool+1] = v.base
                end
            end
            if pool[1] then
                local _base = pseudorandom_element(pool, pseudoseed('AZKi'))
                card.ability.extra.rank = _base.value
                card.ability.extra.id = _base.id
            else
                card.ability.extra.rank = 'Ace'
                card.ability.extra.id = 14
            end
        end
    end
}

----