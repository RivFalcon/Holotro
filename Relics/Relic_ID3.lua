----
SMODS.Atlas{
    key = "Relic_HoloH3ro",
    path = "Relics/Relic_HoloH3ro.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- Vestia Zeta
    member = "Zeta",
    key = "Relic_Zeta",
    loc_txt = {
        name = "Pistol of the Secret Agent",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_HoloH3ro',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

Holo.Relic_Joker{ -- Kaela Kovalskia
    member = "Kaela",
    key = "Relic_Kaela",
    loc_txt = {
        name = "Hammer of the Blacksmith",
        text = {
            'Played {C:attention}enhanced{} cards have their',
            'effect {V:1}upgraded{} before scoring.',
            '{C:inactive}(Only works with vanilla enhancements)',
            'Gain {X:mult,C:white}X#2#{} mult per upgrading.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult){}'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.25,
        upgrade_args = {
            scale_var = 'Xmult',
            --sound = 'hololive_sound_Kaela_Anvil',
        },
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                colours = {
                    Holo.badge_colours.Kaela.text
                }
            }
        }
    end,
    chart = {
        m_bonus = {bonus = 6},
        m_mult  = {mult = 1},
        m_glass = {x_mult = 0.2},
        m_steel = {h_x_mult = 0.1},
        m_stone = {bonus = 10},
        m_gold  = {h_dollars = 1},
        m_lucky = {mult = 4, p_dollars = 4},
    },

    no_collection = true,
    atlas = 'Relic_HoloH3ro',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.before then
            local _tick = 0
            local not_blueprint = not context.blueprint
            for _,v in ipairs(context.scoring_hand)do
                for enh,data in pairs(self.chart)do
                    if SMODS.has_enhancement(v, enh) then
                        for scale_var,incr in pairs(data)do
                            v.ability[scale_var] = v.ability[scale_var] + incr
                        end
                        if enh == 'm_glass' then
                            v.ability.Xmult = v.ability.x_mult
                        end
                        if not_blueprint then
                            _tick = _tick + 1
                        end
                    end
                end
            end
            if _tick > 0 then
                holo_card_upgrade(card, _tick)
            end
        elseif context.joker_main then
            return {
                Xmult = cae.Xmult,
                colour = Holo.C.Kaela,
            }
        end
    end
}

Holo.Relic_Joker{ -- Kobo Kanaeru
    member = "Kobo",
    key = "Relic_Kobo",
    loc_txt = {
        name = "Umbrella of the Rain Shaman",
        text = Holo.Relic_dummytext or {
            ''
        }
        --,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
            }
        }
    end,

    no_collection = true,
    atlas = 'Relic_HoloH3ro',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
    end
}

----