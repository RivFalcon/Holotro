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
            'Each played card with {C:diamonds}Diamond{} suit that',
            'has the {C:attention}same rank{} as the {C:attention}first played card',
            'gives {X:mult,C:white}X#1#{} Mult when scored.'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { Xmult=2, Xmult_mod=0.2 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') and context.other_card:get_id()==context.full_hand[1]:get_id() then
                card:juice_up()
                return {
                    Xmult=card.ability.extra.Xmult,
                }
            end
        end
    end
}

Holo.Relic_Joker{ -- Roboco-san
    member = "Roboco",
    key = "Relic_Roboco",
    loc_txt = {
        name = "Maintainance Tool of the High-spec Robot",
        text = {
            '{C:attention}Steel cards{} held in hand has {C:green}#3# in #4#{} chance to',
            'upgrade their Xmult by {X:mult,C:white}X#1#{} mult when triggered.',
            '{C:attention}Steel cards{} with {C:diamonds}Diamond{} suit are instead',
            '{C:green}guaranteed{} to be upgraded.'
        }
        ,boxes={2,2}
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

    upgrade = function(self, card)
    end,
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
                    card:juice_up()
                    context.other_card.ability.config.h_x_mult = context.other_card.ability.config.h_x_mult + card.ability.extra.Xmult_mod
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
            'Gain {X:mult,C:white}X#2#{} mult every time {C:tarot}The Star',
            'card is used. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={4,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { Xmult=3, Xmult_mod=1, dust_min=1, dust_max=3, count_down=18, accumulate=0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.dust_min,
                card.ability.extra.dust_max,
                card.ability.extra.count_down,
                card.ability.extra.accumulate
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_suit('Diamonds') then
                local stardust = pseudorandom('Suisei', card.ability.extra.dust_min, card.ability.extra.dust_max)
                card.ability.extra.count_down = card.ability.extra.count_down - stardust
                if card.ability.extra.count_down <=0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 18
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = function ()
                                SMODS.add_card({ key = 'c_star', area = G.consumeables})
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                                return true
                            end
                        }))
                    else
                        card.ability.extra.accumulate = card.ability.extra.accumulate + 1
                    end
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
        elseif context.using_consumeable and not context.blueprint then
            if context.consumeable.config.center.key == 'c_star' then
                self:upgrade(card)
                return {
                    message=localize('k_upgrade_ex'),
                    colour=HEX('7bacec')
                }
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult=card.ability.extra.Xmult
            }
        end
        if card.ability.extra.accumulate>=1 then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                card.ability.extra.accumulate = card.ability.extra.accumulate - 1
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        SMODS.add_card({ key = 'c_star', area = G.consumeables})
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                        return true
                    end
                }))
            end
        end
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
            'Collect {C:attention}#1# {C:inactive}[#2#]{} burnt crisp to create a {C:dark_edition}Negative {C:tarot}Star{}.',
            'Earn {C:money}$#1#{} at end of round if your {C:attention}full deck',
            'has more {C:diamonds}Diamond{} cards than other suits combined.'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { crisp_min=3, crisp_max=5, count_down=35 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        return {
            vars = {
                35,
                card.ability.extra.count_down,
                card.ability.extra.crisp_min,
                card.ability.extra.crisp_max
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    upgrade = function(self, card)
        SMODS.add_card({ key = 'c_star', area = G.consumeables, edition = 'e_negative' })
    end,
    calculate = function(self, card, context)
        if context.discard then
            if not context.other_card:is_suit('Diamonds')then
                local lavacrisp = pseudorandom('Miko', card.ability.extra.crisp_min, card.ability.extra.crisp_max)
                card.ability.extra.count_down = card.ability.extra.count_down - lavacrisp
                if card.ability.extra.count_down <=0 then
                    card.ability.extra.count_down = card.ability.extra.count_down + 35
                    self:upgrade(card)
                end
                return {
                    message='BURN! +'..lavacrisp,
                    remove=true
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        local D=0
        for _,v in ipairs(G.playing_cards)do
            if v:is_suit('Diamonds') then D=D+2 end
        end
        if D>#G.playing_cards then return 35 end
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
            'Gain {C:attention}1{} retrigger for every {C:attention}#3# {C:inactive}[#4#]{} played',
            '{C:attention}#2#{} of {C:diamonds}Diamonds{} in first hand.',
            'Rank changes at end of round.'
        }
        ,boxes={2,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = { retriggers=2, rank='Ace', id = 14, count=5, count_down=5 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers,
                localize(card.ability.extra.rank, 'ranks'),
                card.ability.extra.count,
                card.ability.extra.count_down,
            }
        }
    end,

    atlas = 'Relic_Origin',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    upgrade = function(self, card)
        card:juice_up()
        card.ability.extra.retriggers = card.ability.extra.retriggers + 1
        return {
            message='Guess!',
            colour=HEX('fa3689')
        }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit('Diamonds') then
                return {
                    message=localize('k_again_ex'),
                    retriggers = card.ability.extra.retriggers,
                    colour=HEX('fa3689')
                }
            end
        elseif context.before then
            if G.GAME.current_round.hands_played == 0 then
                for _,v in ipairs(context.full_hand)do
                    if v:get_id()==card.ability.extra.id and v:is_suit('Diamonds') then
                        card.ability.extra.count_down = card.ability.extra.count_down - 1
                        if card.ability.extra.count_down<=0 then
                            card.ability.extra.count_down = card.ability.extra.count_down + card.ability.extra.count
                            self:upgrade(card)
                        end
                    end
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