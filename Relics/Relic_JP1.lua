----
SMODS.Atlas{
    key = "Relic_First",
    path = "Relics/Relic_First.png",
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = "Relic_Gamers",
    path = "Relics/Relic_Gamers.png",
    px = 71,
    py = 95
}

Holo.Atlas_7195{
    key = "Sticker_Kapumark",
    path = "textures/Sticker_Kapumark.png",
}
SMODS.Sticker{ -- Yozora Mel: Kapu Mark
    member = "Mel",
    key='kapumark',
    loc_txt={
        name='Kapu mark',
        text={
            '{C:mult}+10.31{} mult',
            'when scored.'
        }
    },
    atlas = 'Sticker_Kapumark',
    pos = {x=0,y=0},
    badge_colour=Holo.C.Mel,
    should_apply = function(self, card, center, area, bypass_roll)
        local not_enhanced = card and card.playing_card and(center == G.P_CENTERS.c_base)or false
        return ((area==G.play)or bypass_roll)and not_enhanced
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then -- This doesn't work, for some reason.
            --print('Test Sticker')
            return {mult=10.31}
        end
    end
}
Holo.Relic_Joker{ -- Yozora Mel
    member = "Mel",
    key = "Relic_Mel",
    loc_txt = {
        name = "Bite of the Vampire",
        text = {
            'Each played {C:attention}Enhanced card{} gets {V:1}kapu{}\'d,',
            '{C:attention}loses the enhancement{} before scoring,',
            'and gives {C:mult}+10.31{} mult when scored.',
            'Gain {X:mult,C:white}X#2#{} mult per kapu.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.25,
        marking = {},
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Kapu!'
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                colours = {
                    Holo.C.Mel,
                }
            }
        }
    end,

    atlas = 'Relic_First',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.before and not context.blueprint then
            cae.marking = {}
            for k, v in ipairs(context.scoring_hand) do
                if not SMODS.has_enhancement(v, 'c_base') and not v.debuff and not v.vampired then
                    cae.marking[#cae.marking+1] = k
                    v.vampired = true
                    v:set_ability(G.P_CENTERS.c_base, nil, true)
                    holo_card_upgrade(card)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:add_sticker('hololive_kapumark')
                            v:juice_up()
                            v.vampired = nil
                            return true
                        end
                    }))
                end
            end
        elseif context.individual and context.cardarea==G.play then
            if context.other_card.ability.hololive_kapumark then -- This doesn't work, for some reason.
                --print('Test Joker')
                return {mult=10.31}
            end
            for _,k in ipairs(cae.marking)do --Temporary Solution
                if context.other_card == context.scoring_hand[k]then
                    return {mult=10.31}
                end
            end
        elseif context.after then
            cae.marking={}
            for _,v in ipairs(context.scoring_hand)do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:remove_sticker('hololive_kapumark')
                        return true
                    end
                }))
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                colour = Holo.C.Mel,
            }
        end
    end
}

Holo.Relic_Joker{ -- Shiragami Fubuki
    member = "Fubuki",
    key = "Relic_Fubuki",
    loc_txt = {
        name = "Pentagram Emblem of the King Fox",
        text = {
            'Create a {C:tarot}Foob{} card every {C:attention}#5# {C:inactive}[#4#]',
            '{C:attention}unenhanced{} playing card scored.',
            '(If no room, accumulate them {C:inactive}[#3#]{} until there is.)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The Foob{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.2,
        accumulate = 0,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Kon!',
            --sound = 'hololive_sound_Fubuki_Kon'
        },
        count_args = {
            down = 5, init = 5,
        },
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_fool
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.accumulate,
                cae.count_args.down,
                cae.count_args.init,
            }
        }
    end,

    atlas = 'Relic_Gamers',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_fool')
        if context.individual and context.cardarea==G.play then
            if SMODS.has_enhancement(context.other_card,'c_base') then
                if holo_card_counting(card) then
                    cae.accumulate = cae.accumulate + 1
                end
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                message = 'Ki~tsune!',
                colour=Holo.C.Fubuki,
            }
        end
        holo_card_disaccumulate(cae, 'c_fool')
    end
}

Holo.Relic_Joker{ -- Natsuiro Matsuri
    member = "Matsuri",
    key = "Relic_Matsuri",
    loc_txt = {
        name = "Taiko of the Summer Festival",
        text = {
            'Drumming on each played',
            '{C:attention}unenhanced{} cards for {C:attention}#1#{} beats.',
            'Each beat has {C:green}#2# in #3#{} chance to retrigger once.',
            'Beats on cards with {C:hearts}Heart{} suit',
            '{C:green}guarantees{} to give retriggers.',
            'Gain {C:attention}1{} beat when {C:attention}Boss Blind{} is defeated.'
        }
        ,boxes={2,4}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        beats = 5,
        odds = 2,
        upgrade_args = {
            scale_var = 'beats',
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.beats,
                Holo.prob_norm(),
                cae.odds,
            }
        }
    end,

    atlas = 'Relic_First',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.repetition and context.cardarea==G.play then
            if SMODS.has_enhancement(context.other_card, 'c_base') then
                local retriggers = 0
                if context.other_card:is_suit('Hearts') then
                    retriggers = cae.beats
                else
                    for _=1,cae.beats do
                        if Holo.chance('Matsuri Taiko', cae.odds) then
                            retriggers = retriggers + 1
                        end
                    end
                end
                return {
                    repetitions = retriggers,
                    colour = Holo.C.Matsuri,
                    sound = 'timpani'
                }
            end
        elseif context.end_of_round and context.cardarea==G.jokers and G.GAME.blind.boss and not context.blueprint then
            holo_card_upgrade(card)
        end
    end
}

Holo.Relic_Joker{ -- Aki Rosenthal
    member = "Aki",
    key = "Relic_Aki",
    loc_txt = {
        name = "Beer Mug of the Exotic Elf",
        text = {
            'Take a sip of beer from the mug {C:inactive}(#3#/21)',
            'before {C:blue}playing{} or {C:red}discarding{} a hand.',
            'Each {C:attention}unenhanced{} played card',
            'gives {X:mult,C:white}X#1#{} Mult if a sip is taken.',
            'Refill the mug with {C:tarot}Temperance',
            'when it\'s {C:red}less{} than {C:attention}half-full{}.',
            'Gain {X:mult,C:white}X#2#{} mult for each refill.'
        }
        ,boxes={4,3}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1.6, Xmult_mod = 0.2,
        fill = 21, sipped = false,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Refill!',
            --sound = 'hololive_sound_Aki_PouringBeer'
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_temperance
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.fill,
            }
        }
    end,
    upgrade_func = function(card)
        card.ability.extra.fill = 21
    end,

    atlas = 'Relic_First',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if cae.fill <= 10 then holo_card_upgrade_by_consumeable(card, context, 'c_temperance') end
        if (context.before or context.pre_discard)and(cae.fill>=1) then
            cae.fill = cae.fill - 1
            if context.before then
                cae.sipped = true
            end
            return {
                message='Gulp!',
                colour=Holo.C.Aki,
                --sound='hololive_sound_Aki_Gulp',
            }
        elseif context.individual and context.cardarea==G.play and cae.sipped then
            if SMODS.has_enhancement(context.other_card, 'c_base') then
                return {
                    Xmult=cae.Xmult,
                    colour=Holo.C.Aki,
                    --sound='hololive_sound_Aki_MugClinking'
                }
            end
        elseif context.after and cae.sipped then
            cae.sipped = false
        end
    end
}

Holo.Relic_Joker{ -- Akai Haato / Haachama
    member = "Haato",
    key = "Relic_Haato",
    loc_txt = {
        name = "incREDible Heart of the Strongest Idol",
        text = {
            'Each played card with {C:hearts}Heart{} suit receives',
            'a {C:attention}random enhancement{} before scoring.',
            'Each card with {C:hearts}Heart{} suit held in hand',
            'gives {X:mult,C:white}X#1#{} Mult when scored.',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The Sun{} used.'
        }
        ,boxes={2,2,1}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.2,
        upgrade_args = {
            scale_var = 'Xmult',
            message = 'Haa-Chama-Chama!',
        },
        enhance_table = {
            m_bonus = 4,
            m_mult  = 4,
            m_wild  = 1,
            m_glass = 3,
            m_steel = 2,
            m_stone = 1,
            m_gold  = 2,
            m_lucky = 3,
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
            }
        }
    end,

    atlas = 'Relic_First',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_sun')
        if context.before and not context.blueprint then
            for _,v in ipairs(context.scoring_hand)do
                if v:is_suit('Hearts') and SMODS.has_enhancement(v, 'c_base') then
                    local enh = Holo.pseudorandom_weighted_element(cae.enhance_table,'Haachama')
                    v:set_ability(G.P_CENTERS[enh], nil, true)
                    G.E_MANAGER:add_event(Event({
                        trigger='after',
                        delay=0.2,
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
        elseif context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:is_suit('Hearts') and cae.Xmult>1 then
                return {
                    Xmult = cae.Xmult,
                    message = 'Heart!',
                    colour = Holo.C.Haato,
                }
            end
        end
    end
}

----