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
        if (G.GAME.current_round.hands_left==1)and not G.GAME.hololive_hand_spared and G.STATE ~= G.STATES.ROUND_EVAL then
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

SMODS.Atlas{
    key = "tags_fancheer",
    path = "Tags/FanCheer.png",
    px = 32,
    py = 32
}
SMODS.Tag{
    key = "fancheer",
    loc_txt = {
        name = "Fan Cheer Tag",
        text = {
            "Gives a free",
            "{C:Hololive}Mega HoloPack",
        }
    },
    atlas = 'tags_fancheer', pos = {x=0,y=0},
    loc_vars = function (self, info_queue, tag)
        info_queue[#info_queue+1] = G.P_CENTERS.p_hololive_fandom_mega_1
    end,
    apply = function (self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local booster = SMODS.create_card { key = 'p_hololive_fandom_mega_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

----