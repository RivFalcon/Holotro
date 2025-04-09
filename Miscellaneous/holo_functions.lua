
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

function Holo.nil_check(var, fields)
    local ret = {var,}
    for _,field in ipairs(fields)do
        ret[#ret+1] = ret[#ret][field] or {}
    end
    return ret[#ret]
end

function Holo.mod_check(card)
    return Holo.nil_check(card,{'config','center','mod','id'})=='Holotro'
end

function Holo.cae(card)
    return Holo.nil_check(card,{'ability','extra'})
end

function holo_card_upgrade(card)
    local cae = Holo.cae(card)
    local args = cae.upgrade_args or {}
    local scale_var = args.scale_var or ''
    if type(cae[scale_var]) ~= 'number' then return end

    -- The core of this entire function
    cae[scale_var] = cae[scale_var] + (args.incr or cae[args.incr_var or scale_var..'_mod'] or 1)

    if type(card.config.center.upgrade_func) == 'function'then
        card.config.center.upgrade_func(card)
    end
    SMODS.calculate_effect(
        {
            message = args.message or localize(args.message_loc or 'k_upgrade_ex'),
            colour = args.colour or Holo.C[card.config.center.member or 'Hololive'],
            sound = args.sound or 'generic1',
        },
        card
    )
end

function holo_card_upgrade_by_consumeable(card, context, consumeable_key)
    if context.blueprint then return end
    if context.using_consumeable ~= true then return end
    if Holo.nil_check(context.consumeable,{'config','center','key'}) ~= consumeable_key then return end
    holo_card_upgrade(card)
end

function holo_card_counting(card, context, decr)
    local cae = Holo.cae(card)
    local args = cae.count_args or {}
    if cae.count_init == nil then return end
    if cae.count_down == nil then return end

    decr = decr or args.decr or 1
    local func = card.config.center.count_func or (function(_card,_ctx)end)
    local elsefunc = card.config.center.count_elsefunc or (function(_card,_ctx)end)

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

function holo_card_expired(card)
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()
                    card = nil
                    return true
                end
            }))
            return true
        end
    }))
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
