----
SMODS.Atlas{
    key = "tags_butterfly",
    path = "Tags/Butterfly.png",
    px = 32,
    py = 32
}

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
    atlas = 'tags_butterfly', pos = { x = 0, y = 0 },
    min_ante = 9,
    apply = function (self, tag, context)
        if (not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss') then
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