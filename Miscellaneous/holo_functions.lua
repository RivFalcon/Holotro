
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

function Card:upgrade(scale_var, incr, arg)
    local cae = self.ability.extra
    if type(cae)~='table' then return end
    if type(scale_var)~='string'then return end
    if cae[scale_var]==nil then return end

    cae[scale_var] = cae[scale_var] + (incr or cae[scale_var..'_mod'] or 1)
    arg = arg or {}
    SMODS.calculate_effect(
        {
            message = arg.message or cae.upgrade_message or localize('k_upgrade_ex'),
            colour = arg.colour,
            sound = arg.sound
        },
        self
    )
end

function holo_card_upgrade(card, scale_var, incr, arg)
    if ((card or {})['ability'] or {})['extra'] == nil then return end
    local cae = card.ability.extra
    if #cae==0 then return end
    if scale_var then
        if type(scale_var)~='string'then return end
        if cae[scale_var]==nil then return end
    elseif cae.scale_var then
        scale_var = cae.scale_var
    else
        for var,val in pairs(cae) do
            if cae[var..'_mod'] then
                scale_var = var
                break
            end
        end
    end

    -- The core of this entire function
    cae[scale_var] = cae[scale_var] + (incr or cae[scale_var..'_mod'] or 1)

    arg = arg or {}
    if type(arg.func) == 'function'then
        arg.func(card, arg)
    end
    card:juice_up()
    local _message = localize('k_upgrade_ex')
    if cae.upgrade_message then _message = cae.upgrade_message end
    if cae.upgrade_message_loc then _message = localize(cae.upgrade_message_loc) end
    if arg.message then _message = arg.message end
    SMODS.calculate_effect(
        {
            message = _message,
            colour = arg.colour or Holo.C[card.center.config.member or 'Hololive'],
            sound = arg.sound or cae.upgrade_sound or 'generic1',
        },
        card
    )
end

function holo_card_counting(card, context, decr, func, elsefunc)
    if ((card or {})['ability'] or {})['extra'] == nil then return end
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

function Holo.prob_norm()
    local _prob = {norm = G.GAME.probabilities.normal}
    if G.jokers and G.jokers.cards then
        for _,J in ipairs(G.jokers.cards) do
            J:calculate_joker({calc_prob = true, prob = _prob})
        end
    end
    return _prob.norm
end

function Holo.chance(seed, odds)
    local _pseurand = pseudorandom(seed)
    local _result = _pseurand < Holo.prob_norm() / (odds or 1)

    if _result and seed == 'glass' and next(find_joker('j_hololive_Relic_Ceci')) then
        for _,J in ipairs(SMODS.find_card('j_hololive_Relic_Ceci')) do
            J:calculate_joker({shatter_check = true})
        end
        --return false
    end
    return _result
end

local holo_always_scores = SMODS.always_scores
function SMODS.always_scores(card)
    if holo_always_scores(card)then return true end
    if next(find_joker('j_hololive_Relic_Biboo')) and not card:is_face() then return true end
    return false
end

function holo_card_disaccumulate(_cae, _key)
    if _cae.accumulate>=1 then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            _cae.accumulate = _cae.accumulate - 1
            G.E_MANAGER:add_event(Event({
                func = function ()
                    SMODS.add_card({ key = _key, area = G.consumeables})
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    return true
                end
            }))
        end
    end
end
