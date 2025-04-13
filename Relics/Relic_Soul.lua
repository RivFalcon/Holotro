----
local relicgacha_text={
    "Creates a",
    "{V:1,E:1}#1# Relic",
    "{C:inactive}(Must have room)",
}

SMODS.ConsumableType{
    key = 'relicgacha',
    primary_colour = Holo.C.Hololive_dark,
    secondary_colour = Holo.C.Hololive,
    loc_txt = {
        name = "Relic Gacha",
        collection = "Hololive Relic Gacha",
        undiscovered = {
            name = "Relic Gacha",
            text = {
                "Creates a",
                "{C:dark_edition}???{} Relic",
                "{C:inactive}(Must have room)",
            }
        }
    },
    collection_rows = {5,6},
    shop_rate = 0.05,
}

Holo.Relic_Gacha = SMODS.Consumable:extend{
    set = 'relicgacha',
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.group_name,
                colours = { card.ability.extra.colour }
            }
        }
    end,
    unlocked = true,
    discovered = false,
    memberlist = {},

    in_pool = function(self, args)
        local _tick = 0
        for _,m in ipairs(self.memberlist) do
            if next(find_joker('j_hololive_Relic_'..m))then
                _tick = _tick + 1
            end
        end
        if _tick > 0 and ((_tick < #self.memberlist) or next(find_joker('Showman'))) then
            return true
        else
            return false
        end
    end,
    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
            return true
        else
            return false
        end
    end,
    keep_on_use = function(self, card)
        return false
    end,
    use = function(self, card, area, copier)
        local _pool = {}
        if next(find_joker('Showman')) then
            _pool = self.memberlist
        else
            for _,m in ipairs(self.memberlist) do
                if not next(find_joker('j_hololive_Relic_'..m)) then
                    _pool[#_pool+1] = m
                end
            end
            if #_pool == 0 then _pool = self.memberlist end
        end
        local _member = pseudorandom_element(_pool, pseudoseed(card.ability.extra.group_name))
        local _key = 'j_hololive_Relic_'.._member
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            SMODS.add_card({key = _key, area = G.jokers})
        return true end }))
    end,
}

SMODS.Atlas{
    key = "RelicGacha_HQ",
    path = "Relics/RelicGacha_HQ.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "RelicGacha_JP",
    path = "Relics/RelicGacha_JP.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "RelicGacha_ID",
    path = "Relics/RelicGacha_ID.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "RelicGacha_EN",
    path = "Relics/RelicGacha_EN.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "RelicGacha_DI",
    path = "Relics/RelicGacha_DI.png",
    px = 71,
    py = 95
}

local function RelicGacha()
    local have_Showman = next(find_joker('Showman'))
    local dupe_check = function(M)return have_Showman or not next(find_joker('j_hololive_Relic_'..M))end

    local hbd_member = Holo.birthday_chart[os.date('%m%d')]
    if hbd_member and dupe_check(hbd_member) then
        return hbd_member
    end

    local pool_modes_weight = {['Synergy'] = 3, ['All Stars'] = 1}
    for _,J in ipairs(G.jokers.cards)do
        if J.config.center.rarity == 'hololive_Relic' then
            pool_modes_weight['Genmates'] = 4
            break
        end
    end
    local pool_mode = Holo.pseudorandom_weighted_element(pool_modes_weight, 'RelicGachaMode')

    local _pool = {}
    if pool_mode == 'Synergy' then
        local card_stats = {
            suits = {
                Spades = 0,
                Hearts = 0,
                Clubs = 0,
                Diamonds = 0
            },
            ranks = {
                Face = 0,
                Non_face = 0,
                Ace = 0,
                X = 0,
                Odd = 0,
                Even = 0,
                Hack = 0,
            },
            enhans = {
                m_base = 0,
                m_bonus = 0,
                m_mult = 0,
                m_wild = 0,
                m_glass = 0,
                m_steel = 0,
                m_stone = 0,
                m_gold = 0,
                m_lucky = 0
            },
            edits = {
                e_base = 0,
                e_foil = 0,
                e_holo = 0,
                e_polychrome = 0
            },
            seals = {
                Base = 0,
                Gold = 0,
                Red = 0,
                Blue = 0,
                Purple = 0
            },
        }

        -- Analyzing full deck
        for _,c in ipairs(G.playing_cards)do

            -- Suits
            for suit,counter in pairs(card_stats.suits)do
                if c:is_suit(suit) then card_stats.suits[suit] = counter + 1 end
            end

            -- Ranks
            if c:is_face() then card_stats.ranks.Face = card_stats.ranks.Face + 1
            else card_stats.ranks.Non_face = card_stats.ranks.Non_face + 1
            end
            local _rank = c:get_id()
            if _rank == 14 then
                card_stats.ranks.Ace = card_stats.ranks.Ace + 1
                card_stats.ranks.Odd = card_stats.ranks.Odd + 1
            elseif _rank == 10 then
                card_stats.ranks.X = card_stats.ranks.X + 1
                card_stats.ranks.Even = card_stats.ranks.Even + 1
            elseif (_rank == 9)or(_rank == 7) then
                card_stats.ranks.Odd = card_stats.ranks.Odd + 1
            elseif (_rank == 8)or(_rank == 6) then
                card_stats.ranks.Even = card_stats.ranks.Even + 1
            elseif (_rank == 5)or(_rank == 3) then
                card_stats.ranks.Odd = card_stats.ranks.Odd + 1
                card_stats.ranks.Hack = card_stats.ranks.Hack + 1
            elseif (_rank == 4)or(_rank == 2) then
                card_stats.ranks.Even = card_stats.ranks.Even + 1
                card_stats.ranks.Hack = card_stats.ranks.Hack + 1
            end

            -- Enhancements
            local not_enhanced = true
            for enhan,counter in pairs(card_stats.enhans) do
                if enhan ~= 'm_base' and SMODS.has_enhancement(c,enhan)then
                    card_stats.enhans[enhan] = counter + 1
                    not_enhanced = false
                end
            end
            if not_enhanced then
                card_stats.enhans.m_base = card_stats.enhans.m_base + 1
            end

            -- Editions
            if c.edition == nil then
                card_stats.edits.e_base = card_stats.edits.e_base + 1
            else
                for edit,counter in pairs(card_stats.edits)do
                    if edit ~= 'e_base' and (c.edition or {}).key == edit then
                        card_stats.edits[edit] = counter + 1
                    end
                end
            end

            -- Seals
            if c.seal == nil then card_stats.seals.Base = card_stats.seals.Base + 1
            elseif card_stats.seals[c.seal] then card_stats.seals[c.seal] = card_stats.seals[c.seal] + 1
            end
        end

        local deck_size = #G.playing_cards
        local deck_stat = {
            Spades = card_stats.suits.Spades*4 >= deck_size,
            Hearts = card_stats.suits.Hearts*4 >= deck_size,
            Clubs = card_stats.suits.Clubs*4 >= deck_size,
            Diamonds = card_stats.suits.Diamonds*4 >= deck_size,

            Face = card_stats.ranks.Face*4 >= deck_size,
            Non_face = card_stats.ranks.Non_face*2 >= deck_size,
            Ace = card_stats.ranks.Ace*12 >= deck_size,
            X = card_stats.ranks.X*12 >= deck_size,
            Odd = card_stats.ranks.Odd*2.5 >= deck_size,
            Even = card_stats.ranks.Even*2.5 >= deck_size,
            Hack = card_stats.ranks.Hack*3 >= deck_size,

            Enhanceless = card_stats.enhans.m_base >= deck_size*0.5,
            Enhanced = card_stats.enhans.m_base <= deck_size*0.8,
            Bonus = card_stats.enhans.m_bonus >= 2,
            Mult  = card_stats.enhans.m_mult  >= 2,
            Wild  = card_stats.enhans.m_wild  >= 5,
            Glass = card_stats.enhans.m_glass >= 4,
            Steel = card_stats.enhans.m_steel >= 3,
            Stone = card_stats.enhans.m_stone >= 3,
            Gold  = card_stats.enhans.m_gold  >= 3,
            Lucky = card_stats.enhans.m_lucky >= 2,

            Editionless = card_stats.edits.e_base >= deck_size*0.5,
            Editioned = card_stats.edits.e_base <= deck_size*0.8,
            Foil  = card_stats.edits.e_foil >= 5,
            Holog = card_stats.edits.e_holo >= 4,
            Polychrome = card_stats.edits.e_polychrome >= 3,

            Sealless = card_stats.seals.Base >= deck_size*0.5,
            Sealed = card_stats.seals.Base <= deck_size*0.9,
            Gold_seal = card_stats.seals.Gold >= 3,
            Red_seal = card_stats.seals.Red >= 3,
            Blue_seal = card_stats.seals.Blue >= 3,
            Purple_seal = card_stats.seals.Purple >= 3,
        }
        local hand_usage = Holo.hand_contained_usage()

        local c_usage = G.GAME.consumeable_usage
        local c_usage_total = G.GAME.consumeable_usage_total or {}
        local syn_table = {
            -- JP012G.
            Sora     = deck_stat.Diamonds,
            Roboco   = deck_stat.Diamonds or deck_stat.Steel,
            Suisei   = deck_stat.Diamonds or c_usage.c_star,
            Mel      = false, -- deck_stat.Enhanced,
            Fubuki   = false, -- c_usage.c_fool,
            Matsuri  = false,
            Aki      = false,
            Haato    = false, -- deck_stat.Hearts or c_usage.c_sun,
            Miko     = deck_stat.Diamonds or c_usage.c_star,
            Aqua     = hand_usage['High Card'],
            Shion    = deck_stat.Lucky or deck_stat.Ace,
            Ayame    = hand_usage['High Card'],
            Choco    = deck_stat.Ace,
            Subaru   = true,
            AZKi     = deck_stat.Diamonds,
            Mio      = false, -- c_usage_total.tarot,
            Okayu    = false,
            Korone   = false,
            -- JP34, ID1, JP5.
            Pekora   = deck_stat.Gold,
            Rushia   = true,
            Flare    = hand_usage['Two Pair'],
            Noel     = deck_stat.Gold or deck_stat.Steel or hand_usage['Two Pair'],
            Marine   = deck_stat.Gold,
            Kanata   = false, -- c_usage.c_judgement,
            Coco     = false,
            Watame   = false,
            Towa     = false, -- c_usage.c_devil,
            Luna     = false,
            Risu     = deck_stat.Clubs,
            Moona    = deck_stat.Clubs or c_usage.c_moon,
            Iofi     = deck_stat.Clubs,
            Lamy     = false, -- deck_stat.Wild or c_usage.c_lovers,
            Nene     = false, -- deck_stat.Wild or c_usage.c_lovers,
            Botan    = false, -- deck_stat.Wild or c_usage.c_lovers,
            Aloe     = false, -- deck_stat.Wild,
            Polka    = false, -- deck_stat.Wild or c_usage.c_lovers,
            -- EN1, ID2, EN2, JPX, ID3.
            Calli    = c_usage.c_death,
            Kiara    = true,
            Ina      = c_usage.c_medium or deck_stat.Purple_seal,
            Gura     = c_usage.c_jupiter or c_usage.c_saturn or c_usage.c_neptune or hand_usage["Straight Flush"],
            Ame      = deck_stat.Face,
            Ollie    = false,
            Anya     = false,
            Reine    = false,
            IRyS     = c_usage_total.all,
            Sana     = c_usage_total.planet,
            Fauna    = c_usage.c_earth or c_usage.c_ceres or hand_usage["Full House"],
            Kronii   = deck_stat.Spades or c_usage.c_world,
            Mumei    = deck_stat.Spades,
            Bae      = true,
            Laplus   = deck_stat.X or c_usage.c_planet_x,
            Lui      = deck_stat.X or c_usage.c_hermit,
            Koyori   = deck_stat.X,
            Chloe    = deck_stat.X,
            Iroha    = deck_stat.X,
            Zeta     = false,
            Kaela    = false, -- deck_stat.Enhanced,
            Kobo     = false,
            -- EN3, DI1, EN4, DI2.
            Shiori   = deck_stat.Non_face,
            Biboo    = deck_stat.Non_face or deck_stat.Stone or c_usage.c_tower,
            Nerissa  = deck_stat.Non_face,
            Fuwawa   = deck_stat.Non_face or deck_stat.Odd,
            Mococo   = deck_stat.Non_face or deck_stat.Even,
            Ao       = false,
            Kanade   = false,
            Ririka   = false,
            Raden    = false,
            Hachime  = false,
            Elizabeth= deck_stat.Glass or c_usage.c_justice,
            Gigi     = deck_stat.Glass,
            Ceci     = deck_stat.Glass,
            Raora    = deck_stat.Glass,
            Riona    = false,
            Niko     = false, -- deck_stat.Editioned and deck_stat.Face
            Suu      = false, -- c_usage.c_aura
            Chihaya  = false, -- c_usage.c_wheel_of_fortune
            Vivi     = false,
        }
        for member,condition in pairs(syn_table)do
            if condition and dupe_check(member) then _pool[#_pool+1] = member end
        end
        if #_pool == 0 then pool_mode = 'All Stars' end

    elseif pool_mode == 'Genmates' then
        local sample_pool = {}
        for _,J in ipairs(G.jokers.cards)do
            if J.config.center.rarity == 'hololive_Relic' then
                sample_pool[#sample_pool+1] = J.config.center.member
            end
        end
        local target_member = sample_pool[1]
        if #sample_pool>1 then target_member = pseudorandom_element(sample_pool,pseudoseed('RelicGacha GenmateMode'))end

        for _, memb in ipairs(Holo.get_genmates(target_member)) do
            if dupe_check(memb)then
                _pool[#_pool+1] = memb
            end
        end
        -- If the relics of all the genmates have been obtained:
        if #_pool == 0 then
            local _branch = Holo.Members[target_member].branch
            for _, memb in ipairs(Holo.Branches[_branch].members)do
                if dupe_check(memb)then
                    _pool[#_pool+1] = memb
                end
            end
        end
        -- If the relics of all the branchmates have been obtained:
        if #_pool == 0 then pool_mode = 'All Stars' end
    end
    if pool_mode == 'All Stars' then
        local implemented_relics = {} -- Holo.memberlist
        local implemented_gens = {
            'gen_origin',
            'gen_exodia',
            'gen_fantasy',
            'gen_area15',
            'gen_myth',
            'gen_promise',
            'gen_holox',
            'gen_advent',
            'gen_justice',
        }
        for _,_gen in ipairs(implemented_gens)do
            for _,member in ipairs(Holo.Generations[_gen].members)do
                implemented_relics[#implemented_relics+1] = member
            end
        end
        for _,memb in ipairs(implemented_relics) do
            if dupe_check(memb)then
                _pool[#_pool+1] = memb
            end
        end
        if #_pool == 0 then _pool = implemented_relics end
    end

    return pseudorandom_element(_pool, pseudoseed('Hololive'))
end

Holo.Relic_Gacha{ -- Hololive
    key = 'RelicGacha_Hololive',
    loc_txt = {
        name = 'The Hololive',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive',
        colour = Holo.C.Hololive,
    }},
    hidden = true,
    soul_set = 'Tarot',
    soul_rate = 0.05,
    can_repeat_soul = false,

    atlas = 'RelicGacha_HQ',
    pos      = {x=0,y=0},
    soul_pos = {x=0,y=1},

    in_pool = function(self, args)
        for _,J in ipairs(G.jokers.cards) do
            if Holo.mod_check(J) then return true end
        end
    end,
    use = function(self, card, area, copier)
        local _member = RelicGacha()
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            SMODS.add_card({key = 'j_hololive_Relic_'.._member, area = G.jokers})
        return true end }))
    end,
}

Holo.Relic_Gacha{ -- JP -- Japan
    key = 'RelicGacha_Branch_JP',
    loc_txt = {
        name = 'The Main',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive JP',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Branches.JP.members,

    atlas = 'RelicGacha_HQ',
    pos      = {x=1,y=0},
    soul_pos = {x=1,y=1},
}

Holo.Relic_Gacha{ -- ID -- Indonesia
    key = 'RelicGacha_Branch_ID',
    loc_txt = {
        name = 'The Identity',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive ID',
        colour = Holo.C.ID,
    }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "Hololive ID",
                colours = { Holo.C.ID }
            }
        }
    end,
    memberlist = Holo.Branches.JP.members,

    atlas = 'RelicGacha_HQ',
    pos      = {x=2,y=0},
    soul_pos = {x=2,y=1},
}

Holo.Relic_Gacha{ -- EN -- English
    key = 'RelicGacha_Branch_EN',
    loc_txt = {
        name = 'The Enigma',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive EN',
        colour = Holo.C.EN,
    }},
    memberlist = Holo.Branches.EN.members,

    atlas = 'RelicGacha_HQ',
    pos      = {x=3,y=0},
    soul_pos = {x=3,y=1},
}

Holo.Relic_Gacha{ -- DI -- DEV_IS
    key = 'RelicGacha_Branch_DI',
    loc_txt = {
        name = 'The Devise',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'DEV_IS',
        colour = Holo.C.DI,
    }},
    memberlist = Holo.Branches.DI.members,

    atlas = 'RelicGacha_HQ',
    pos      = {x=4,y=0},
    soul_pos = {x=4,y=1},
}

Holo.Relic_Gacha{ -- JP0 -- Origin
    key = 'RelicGacha_Gen_JP0',
    loc_txt = {
        name = 'The Origin',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive Gen 0',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_origin.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=0,y=0},
}

Holo.Relic_Gacha{ -- JP1 -- First
    key = 'RelicGacha_Gen_JP1',
    loc_txt = {
        name = 'The First',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive Gen 1',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_first.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=1,y=0},
}

Holo.Relic_Gacha{ -- JP2 -- Exodia
    key = 'RelicGacha_Gen_JP2',
    loc_txt = {
        name = 'The Exodia',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive Gen 2',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_exodia.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=2,y=0},
}

Holo.Relic_Gacha{ -- JPG -- Gamers
    key = 'RelicGacha_Gen_JPG',
    loc_txt = {
        name = 'The Gamers',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive Gamers',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_gamers.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=3,y=0},
}

Holo.Relic_Gacha{ -- JP3 -- Fantasy
    key = 'RelicGacha_Gen_JP3',
    loc_txt = {
        name = 'The Fantasy',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive Fantasy',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_fantasy.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=0,y=1},
}

Holo.Relic_Gacha{ -- JP4 -- Force
    key = 'RelicGacha_Gen_JP4',
    loc_txt = {
        name = 'The Force',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive Force',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_force.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=1,y=1},
}

Holo.Relic_Gacha{ -- ID1 -- Area 15
    key = 'RelicGacha_Gen_ID1',
    loc_txt = {
        name = 'Area 15',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloID Area 15',
        colour = Holo.C.ID,
    }},
    memberlist = Holo.Generations.gen_area15.members,

    atlas = 'RelicGacha_ID',
    pos   = {x=1,y=0},
}

Holo.Relic_Gacha{ -- JP5 -- NePoLABo
    key = 'RelicGacha_Gen_JP5',
    loc_txt = {
        name = 'NePoLABo',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Hololive NePoLABo',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_nplab.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=2,y=1},
}

Holo.Relic_Gacha{ -- EN1 -- Myth
    key = 'RelicGacha_Gen_EN1',
    loc_txt = {
        name = 'The Myth',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloEN Myth',
        colour = Holo.C.EN,
    }},
    memberlist = Holo.Generations.gen_myth.members,

    atlas = 'RelicGacha_EN',
    pos   = {x=1,y=0},
}

Holo.Relic_Gacha{ -- ID2 -- Holoro
    key = 'RelicGacha_Gen_ID2',
    loc_txt = {
        name = 'Holoro',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloID Holoro',
        colour = Holo.C.ID,
    }},
    memberlist = Holo.Generations.gen_holoro.members,

    atlas = 'RelicGacha_ID',
    pos   = {x=2,y=0},
}

Holo.Relic_Gacha{ -- EN2 -- CounsilRyS/PromiSana
    key = 'RelicGacha_Gen_EN2',
    loc_txt = {
        name = 'The Promise',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloEN Promise',
        colour = Holo.C.EN,
    }},
    memberlist = Holo.Generations.gen_promise.members,

    atlas = 'RelicGacha_EN',
    pos   = {x=2,y=0},
}

Holo.Relic_Gacha{ -- JPX -- HoloX
    key = 'RelicGacha_Gen_JPX',
    loc_txt = {
        name = 'The HoloX',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'Secret Society holoX',
        colour = Holo.C.JP,
    }},
    memberlist = Holo.Generations.gen_holox.members,

    atlas = 'RelicGacha_JP',
    pos   = {x=3,y=1},
}

Holo.Relic_Gacha{ -- ID3 -- HoloH3ro
    key = 'RelicGacha_Gen_ID3',
    loc_txt = {
        name = 'The H3ro',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloID HoloH3ro',
        colour = Holo.C.ID,
    }},
    memberlist = Holo.Generations.gen_holoh3ro.members,

    atlas = 'RelicGacha_ID',
    pos   = {x=3,y=0},
}

Holo.Relic_Gacha{ -- EN3 -- Advent
    key = 'RelicGacha_Gen_EN3',
    loc_txt = {
        name = 'The Advent',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloEN Advent',
        colour = Holo.C.EN,
    }},
    memberlist = Holo.Generations.gen_advent.members,

    atlas = 'RelicGacha_EN',
    pos   = {x=3,y=0},
}

Holo.Relic_Gacha{ -- DI1 -- ReGLOSS
    key = 'RelicGacha_Gen_DI1',
    loc_txt = {
        name = 'The Regloss',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'DEV_IS ReGLOSS',
        colour = Holo.C.DI,
    }},
    memberlist = Holo.Generations.gen_regloss.members,

    atlas = 'RelicGacha_DI',
    pos   = {x=1,y=0},
}

Holo.Relic_Gacha{ -- EN4 -- Justice
    key = 'RelicGacha_Gen_EN4',
    loc_txt = {
        name = 'The Justice',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'HoloEN Justice',
        colour = Holo.C.EN,
    }},
    memberlist = Holo.Generations.gen_justice.members,

    atlas = 'RelicGacha_EN',
    pos   = {x=4,y=0},
}

Holo.Relic_Gacha{ -- DI2 -- FLOWGLOW
    key = 'RelicGacha_Gen_DI2',
    loc_txt = {
        name = 'The Flow Glow',
        text = relicgacha_text
    },
    config = { extra = {
        group_name = 'DEV_IS FLOW GLOW',
        colour = Holo.C.DI,
    }},
    memberlist = Holo.Generations.gen_flowglow.members,

    atlas = 'RelicGacha_DI',
    pos   = {x=2,y=0},
}
