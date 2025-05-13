----

Holo.Atlas_7195{
    key='holo_vouchers',
    path = "textures/holo_vouchers.png",
}

SMODS.Voucher{ -- Stage Call
    key = 'stage_call',
    loc_txt = {
        name = 'Stage Call',
        text = {
            '{V:1}Fan{} cards appear',
            '{C:attention}2X{} more frequently',
            'in the shop.',
            '{C:inactive}(Placehold object,',
            '{C:inactive}currently does nothing.)'
        }
        ,boxes={3,2}
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            colours = {Holo.C.Hololive}
        }}
    end,
    atlas = 'holo_vouchers',
    pos = {x=0,y=0},
    in_pool = function (self, args)
        return false
    end,

}
SMODS.Voucher{ -- Stage Response
    key = 'stage_response',
    loc_txt = {
        name = 'Stage Response',
        text = {
            '{V:1}Fan{} cards in your',
            'consumeable area',
            'will {C:attention}retrigger{} the effect',
            'of their oshi\'s {V:2}Relic{}.',
            '{C:inactive}(Placehold object,',
            '{C:inactive}currently does nothing.)'
        }
        ,boxes={4,2}
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            colours = {
                Holo.C.Hololive,
                Holo.C.Hololive_dark,
            }
        }}
    end,
    unlocked = false,
    requires = {'v_hololive_stage_call'},
    unlock_condition = {type = 'v_hololive_stage_response'},
    atlas = 'holo_vouchers',
    pos = {x=0,y=1},
    in_pool = function (self, args)
        return false
    end,

}

SMODS.Voucher{ -- Flower
    key = 'suit_flower',
    loc_txt = {
        name = "Flower",
        text = {
            '{C:attention}Arcana Packs{} always contain',
            'the Suit-converting {C:tarot}Tarot card',
            'for the {C:attention}most common{} suit',
            'in your {C:blue}full deck{}. Flower.'
        }
    },
    atlas = 'holo_vouchers',
    pos = {x=1,y=0},
    redeem = function (self, card, from_debuff)
        G.GAME.suit_tarots = {}
        for _,tarot in ipairs(G.P_CENTER_POOLS.Tarot)do
            if tarot.config.suit_conv then
                G.GAME.suit_tarots[#G.GAME.suit_tarots+1] = tarot.key
            end
        end
    end,
    roll_for_tarot = function()
        local _counter = {}
        for _,v in ipairs(G.playing_cards) do
            for _,suit_tarot in ipairs(G.GAME.suit_tarots)do
                _counter[suit_tarot] = _counter[suit_tarot] or 0
                if v:is_suit(G.P_CENTERS[suit_tarot].config.suit_conv)then
                    _counter[suit_tarot] = _counter[suit_tarot] + 1
                end
            end
        end
        local _tally = 0
        for _, _count in pairs(_counter)do
            _tally = math.max(_count,_tally)
        end
        local most_common_suits_tarots = {}
        for _suit_tarot, _count in pairs(_counter)do
            if _count == _tally then
                most_common_suits_tarots[#most_common_suits_tarots+1] = _suit_tarot
            end
        end
        if #most_common_suits_tarots==1 then return most_common_suits_tarots[1] end
        return pseudorandom_element(most_common_suits_tarots, pseudoseed('hololive_flower'))
    end
}
SMODS.Voucher{ -- Bouquet
    key = 'suit_bouquet',
    loc_txt = {
        name = "Bouquet",
        text = {
            'Suit-converting {C:tarot}Tarot cards',
            'in your {C:blue}consumeable area',
            'give {X:mult,C:white}X#1#{} Mult when cards with',
            'their {C:attention}specified suit{} scored.'
        }
    },
    config = {extra = 1.1},
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra }}
    end,
    unlocked = false,
    requires = {'v_hololive_suit_flower'},
    unlock_condition = {type = 'v_hololive_suit_bouquet'},
    atlas = 'holo_vouchers',
    pos = {x=1,y=1},
} -- Portulaca, Dicentra, Ipomoea alba, and Asters.


SMODS.Voucher{ -- Book
    key = 'mod_book',
    loc_txt = {
        name = "Enhanced Book",
        text = {
            '{C:attention}Arcana Packs{} always contain',
            'the Enhancing {C:tarot}Tarot card',
            'for the {C:attention}most common{} enhancement',
            'in your {C:blue}full deck{}. Dahlah.'
        }
    },
    atlas = 'holo_vouchers',
    pos = {x=2,y=0},
    redeem = function (self, card)
        G.GAME.mod_tarots = {}
        for _,tarot in ipairs(G.P_CENTER_POOLS.Tarot)do
            if tarot.config.mod_conv and tarot.config.mod_conv:find('m_') then
                G.GAME.mod_tarots[#G.GAME.mod_tarots+1] = tarot.key
            end
        end
    end,
    roll_for_tarot = function()
        local _counter = {}
        for _,v in ipairs(G.playing_cards) do
            for _,mod_tarot in ipairs(G.GAME.mod_tarots)do
                _counter[mod_tarot] = _counter[mod_tarot] or 0
                if SMODS.has_enhancement(v, G.P_CENTERS[mod_tarot].config.mod_conv) then
                    _counter[mod_tarot] = _counter[mod_tarot] + 1
                end
            end
        end
        local _tally = 0
        for _, _count in pairs(_counter)do
            _tally = math.max(_count,_tally)
        end
        local most_common_mods_tarots = {}
        for _mod_tarot, _count in pairs(_counter)do
            if _count == _tally then
                most_common_mods_tarots[#most_common_mods_tarots+1] = _mod_tarot
            end
        end
        if #most_common_mods_tarots==1 then return most_common_mods_tarots[1] end
        return pseudorandom_element(most_common_mods_tarots, pseudoseed('hololive_dish'))
    end
}
SMODS.Sound{
    key = 'sound_Kaela_Anvil',
    path = 'Kaela_Anvil.ogg'
    -- source: https://minecraft.wiki/w/File:Anvil_land.ogg
}
SMODS.Voucher{ -- Anvil
    key = 'mod_anvil',
    loc_txt = {
        name = "Anvil",
        text = {
            'Enhancing {C:tarot}Tarot cards',
            'in your {C:blue}consumeable area',
            'retrigger playing cards {C:red}once',
            'for their specific {C:attention}enhancements{}.'
        }
    },
    unlocked = false,
    requires = {'v_hololive_mod_book'},
    unlock_condition = {type = 'v_hololive_mod_anvil'},
    atlas = 'holo_vouchers',
    pos = {x=2,y=1},
}

----