----
SMODS.Atlas{
    key = "Relic_HoloX",
    path = "Relics/Relic_HoloX.png",
    px = 71,
    py = 95
}

Holo.Relic_Joker{ -- La+ Darknesss
    member = "Laplus",
    key = "Relic_Laplus",
    loc_txt = {
        name = "X of the Commander Chief",
        text = {
            'Played cards with rank of {C:attention}10',
            'are retriggered {C:attention}#1#{} times.',
            '{C:attention}+1{} retrigger per {V:1}#2#{} used.'
        }
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        retriggers = 2,
        upgrade_args = {
            scale_var = 'retriggers',
        }
    }},
    loc_vars = function(self, info_queue, card)
        local x_unlock = G.P_CENTERS.c_planet_x.unlocked
        if x_unlock then
            info_queue[#info_queue+1] = G.P_CENTERS.c_planet_x
        end
        local local_x = localize({key='c_planet_x', set='Planet', type='name_text'})
        return {
            vars = {
                card.ability.extra.retriggers,
                x_unlock and local_x or '?????',
                colours= {x_unlock and G.C.SECONDARY_SET.Planet or G.C.UI.TEXT_DARK}
            }
        }
    end,

    atlas = 'Relic_HoloX',
    pos      = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        holo_card_upgrade_by_consumeable(card, context, 'c_planet_x')
        if context.repetition and context.cardarea==G.play then
            if context.other_card:get_id()==10 then
                return{
                    repetitions = card.ability.extra.retriggers,
                    colour=Holo.C.Laplus,
                    card = card,
                }
            end
        end
    end
}

Holo.Relic_Joker{ -- Takane Lui
    member = "Lui",
    key = "Relic_Lui",
    loc_txt = {
        name = "X of the Sage Hawk",
        text = {
            'Create a {C:tarot}Hermit{} every {C:attention}#3# {C:inactive}[#4#]{} times',
            'a playing card with rank of {C:attention}10{} scores.',
            '{C:inactive}(Must have room)',
            'Gain {X:mult,C:white}X#2#{} mult per {C:tarot}The Hermit{} used.',
            '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={3,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 1, Xmult_mod = 0.25,
        count_args = {
            down = 5,
            init = 5
        },
        upgrade_args = {
            scale_var = 'Xmult',
            --message = 'Haha!'
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_hermit
        return {
            vars = {
                cae.Xmult,
                cae.Xmult_mod,
                cae.count_args.init,
                cae.count_args.down,
            }
        }
    end,

    atlas = 'Relic_HoloX',
    pos      = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        holo_card_upgrade_by_consumeable(card, context, 'c_hermit')
        if context.individual and context.cardarea==G.play then
            if context.other_card:get_id()==10 and not context.blueprint then
                if holo_card_counting(card) then
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        return {
                            func = function()
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                                SMODS.add_card({ key = 'c_hermit', area = G.consumeables})
                            end,
                            card = card,
                        }
                    end
                end
            end
        elseif context.joker_main then
            return{
                Xmult = cae.Xmult,
                colour = Holo.C.Lui,
            }
        end
    end
}

SMODS.Atlas{ -- Hakui Koyori: Potion Sprites
    key = "Sticker_Potions",
    path = "textures/Sticker_Potions.png",
    px = 71,
    py = 95
}
local Koyori_Potion = SMODS.Sticker:extend{
    member = "Koyori",
    atlas="hololive_Sticker_Potions",
    badge_colour=Holo.C.Koyori,
    potion_config={
        red  = 10,
        cyan = 54,
        pink =  2,
        green=  3,
        gold = 10,
        blue =  1
    },
    loc_vars = function(self, info_queue, card)
        local pt_cfg = self.potion_config
        return { vars = {
            pt_cfg.red,
            pt_cfg.cyan,
            pt_cfg.pink,
            pt_cfg.green,
            pt_cfg.gold,
            pt_cfg.blue,
            colours = {
                HEX('e97896'),
                HEX('217eb7'),
            },
        }}
    end,
    should_apply = function(self, card, center, area, bypass_roll)
        for _, pc in ipairs({'red','cyan','pink','green','gold','blue'}) do
            if card.ability['hololive_potion_'..pc] then
                return false
            end
        end
        return ((area==G.hand)or bypass_roll)and(card and card.playing_card)
    end,
    calculate = function(self, card, context)
        local pt_cfg = self.potion_config
        if context.before and context.cardarea==G.play then
            if self.key == 'hololive_potion_green' and not card.chemical_chance then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal * pt_cfg.green
                card.potion_trigger=true
                card.chemical_chance=true
                return{message='Chance X'..pt_cfg.green..'!', colour=G.C.GREEN}
            elseif self.key == 'hololive_potion_gold' then
                card.potion_trigger=true
                return{dollars=pt_cfg.gold, colour=G.C.GOLD}
            elseif self.key == 'hololive_potion_blue' then
                card.potion_trigger=true
                return{level_up=pt_cfg.blue,colour=HEX('217eb7')}
            end
        elseif context.repetition and context.cardarea==G.play then
            if self.key == 'hololive_potion_pink' then
                card.potion_trigger=true
                return{repetitions=pt_cfg.pink,colour=HEX('e97896'),card=card}
            end
        elseif context.main_scoring and context.cardarea==G.play then
            if self.key == 'hololive_potion_red' then
                card.potion_trigger=true
                return{mult=pt_cfg.red}
            elseif self.key == 'hololive_potion_cyan' then
                card.potion_trigger=true
                return{chips=pt_cfg.cyan}
            end
        elseif context.destroy_card then
            if self.key == 'hololive_potion_green' and card.chemical_chance then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal / pt_cfg.green
                card.chemical_chance=nil
            end
            card.potion_trigger=nil
            local pc = self.key
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:remove_sticker(pc)
                    return true
                end
            }))
        end
    end
}
Koyori_Potion{ -- Hakui Koyori: Red Flask
    key='potion_red',
    loc_txt={
        name='Red flask',
        text={
            '{C:mult}+#1#{} mult',
            'when scored.'
        }
    },
    pos={x=0,y=0},
}
Koyori_Potion{ -- Hakui Koyori: Cyan Flask
    key='potion_cyan',
    loc_txt={
        name='Cyan flask',
        text={
            '{C:chips}+#2#{} chips',
            'when scored.'
        }
    },
    pos={x=0,y=1},
}
Koyori_Potion{ -- Hakui Koyori: Pink Testtube
    key='potion_pink',
    loc_txt={
        name='Pink testtube',
        text={
            'Retriggered {V:1}#3#{} times',
            'when played.'
        }
    },
    pos={x=1,y=0},
}
Koyori_Potion{ -- Hakui Koyori: Green Testtube
    key='potion_green',
    loc_txt={
        name='Green testtube',
        text={
            'Probability {C:green}X#4#',
            'while played.'
        }
    },
    pos={x=2,y=0},
}
Koyori_Potion{ -- Hakui Koyori: Gold Testtube
    key='potion_gold',
    loc_txt={
        name='Gold testtube',
        text={
            'Earn {C:gold}$#5#',
            'when played.'
        }
    },
    pos={x=1,y=1},
}
Koyori_Potion{ -- Hakui Koyori: Blue Testtube
    key='potion_blue',
    loc_txt={
        name='Blue testtube',
        text={
            'Level up played',
            '{V:2}poker hand #6# lv.',
            'when played.'
        }
    },
    pos={x=2,y=1},
}

Holo.Relic_Joker{ -- Hakui Koyori
    member = "Koyori",
    key = "Relic_Koyori",
    loc_txt = {
        name = "X of the Chemist Coyote",
        text = {
            'Cards has {C:green}#3# in #4#{} chance to receive random',
            '{V:1}chemical effects{} when drawn to hand.',
            'Cards with rank of {C:attention}10{} are {C:green}guaranteed',
            'to receive {V:1}chemical effect{} instead.',
            'Gain {X:mult,C:white}X#2#{} mult every time a chemical effect',
            'is triggered. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
            'Chemical effects are cleared at {C:attention}end of round{}.'
        }
        ,boxes={4,2,1}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult = 2, Xmult_mod = 0.2,
        odds = 10,
        upgrade_args = {
            scale_var = 'Xmult',
        },
        Potion_Rack = {
            red  = 3,
            cyan = 3,
            pink = 2,
            green= 1,
            gold = 2,
            blue = 1
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        return {
            vars = {
                cae.Xmult,
                cae.Xmult_mod,
                Holo.prob_norm(),
                cae.odds,
                colours = {Holo.C.Koyori}
            }
        }
    end,

    atlas = 'Relic_HoloX',
    pos      = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },

    remove_from_deck = function (self, card, from_debuff)
        if #find_joker(self.key)==0 then
            for _,v in ipairs(G.playing_cards)do
                for _,pc in ipairs({'red','cyan','pink','green','gold','blue'})do
                    v:remove_sticker('hololive_potion_'..pc)
                end
            end
        end
    end,
    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.hololive_drawn_card and G.GAME.facing_blind then
            local _tick = false
            if context.hololive_drawn_card:get_id()==10 then
                _tick = true
            elseif Holo.chance('Zunou of X', cae.odds) then
                _tick = true
            end
            if _tick then
                local _potion_type = Holo.pseudorandom_weighted_element(cae.Potion_Rack, 'Koyo')
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.hololive_drawn_card:juice_up()
                        context.hololive_drawn_card:add_sticker('hololive_potion_'.._potion_type)
                        return true
                    end
                }))
            end
        elseif context.before then
            for _,v in ipairs(context.full_hand)do
                if v.potion_trigger then -- Green, Gold, Blue
                    holo_card_upgrade(card)
                    v.potion_trigger=false
                end
            end
        elseif (context.individual or context.repetition) and context.cardarea==G.play then
            if context.other_card.potion_trigger then -- Red, Cyan, Pink
                holo_card_upgrade(card)
                context.other_card.potion_trigger=false
            end
        elseif context.end_of_round and context.cardarea==G.jokers then -- Extra cleaning measure
            for _,v in ipairs(G.playing_cards)do
                for _,pc in ipairs({'red','cyan','pink','green','gold','blue'})do
                    v:remove_sticker('hololive_potion_'..pc)
                end
            end
        elseif context.joker_main then
            return{
                Xmult = cae.Xmult,
                colour = Holo.C.Koyori,
            }
        end
    end
}

Holo.Relic_Joker{ -- Sakamata Chloe
    member = "Chloe",
    key = "Relic_Chloe",
    loc_txt = {
        name = "X of the Cleaner Orca",
        text = {
            'Discarded cards with ranks {C:attention}other than 10',
            'have {C:green}#5# in #6#{} chance to get {C:red}cleaned away{}.',
            'Create a {C:dark_edition}Negative {C:tarot}Magician{} every {C:attention}#4# {C:inactive}[#3#]{} discards.',
            'Gain {X:mult,C:white}X#2#{} mult per discard with no card',
            'needed to be cleaned. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,1,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult=5, Xmult_mod=0.5,
        odds=5,
        upgrade_args = {
            scale_var = 'Xmult',
        },
        count_args = {
            down = 5, init = 5
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_magician
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.count_args.down,
                cae.count_args.init,
                Holo.prob_norm(), cae.odds,
            }
        }
    end,

    atlas = 'Relic_HoloX',
    pos      = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.pre_discard then
            local is_ten = function(v)
                return (v:get_id()==10)
            end
            if Holo.series_and(context.full_hand, is_ten) then
                holo_card_upgrade(card)
            end
            if holo_card_counting(card) then
                SMODS.add_card({ key = 'c_magician', area = G.consumeables, edition = 'e_negative' })
            end
        elseif context.discard then
            if context.other_card:get_id()~=10 then
                if Holo.chance('Chloe', cae.odds) then
                    return{remove=true,message='Baku!',colour=Holo.C.Chloe}
                end
            end
        elseif context.joker_main then
            return{Xmult=cae.Xmult,colour=Holo.C.Chloe}
        end
    end
}

Holo.Relic_Joker{ -- Kazama Iroha
    member = "Iroha",
    key = "Relic_Iroha",
    loc_txt = {
        name = "X of the Bodyguard Samurai",
        text = {
            'Played cards with ranks {C:attention}other than 10',
            'have {C:green}#5# in #6#{} chance to get {C:red}slashed{} after scoring.',
            'Create a {C:dark_edition}Negative {C:tarot}Star{} every {C:attention}#4# {C:inactive}[#3#]{} played hands.',
            'Gain {X:mult,C:white}X#2#{} mult per played hand with no card',
            'needed to be slashed. {C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
        ,boxes={2,1,2}
        ,unlock=Holo.Relic_unlock_text
    },
    config = { extra = {
        Xmult=5, Xmult_mod=0.5,
        odds=5,
        upgrade_args = {
            scale_var = 'Xmult',
        },
        count_args = {
            down = 5, init = 5
        }
    }},
    loc_vars = function(self, info_queue, card)
        local cae = card.ability.extra
        info_queue[#info_queue+1] = G.P_CENTERS.c_star
        return {
            vars = {
                cae.Xmult, cae.Xmult_mod,
                cae.count_args.down,
                cae.count_args.init,
                Holo.prob_norm(), cae.odds,
            }
        }
    end,

    atlas = 'Relic_HoloX',
    pos      = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        local cae = card.ability.extra
        if context.before then
            local is_ten = function(v)
                return (v:get_id()==10)
            end
            if Holo.series_and(context.full_hand, is_ten) then
                holo_card_upgrade(card)
            end
            if holo_card_counting(card) then
                SMODS.add_card({ key = 'c_star', area = G.consumeables, edition = 'e_negative' })
            end
        elseif context.destroy_card and context.cardarea == G.play then
            if context.destroy_card:get_id()~=10 then
                if Holo.chance('Iroha', cae.odds) then
                    return{remove=true,message='Sha-kin!',colour=Holo.C.Iroha}
                end
            end
        elseif context.joker_main then
            return{Xmult=cae.Xmult,colour=Holo.C.Iroha}
        end
    end
}

----