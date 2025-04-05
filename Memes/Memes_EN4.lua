----

SMODS.Joker{
    member = "Elizabeth",
    key = "Meme_Elizabeth_VM",
    loc_txt = {
        name = "Voice Mimicry",
        text = {
            'Copies abilities of all {C:attention}jokers',
            'that associate with',
            '{C:attention}english{}-speaking {V:1}hololive{} members',
            'except {V:2}Elizabeth{} herself.'
        }
    },
    config = { extra = {} },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {set='Other',key='holo_info_english_speaking_members'}
        return {
            vars = {
                colours = {
                    Holo.C.Hololive,
                    Holo.C.Elizabeth
                }
            }
        }
    end,
    rarity = 3,
    cost = 8,

    calculate = function(self, card, context)
        for _,J in ipair(G.jokers.cards)do
            local _tick = false
            local _members = J.config.center.members or (J.config.center.member and {J.config.center.member,}) or {}
            for _,_member in ipairs(_members) do
                if Holo.get_branch(_member)=='EN' and _member~='Elizabeth'then
                    _tick = true
                elseif Holo.get_branch(_member)=='ID'then
                    _tick = true
                elseif _member=='Haato' or _member=='Coco' or _member=='Ririka' then
                    _tick = true
                end
            end
            if _tick then
                SMODS.calculate_effect(SMODS.blueprint_effect(card, J, context), card)
            end
        end
    end
}

----