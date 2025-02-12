----
if false then
SMODS.Joker{
    key = "Kiara_TUR",
    member = "Kiara",
    loc_txt = {
        name = "The Usual Room",
        text = {
            'If first discard of',
            'round has only {C:attention}1{} card,',
            'send it to {C:attention}The Usual Room{}',
            'and create a {C:holofan}KFP{}.'
        }
    },
    config = { extra = {} },
    rarity = 2,
    cost = 6,
    --atlas = 'Kiara_TUR',
    --pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
    end
}
end

----