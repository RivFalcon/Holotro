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

----
