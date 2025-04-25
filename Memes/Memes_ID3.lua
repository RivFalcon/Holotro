----

SMODS.Atlas{
    key = "Kaela_Doot",
    path = "Memes/Meme_Kaela_Doot.png",
    px = 71,
    py = 95
}
SMODS.Sound{
    key = 'sound_Kaela_Doot',
    path = 'Kaela_Doot.ogg'
    -- source: https://pixabay.com/sound-effects/079580-tenor-trombone-80873/
}
local Doot_pitch_shift = {
    -- Balatro theme is in E minor
    329.63 / 349.23, -- E4
    369.99 / 349.23, -- F#4
    392.00 / 349.23, -- G4
    440.00 / 349.23, -- A4
    493.88 / 349.23, -- B4
    523.25 / 349.23, -- C5
    587.33 / 349.23, -- D5
    659.26 / 349.23  -- E5
    -- Data source: https://en.wikipedia.org/wiki/Pitch_(music)
}
Holo.Meme_Joker{
    key = "Meme_Kaela_DOOT",
    member = "Kaela",
    loc_txt = {
        name = "Trumpet",
        text = {
            "Make a {C:attention}trumpet noise{} every",
            "time a played card {C:blue}scores{}.",
            "{C:red}There is no other effect."
        }
    },
    config = { extra = { vol = 1, vol_mod = 0.01 } },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    set_badges = function(self, card, badges)
        Holo.set_type_badge(card, badges, 'Meme')
        Holo.set_member_badges(card, badges)
    end,

    rarity = 1,
    cost = 0,
    blueprint_compat = true,

    atlas = 'Kaela_Doot',
    pos = { x = 0, y = 0 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.blueprint then
                card.ability.extra.vol = card.ability.extra.vol + card.ability.extra.vol_mod
            end
            return {
                message='Doot!',
                colour=HEX('ec9948'),
                card=card,
                sound='hololive_sound_Kaela_Doot',
                pitch=pseudorandom_element(Doot_pitch_shift, pseudoseed('Doot')),
                volume=card.ability.extra.vol
            }
        elseif context.setting_blind and not context.blueprint then
            card.ability.extra.vol = 1
        end
    end
}

local card_hover = Card.hover
function Card:hover()
    if self.ability.name == 'j_hololive_Meme_Kaela_DOOT' then
        play_sound('hololive_sound_Kaela_Doot')
    end
    card_hover(self)
end

----