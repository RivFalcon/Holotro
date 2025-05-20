----

SMODS.Booster:take_ownership_by_kind(
    'Arcana',
    {
        create_card = function(self, card, i)
            local _card
            if G.GAME.used_vouchers.v_hololive_suit_flower and (i == 1) then
                local _tarot = Holo.roll_for_suit_tarot()
                _card = {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key = _tarot, key_append = "ar_flower"}
            elseif G.GAME.used_vouchers.v_hololive_mod_book and (i == 1) then
                local _tarot = Holo.roll_for_enhance_tarot()
                _card = {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key = _tarot, key_append = "ar_book"}
            elseif G.GAME.used_vouchers.v_hololive_suit_flower and G.GAME.used_vouchers.v_hololive_mod_book and (i == 2) then
                local _tarot = Holo.roll_for_enhance_tarot()
                _card = {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key = _tarot, key_append = "ar_book"}
            elseif G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
                _card = {set = "Spectral", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar2"}
            else
                _card = {set = "Tarot", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "ar1"}
            end
            return _card
        end,
    }
    ,true
)

SMODS.Enhancement:take_ownership(
    'm_lucky',
    {
        loc_vars = function(self, info_queue, card)
            local is_ace = (card and card.base and card.base.id or 0)==14 or false
            local is_eyed = next(find_joker('j_hololive_Relic_Shion')) and is_ace
            return { vars = {
                Holo.prob_norm(),
                card.ability.mult, is_eyed and 1 or 5,
                card.ability.p_dollars, is_eyed and 3 or 15,
            } }
        end,
    }
    ,true
)

SMODS.Enhancement:take_ownership(
    'm_glass',
    {
        calculate = function(self, card, context)
            if context.destroy_card == card and context.cardarea == G.play then
                if Holo.chance('glass',card.ability.extra) then
                    if Holo.is_durable(card) then
                        SMODS.calculate_effect({
                            message='Durable!',
                            colour=Holo.C.Ceci,
                            sound='hololive_sound_Ceci_Durable'
                        },card)
                        SMODS.calculate_context({hololive_shatter_card=card})
                    else
                        return { remove = true }
                    end
                end
            end
        end,
    }
    ,true
)

--[[
SMODS.Enhancement:take_ownership(
    'm_stone',
    {
        atlas = "enhance_Pebble",
        pos = {x=0,y=0}
    }
    ,true
)
]]

----
