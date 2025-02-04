----

if false then
SMODS.Tag{
    key = "Butterfly",
    loc_txt = {
        name = 'Butterfly Tag',
        text = {
            'Disables effect of',
            'one {C:attention}Boss Blind{}',
            'when entering it.'
        }
    },
    
    apply = function (self, tag, context)
        print(context.setting_blind , G.GAME.blind.boss)
        if context.setting_blind and G.GAME.blind.boss then
            print(context.blind.disabled)
            if context.blind.disabled == false then
                tag:yep(
                    localize('ph_boss_disabled'),
                    G.C.GREEN,
                    function()
                        G.GAME.blind:disable()
                        play_sound('timpani')
                        return true
                    end
                )
                tag.triggered = true
            end
        end
    end
}
end

----