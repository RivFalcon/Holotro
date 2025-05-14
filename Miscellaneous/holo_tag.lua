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
                HEX('04e3cb'),
                function()
                    play_sound('timpani')
                    return true
                end
            )
            tag.triggered = true
        end
    end
}

SMODS.Atlas{
    key = "tags_sparedtags",
    path = "Tags/Spared Tags.png",
    px = 32,
    py = 32
}
SMODS.Tag{
    key = "spared_discard",
    loc_txt = {
        name = 'Spared Discard Tag',
        text = {
            '{C:red}+1{} Discard',
            'when {C:red}0{} discard remains.'
        }
    },
    atlas = 'tags_sparedtags', pos = { x = 0, y = 0 },
    min_ante = 3,
    apply = function (self, tag, context)
        if (G.GAME.current_round.discards_left==0)and not G.GAME.hololive_discard_spared then
            G.GAME.hololive_discard_spared = true
            ease_discard(1)
            tag:yep(
                '+1',
                G.C.RED,
                function()
                    play_sound('timpani')
                    G.GAME.hololive_discard_spared = nil
                    return true
                end
            )
            tag.triggered = true
        end
    end
}
SMODS.Tag{
    key = "spared_hand",
    loc_txt = {
        name = 'Spared Hand Tag',
        text = {
            '{C:blue}+1{} Hand',
            'when {C:blue}1{} hand remains.'
        }
    },
    atlas = 'tags_sparedtags', pos = { x = 1, y = 0 },
    min_ante = 3,
    apply = function (self, tag, context)
        if (G.GAME.current_round.hands_left==1)and not G.GAME.hololive_hand_spared then
            G.GAME.hololive_hand_spared = true
            ease_hands_played(1)
            tag:yep(
                '+1',
                G.C.BLUE,
                function()
                    play_sound('timpani')
                    G.GAME.hololive_hand_spared = nil
                    return true
                end
            )
            tag.triggered = true
        end
    end
}

----