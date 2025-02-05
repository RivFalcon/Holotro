----

SMODS.Tag{
    key = "butterfly",
    loc_txt = {
        name = 'Butterfly Tag',
        text = {
            'Disables effect of',
            'one {C:attention}Boss Blind{}',
            'when entering it.'
        }
    },
    apply = function (self, tag, context)
        if (not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss') then
            -- card_eval_status_text(tag, 'extra', nil, nil, nil, {message = localize('ph_boss_disabled')})
            G.GAME.blind:disable()
            tag:yep(
                localize('ph_boss_disabled'),
                G.C.GREEN, -- borrowed colour code
                function()
                    play_sound('timpani')
                    return true
                end
            )
            tag.triggered = true
        end
    end
}

----