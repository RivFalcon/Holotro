----
SMODS.Atlas{
    key = "Relic_Fantasy",
    path = "Relics/Relic_Fantasy.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Usada Pekora
    member = "Pekora",
    key = "Relic_Pekora",
    loc_txt = {
        name = "Slot Machine of the Greedy Rabbit",
        text = {
            'At the end of round, take {C:money}$#3#{} to pull the lever,',
            '{C:inactive}(Must have enough {C:money}${C:inactive})',
            '{C:green}#1# in #2#{} chance to {C:attention}hit the jackpot{} and gain {C:money}$#4#{}.',
            '{C:inactive}(The odds goes down per {C:attention}Gold Card{C:inactive} in your deck)'
        }
    },
    config = { extra = { odds = 50, fee = 7, prize = 777 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        return {
            vars = {
                G.GAME.probabilities.normal,
                self:get_odds(card),
                card.ability.extra.fee,
                card.ability.extra.prize
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    get_odds = function(self, card)
        local _odds = card.ability.extra.odds
        if G.playing_cards then
            for k,v in pairs(G.playing_cards) do
                if SMODS.has_enhancement(v, "m_gold") then
                    _odds = _odds - 1
                end
            end
        end
        return math.max(_odds,1)
    end,
    update = function(self, card, dt) -- Anti-rig
        if card.ability.extra.odds ~= 50 then card.ability.extra.odds = 50 end
        if card.ability.extra.fee ~= 7 then card.ability.extra.fee = 7 end
        if card.ability.extra.prize ~= 777 then card.ability.extra.prize = 777 end
    end,
    upgrade = function (self, card)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.game_over then
            if G.GAME.dollars >= card.ability.extra.fee then
                ease_dollars(-self.ability.extra.fee)
                if pseudorandom('pekora') < G.GAME.probabilities.normal / self:get_odds(card) then
                    self:juice_up()
                    card_eval_status_text(self, 'dollars', nil, 1, nil, {message='JACKPOT!',colour=HEX('7dc4fc')})
                    ease_dollars(card.ability.extra.prize)
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Uruha Rushia
    member = "Rushia",
    key = "Relic_Rushia",
    loc_txt = {
        name = "Butterfies of the Necromancer",
        text = {
            'Prevents Death once.',
            '{C:red}self destructs{}',
            'Selling this card spawns',
            '#1# {C:attention}Butterfly Tags{}.'
        }
        ,boxes={2,2}
    },
    config = { extra = { summon = 2 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_hololive_butterfly
        return {
            vars = {
                card.ability.extra.summon
            }
        }
    end,
    blueprint_compat = false,

    atlas = 'Relic_Fantasy',
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.game_over then
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                    card:start_dissolve()
                    return true
                end
            }))
            return {
                message = localize('k_saved_ex'),
                saved_by_necromancy = true,
                colour = HEX('04e3cb')
            }
        elseif context.selling_self then
            for i=1, card.ability.extra.summon do
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_hololive_butterfly'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
            end
        end
    end
}

Holo.Relic_Joker{ -- Shiranui Flare
    member = "Flare",
    key = "Relic_Flare",
    loc_txt = {
        name = "Paint Splasher of the Fire Elf",
        text = {
            'Spray {C:attention}Gold{} paint on scored cards',
            'if played hand contains a {C:attention}Two Pair{}.',
            'Each card has {C:green}#3# in #4#{} chance to receive',
            'a {C:attention}Gold seal{} when being spray-painted.',
            'Gain {X:mult,C:white}X#2#{} mult per card sprayed.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,2,2}
    },
    config = { extra = { Xmult = 4, Xmult_mod = 0.25, odds = 4 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_SEALS.Gold
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                G.GAME.probabilities.normal,
                card.ability.extra.odds
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    upgrade = function (self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if next(context.poker_hands['Two Pair']) then
                for k,v in ipairs(context.scoring_hand) do
                    v:set_ability(G.P_CENTERS.m_gold, nil, true)
                    self:upgrade(card)
                    card_eval_status_text(v, 'jokers', nil, 1, nil, {message="Painted!",colour = HEX('ff5028')})
                    if pseudo('flare') < G.GAME.probabilities.normal / card.ability.extra.odds then
                        v:set_seal('Gold', nil, true)
                    end
                end
            end
        elseif context.joker_main then
            card:juice_up()
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

Holo.Relic_Joker{ -- Shirogane Noel
    member = "Noel",
    key = "Relic_Noel",
    loc_txt = {
        name = "Mace of the Silver Knight",
        text = {
            'If played hand contains a {C:attention}Two Pair{},',
            'retrigger all {C:attention}metal cards{} held in hand',
            'once per {C:attention}King{} in scored hand.'
        }
    },
    config = { extra = { retriggers = 0 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return {
            vars = {
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    upgrade = function (self, card)
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.ability.extra.retriggers = 0
            if next(context.poker_hands['Two Pair']) then
                for k,v in ipairs(context.scoring_hand) do
                    if v:get_id() == 13 then
                        card.ability.extra.retriggers = card.ability.extra.retriggers + 1
                    end
                end
            end
        elseif context.repetition and context.cardarea == G.hand then
            if next(context.poker_hands['Two Pair']) then
                if SMODS.has_enhancement(context.other_card, "m_gold") or SMODS.has_enhancement(context.other_card, "m_steel") then
                    return {
                        message = 'Knight!',
                        repetitions = card.ability.extra.retriggers,
                        card = card,
                        colour = HEX('aebbc3')
                    }
                end
            end
        end
    end
}

Holo.Relic_Joker{ -- Houshou Marine
    member = "Marine",
    key = "Relic_Marine",
    loc_txt = {
        name = "Treasure Box of the Pirate Captain",
        text = {
            'Takes {C:money}$1{} per purchase at the shop.',
            'Gives you back {X:money,C:white}X#1#{} the amount at {C:attention}end of shop{}.',
            '{C:inactive}(Currently {C:money}$#4#{C:inactive} taken)',
            'Multiplier goes up by {X:money,C:white}X#2#{} every {C:attention}17',
            '{C:inactive}[#3#]{} triggered {C:attention}Gold cards{} held in hand.'
        }
        ,boxes={3,2}
    },
    config = { extra = { Mmult = 2, Mmult_mod = 1, count_down = 17, treasure = 0 } },
    unlock_condition = {type = '', extra = '', hidden = true},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Mmult,
                card.ability.extra.Mmult_mod,
                card.ability.extra.count_down,
                card.ability.extra.treasure
            }
        }
    end,

    atlas = 'Relic_Fantasy',
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    upgrade = function (self, card)
        card:juice_up()
        play_sound('generic1')
        card.ability.extra.Mmult = card.ability.extra.Mmult + card.ability.extra.Mmult_mod
        card_eval_status_text(card, 'jokers', nil, 1, nil, {message="Ahoy!",colour = HEX('923749')})
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, "m_gold") then
                card.ability.extra.count_down = card.ability.extra.count_down - 1
                if card.ability.extra.count_down <= 0 then
                    card.ability.extra.count_down = 17
                    self:upgrade(card)
                end
            end
        elseif context.buying_card then
            ease_dollars(-1)
            card.ability.extra.treasure = card.ability.extra.treasure + 1
        elseif context.ending_shop then
            ease_dollars(card.ability.extra.treasure * card.ability.extra.Mmult)
            card.ability.extra.treasure = 0
        end
    end
}

----