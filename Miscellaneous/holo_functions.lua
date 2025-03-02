
function holo_ctx(context)
    -- Main Scoring Loop
    if context.before then return 'before scoring' end
    if context.main_scoring and context.cardarea == G.play then return 'card modifier scoring effect' end
    if context.individual and context.cardarea == G.play then return 'when scored' end
    if context.repetition and context.cardarea == G.play then return 'retrigger scoring' end
    if context.individual and context.cardarea == G.hand and not context.end_of_round then return 'held in hand for scoring' end
    if context.repetition and context.cardarea == G.hand and not context.end_of_round then return 'retrigger in hand for scoring' end
    if context.joker_main then return 'joker_main' end
    if context.other_joker then return 'other_joker' end
    if context.post_joker then return 'post_joker' end
    if context.final_scoring_step then return 'before the score is totalled' end
    if context.destroy_card and context.cardarea == G.play then return 'destroy scored card' end
    if context.remove_playing_cards then return 'when playing cards are removed' end
    if context.after then return 'after scoring' end
    -- Discard
    if context.pre_discard and context.cardarea == G.play then return 'before discard' end
    if context.discard then return 'when discard' end
    -- End Of Round
    if context.end_of_round and context.cardarea == G.jokers then return 'joker at end of round' end
    if context.end_of_round and context.individual then return 'held in hand at end of round' end
    if context.end_of_round and context.repetition then return 'retrigger in hand at end of round' end
    -- Blind
    if context.debuffed_hand then return 'hand debuffed by the blind' end
    if context.setting_blind then return 'select a blind' end
    if context.skip_blind then return 'skip a blind' end
    -- Shop
    if context.reroll_shop then return 'shop reroll' end
    if context.buying_card then return 'buy a card' end
    if context.buying_voucher then return 'buy a voucher' end
    if context.buying_booster_pack then return 'buy a booster pack' end
    if context.open_booster then return 'open a booster pack' end
    if context.skipping_booster then return 'skip a booster pack' end
    if context.selling_card then return 'sell a card' end
    if context.ending_shop then return 'leave the shop' end
    -- Draw A Hand
    if context.first_hand_drawn then return 'drawing the first hand' end
    if context.hand_drawn then return 'drawing a hand' end
    -- Others
    if context.using_consumeable then return 'use a consumeable' end
    if context.playing_card_added then return 'add a playing card' end
    if context.post_trigger then return 'post_trigger' end
end

function holo_card_upgrade(card, scale_var, incr, arg)
    if card == nil then return end
    if card.ability == nil then return end
    if card.ability.extra == nil then return end
    local cae = card.ability.extra
    if #cae==0 then return end
    if type(scale_var)~='string'then return end
    if cae[scale_var]==nil then return end
    incr = incr or cae[scale_var..'_mod'] or 1
    arg = arg or {}

    cae[scale_var] = cae[scale_var] + incr
    
    if type(arg.func) == 'function'then
        arg.func(card, arg)
    end
    card:juice_up()
    local _message = localize('k_upgrade_ex')
    if cae.upgrade_message then _message = cae.upgrade_message end
    if cae.upgrade_message_loc then _message = localize(cae.upgrade_message_loc) end
    if arg.message then _message = arg.message end
    local _colour = Holo.C.hololive
    if card.center.config.member then _colour = Holo.C[card.center.config.member] end
    if arg.colour then _colour = arg.colour end
    return {
        message = _message,
        colour = _colour,
        sound = arg.sound or 'generic1',
        card = card
    }
end

function holo_card_counting(card, context, decr, func, elsefunc)
    if card == nil then return end
    if card.ability == nil then return end
    if card.ability.extra == nil then return end
    local cae = card.ability.extra
    if cae.count_init == nil then return end
    if cae.count_down == nil then return end

    decr = decr or 1
    func = func or (function(_card,_ctx)end)
    elsefunc = elsefunc or (function(_card,_ctx)end)

    cae.count_down = cae.count_down - decr
    local _effect = nil
    if cae.count_down <= 0 then
        cae.count_down = cae.count_down + cae.count_init
        _effect = func(card, context)
    else
        _effect = elsefunc(card, context)
    end
    return _effect
end

function ggpn()
    return G.GAME.probabilities.normal
end

function holo_chance(seed, odds)
    return (pseudorandom(seed) < ggpn() / odds)
end
