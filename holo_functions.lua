---- holo global functions ----

function holo_ctx(context)
    -- Main Scoring Loop
    if context.before then return 'before scoring' end
    if context.repetition and context.cardarea == G.play then return 'retrigger scoring' end
    if context.main_scoring and context.cardarea == G.play then return 'card modifier scoring effect' end
    if context.individual and context.cardarea == G.play then return 'when scored' end
    if context.repetition and context.cardarea == G.hand and not context.end_of_round then return 'retrigger in hand for scoring' end
    if context.individual and context.cardarea == G.hand and not context.end_of_round then return 'held in hand for scoring' end
    if context.pre_joker then return 'pre_joker' end
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
    if context.end_of_round and context.repetition then return 'retrigger in hand at end of round' end
    if context.end_of_round and context.individual then return 'held in hand at end of round' end
    -- Blind
    if context.setting_blind then return 'select a blind' end
    if context.skip_blind then return 'skip a blind' end
    if context.debuffed_hand then return 'hand debuffed by the blind' end
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
    if context.card_added then return 'add a non-playing card' end
    if context.check_enhancement then return 'quantum enhancements' end
    if context.post_trigger then return 'post_trigger' end
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

function holo_card_counting(card, decr)
    local cae = Holo.cae(card)
    if cae.count_args == nil then return false end
    local args = cae.count_args
    if args.init == nil then return false end
    if args.down == nil then return false end

    args.down = args.down - (decr or args.decr or 1)
    local _effect = nil
    if args.down <= 0 then
        args.down = args.down + args.init
        return true
    else
        return false
    end
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

---- Holo utility functions ----

function Holo.series_and(list, criteria_func)
    criteria_func = (type(criteria_func)=='function') and criteria_func or function(v)return v end
    for _,item in ipairs(list)do
        if not criteria_func(item)then return false end
    end
    return true
end
function Holo.series_or(list, criteria_func)
    criteria_func = (type(criteria_func)=='function') and criteria_func or function(v)return v end
    for _,item in ipairs(list)do
        if criteria_func(item)then return true end
    end
    return false
end
function Holo.series_count(list, criteria_func)
    local sum = 0
    for _,item in ipairs(list)do
        if criteria_func(item)then sum=sum+1 end
    end
    return sum
end

function Holo.nil_check(var, fields)
    local ret = {var or {},}
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
    -- Modify _result here:

    -- End of modification.
    return _result
end
function Holo.pseudorandom_weighted_element(weight_table, seed)
    local pool = {}
    local sum = 0
    for element, weight in pairs(weight_table)do
        sum = sum + weight
        pool[#pool+1] = { e = element, acc_w = sum }
    end
    local index = sum*pseudorandom(seed)
    for i,v in ipairs(pool) do
        if index<v.acc_w then return v.e end
    end
    return pool[#pool].e
end

function Holo.hand_contained_usage()
    local ret={}
    for hand,data in pairs(Holo.nil_check(G,{'GAME','hand_usage'}))do
        ret[hand]=true
    end
    if ret['Flush Five'] then
        ret['Five of a Kind']=true
        ret['Flush']=true
    end
    if ret['Flush House'] then
        ret['Full House']=true
        ret['Flush']=true
    end
    if ret['Five of a Kind'] then
        ret['Four of a Kind']=true
    end
    if ret['Straight Flush'] then
        ret['Flush']=true
        ret['Straight']=true
    end
    if ret['Four of a Kind'] then
        ret['Three of a Kind']=true
    end
    if ret['Full House'] then
        ret['Three of a Kind']=true
        ret['Two Pair']=true
    end
    if ret['Three of a Kind'] or ret['Two Pair'] then
        ret['Pair']=true
    end
    return ret
end

function Holo.blueprint_node(card)
    card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''
    card.ability.blueprint_compat_check = nil
    return card.ability.blueprint_compat and {
        {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'blueprint_compat'}, nodes={
                {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'blueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
            }}
        }}
    } or nil
end
function Holo.blueprint_update(card, joker_to_copy, extra_criteria)
    if joker_to_copy==nil then
        card.ability.blueprint_compat = false
    elseif Holo.nil_check(joker_to_copy,{'config','center'}).blueprint_compat and extra_criteria then
        card.ability.blueprint_compat = 'compatible'
    else
        card.ability.blueprint_compat = 'incompatible'
    end
end

function Holo.call_and_response(card, context, _member)
    if Holo.nil_check(card,{'config','center'}).member == nil then return end
    local is_Relic = (card.config.center.rarity=='hololive_Relic')
    local oshi_senpai = Holo.call_and_response_chart[card.config.center.member]
    _member = _member or(is_Relic and oshi_senpai)or card.config.center.member
    for _,J in ipairs(find_joker('j_hololive_Relic_'.._member))do
        SMODS.calculate_effect(SMODS.blueprint_effect(card, J, context)or{}, card)
    end
end

function Holo.add_consumeable(_key, _neg)
    if (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or _neg then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + (_neg and 0 or 1)
        G.E_MANAGER:add_event(Event({
            func = function ()
                SMODS.add_card({
                    key = _key,
                    area = G.consumeables,
                    edition = _neg and 'e_negative' or nil,
                })
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - (_neg and 0 or 1)
                return true
            end
        }))
        return true
    end
end

---- Hooks ----

Holo.hooks = {}

Holo.hooks.always_scores = SMODS.always_scores
function SMODS.always_scores(card)
    if Holo.hooks.always_scores(card)then return true end
    if next(find_joker('j_hololive_Relic_Biboo')) and not card:is_face() then return true end
    return false
end

Holo.hooks.level_up_hand = level_up_hand
function level_up_hand(card, hand, instant, amount)
    Holo.hooks.level_up_hand(card, hand, instant, amount)
    local _context = {level_up_hand = hand, level_up_amount = amount or 1}
    for _,J in ipairs(G.jokers.cards) do
        J:calculate_joker(_context)
    end
end

Holo.hooks.shatters = SMODS.shatters
function SMODS.shatters(card)
    if Holo.hooks.shatters(card) then
        local flag = SMODS.calculate_context({shatter_check=true, shatter_card=card})
        if not flag.durable then
            return true
        else
            card:juice_up()
            --play_sound('hololive_Ceci_Durable')
        end
    end
end
