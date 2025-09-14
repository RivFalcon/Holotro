-- Global Variable "Holo"
Holo = {}

Holo.C = {Hololive = HEX('33C9FE'), Hololive_bright = HEX('81cefd'), Hololive_dark = HEX('008be3')}
Holo.Branches = {
    JP = {order = 1, name = 'hololive' , gens={},members={}, C = Holo.C.Hololive, },
    ID = {order = 2, name = 'holoID'   , gens={},members={}, C = HEX('ff7c4d'), },
    EN = {order = 3, name = 'holoEN'   , gens={},members={}, C = HEX('c283b6'), },
    DI = {order = 4, name = 'DEV_IS'   , gens={},members={}, C = HEX('010101'), },
}
for branch_name,branch_data in pairs(Holo.Branches)do
    Holo.C[branch_name] = branch_data.C
end
Holo.Generations = {
    gen_origin={
        order =  1, branch = 'JP', codename =   'Origin', name = 'Gen 0',
        members = {
            "Sora",
            "Roboco",
            "Suisei",
            "Miko",
            "AZKi"
        },
    },
    gen_first={
        order =  2, branch = 'JP', codename =    'First', name = 'Gen 1',
        members = {
            "Mel",
            "Fubuki",
            "Matsuri",
            "Aki",
            "Haato"
        },
    },
    gen_exodia={
        order =  3, branch = 'JP', codename =   'Exodia', name = 'Gen 2',
        members = {
            "Aqua",
            "Shion",
            "Ayame",
            "Choco",
            "Subaru"
        },
    },
    gen_gamers={
        order =  4, branch = 'JP', codename =   'Gamers', name = 'Gamers',
        members = {
            "Fubuki",
            "Mio",
            "Okayu",
            "Korone"
        },
    },
    gen_fantasy={
        order =  5, branch = 'JP', codename =  'Fantasy', name = 'Fantasy',
        members = {
            "Pekora",
            "Rushia",
            "Flare",
            "Noel",
            "Marine"
        },
    },
    gen_force={
        order =  6, branch = 'JP', codename =    'Force', name = 'Force',
        members = {
            'Kanata',
            'Coco',
            'Watame',
            'Towa',
            'Luna'
        },
    },
    gen_area15={
        order =  7, branch = 'ID', codename =   'Area15', name = 'Area15',
        members = {
            'Risu',
            'Moona',
            'Iofi'
        },
    },
    gen_nplab={
        order =  8, branch = 'JP', codename = 'NePoLABo', name = 'Gen 5',
        members = {
            'Lamy',
            'Nene',
            'Botan',
            'Aloe',
            'Polka'
        },
    },
    gen_myth={
        order =  9, branch = 'EN', codename =     'Myth', name = 'Myth',
        members = {
            'Calli',
            'Kiara',
            'Ina',
            'Gura',
            'Ame'
        },
    },
    gen_holoro={
        order = 10, branch = 'ID', codename =   'holoro', name = 'Holoro',
        members = {
            'Ollie',
            'Anya',
            'Reine'
        },
    },
    gen_promise={
        order = 11, branch = 'EN', codename =  'Promise', name = 'Promise',
        members = {
            'IRyS',
            'Sana',
            'Fauna',
            'Kronii',
            'Mumei',
            'Bae'
        },
    },
    gen_holox={
        order = 12, branch = 'JP', codename =    'holoX', name = 'holoX',
        members = {
            'Laplus',
            'Lui',
            'Koyori',
            'Chloe',
            'Iroha'
        },
    },
    gen_holoh3ro={
        order = 13, branch = 'ID', codename =     'H3ro', name = 'HoloH3ro',
        members = {
            'Zeta',
            'Kaela',
            'Kobo'
        },
    },
    gen_advent={
        order = 14, branch = 'EN', codename =   'Advent', name = 'Advent',
        members = {
            'Shiori',
            'Biboo',
            'Nerissa',
            'Fuwawa',
            'Mococo'
        },
    },
    gen_regloss={
        order = 15, branch = 'DI', codename =  'ReGloss', name = 'ReGLOSS',
        members = {
            'Ao',
            'Kanade',
            'Ririka',
            'Raden',
            'Hachime'
        },
    },
    gen_justice={
        order = 16, branch = 'EN', codename =  'Justice', name = 'Justice',
        members = {
            'Elizabeth',
            'Gigi',
            'Ceci',
            'Raora'
        },
    },
    gen_flowglow={
        order = 17, branch = 'DI', codename = 'FlowGlow', name = 'FLOW GLOW',
        members = {
            'Riona',
            'Niko',
            'Suu',
            'Chihaya',
            'Vivi',
        },
    },
}
for gen_key, gen_data in pairs(Holo.Generations) do
    Holo.Branches[gen_data.branch].gens[#Holo.Branches[gen_data.branch].gens+1] = gen_key
end

Holo.gen_order = {
    'JP0',
    'JP1',
    'JP2',
    'JPG',

    'JP3',
    'JP4',
    'ID1',
    'JP5',

    'EN1',
    'ID2',
    'EN2',
    'JPX',
    'ID3',

    'EN3',
    'DI1',
    'EN4',
    'DI2',
}

Holo.Collabs = {
    collab_micomet = {
        members = {'Miko','Suisei'}
    },
    collab_mikorone = {
        members = {'Miko','Korone'}
    },
    collab_okakoro = {
        members = {'Okayu','Korone'}
    },
    collab_smok = {
        members = {
            'Subaru',
            'Mio',
            'Okayu',
            'Korone'
        }
    },
    collab_snot = {
        members = {
            'Gura',  -- Shark
            'Fauna', -- Nature
            'Mumei', -- Owl
            'Kronii' -- Time
        }
    },
    collab_soraz = {
        members = {'Sora','AZKi'}
    },
    collab_startend = {
        members = {
            'Suisei',
            'Towa',
            'Aqua'
        }
    },
    collab_subachocolunatan = {
        members = {
            'Subaru',
            'Choco',
            'Luna',
            'Botan'
        }
    },
}

Holo.Units = {
    unit_holocanine = {
        members = {
            'Fubuki',
            'Mio',
            'Korone',
            'Polka',
            'Koyori',
            'Fuwawa',
            'Mococo',
        }
    },
    unit_holotori = {
        members = {
            'Kiara',
            'Subaru',
            'Reine',
            'Mumei',
            'Lui'
        }
    },
    unit_shiraken = {
        members = {
            'Flare',
            'Polka',
            'Miko',
            'Suisei',
            'Noel'
        }
    },
    unit_umisea = {
        members = {
            'Marine',
            'Aqua',
            'Ina',
            'Gura',
            'Chloe'
        }
    },
}

Holo.Members = {
    -- JP012G.
    Sora     = {order =  1, branch = 'JP', C = HEX('2a69fb'), },
    Roboco   = {order =  2, branch = 'JP', C = HEX('ffa3cf'), },
    Suisei   = {order =  3, branch = 'JP', C = HEX('7bacec'), },
    Mel      = {order =  4, branch = 'JP', C = HEX('fdd531'), },
    Fubuki   = {order =  5, branch = 'JP', C = HEX('53c7ea'), },
    Matsuri  = {order =  6, branch = 'JP', C = HEX('ff5606'), },
    Aki      = {order =  7, branch = 'JP', C = HEX('4982fe'), },
    Haato    = {order =  8, branch = 'JP', C = HEX('d9062a'), },
    Miko     = {order =  9, branch = 'JP', C = HEX('ff9cb4'), },
    Aqua     = {order = 10, branch = 'JP', C = HEX('eaabdc'), },
    Shion    = {order = 11, branch = 'JP', C = HEX('8565fc'), },
    Ayame    = {order = 12, branch = 'JP', C = HEX('c72554'), },
    Choco    = {order = 13, branch = 'JP', C = HEX('fe739c'), },
    Subaru   = {order = 14, branch = 'JP', C = HEX('e5ed76'), },
    AZKi     = {order = 15, branch = 'JP', C = HEX('fa3689'), },
    Mio      = {order = 16, branch = 'JP', C = HEX('dc1935'), },
    Okayu    = {order = 17, branch = 'JP', C = HEX('b190fa'), },
    Korone   = {order = 18, branch = 'JP', C = HEX('fae13f'), },
    -- JP34, ID1, JP5.
    Pekora   = {order = 19, branch = 'JP', C = HEX('7dc4fc'), },
    Rushia   = {order = 20, branch = 'JP', C = HEX('04e3cb'), },
    Flare    = {order = 21, branch = 'JP', C = HEX('ff5028'), },
    Noel     = {order = 22, branch = 'JP', C = HEX('aebbc3'), },
    Marine   = {order = 23, branch = 'JP', C = HEX('923749'), },
    Kanata   = {order = 24, branch = 'JP', C = HEX('367ce5'), },
    Coco     = {order = 25, branch = 'JP', C = HEX('fd935f'), },
    Watame   = {order = 26, branch = 'JP', C = HEX('f6eca5'), },
    Towa     = {order = 27, branch = 'JP', C = HEX('7b66a8'), },
    Luna     = {order = 28, branch = 'JP', C = HEX('e77dbc'), },
    Risu     = {order = 29, branch = 'ID', C = HEX('ef8381'), },
    Moona    = {order = 30, branch = 'ID', C = HEX('cbb3ff'), },
    Iofi     = {order = 31, branch = 'ID', C = HEX('bef167'), },
    Lamy     = {order = 32, branch = 'JP', C = HEX('6ccdf8'), },
    Nene     = {order = 33, branch = 'JP', C = HEX('ffb65d'), },
    Botan    = {order = 34, branch = 'JP', C = HEX('f2eae7'), },
    Aloe     = {order = 35, branch = 'JP', C = HEX('f38cc4'), },
    Polka    = {order = 36, branch = 'JP', C = HEX('ab0808'), },
    -- EN1, ID2, EN2, JPX, ID3.
    Calli    = {order = 37, branch = 'EN', C = HEX('a1020b'), },
    Kiara    = {order = 38, branch = 'EN', C = HEX('dc3907'), },
    Ina      = {order = 39, branch = 'EN', C = HEX('3f3e69'), },
    Gura     = {order = 40, branch = 'EN', C = HEX('5d81c7'), },
    Ame      = {order = 41, branch = 'EN', C = HEX('f8db92'), },
    Ollie    = {order = 42, branch = 'ID', C = HEX('b7030e'), },
    Anya     = {order = 43, branch = 'ID', C = HEX('dab75b'), },
    Reine    = {order = 44, branch = 'ID', C = HEX('2a64ae'), },
    IRyS     = {order = 45, branch = 'EN', C = HEX('3c0024'), },
    Sana     = {order = 46, branch = 'EN', C = HEX('fede4a'), },
    Fauna    = {order = 47, branch = 'EN', C = HEX('a4e5cf'), },
    Kronii   = {order = 48, branch = 'EN', C = HEX('0869ec'), },
    Mumei    = {order = 49, branch = 'EN', C = HEX('998274'), },
    Bae      = {order = 50, branch = 'EN', C = HEX('d2251e'), },
    Laplus   = {order = 51, branch = 'JP', C = HEX('441495'), },
    Lui      = {order = 52, branch = 'JP', C = HEX('831550'), },
    Koyori   = {order = 53, branch = 'JP', C = HEX('fe68ad'), },
    Chloe    = {order = 54, branch = 'JP', C = HEX('ab0e0c'), },
    Iroha    = {order = 55, branch = 'JP', C = HEX('44bfb7'), },
    Zeta     = {order = 56, branch = 'ID', C = HEX('97a1ae'), },
    Kaela    = {order = 57, branch = 'ID', C = HEX('dc2528'), },
    Kobo     = {order = 58, branch = 'ID', C = HEX('cdedfc'), },
    -- EN3, DI1, EN4, DI2.
    Shiori   = {order = 59, branch = 'EN', C = HEX('373741'), },
    Biboo    = {order = 60, branch = 'EN', C = HEX('6e5bf4'), },
    Nerissa  = {order = 61, branch = 'EN', C = HEX('2233fb'), },
    Fuwawa   = {order = 62, branch = 'EN', C = HEX('67b2ff'), },
    Mococo   = {order = 63, branch = 'EN', C = HEX('f7a6ca'), },
    Ao       = {order = 64, branch = 'DI', C = HEX('1d3467'), },
    Kanade   = {order = 65, branch = 'DI', C = HEX('ffe7b5'), },
    Ririka   = {order = 66, branch = 'DI', C = HEX('f47da9'), },
    Raden    = {order = 67, branch = 'DI', C = HEX('3c7c71'), },
    Hachime  = {order = 68, branch = 'DI', C = HEX('b6b9ff'), },
    Elizabeth= {order = 69, branch = 'EN', C = HEX('c63639'), },
    Gigi     = {order = 70, branch = 'EN', C = HEX('feb543'), },
    Ceci     = {order = 71, branch = 'EN', C = HEX('109d5b'), },
    Raora    = {order = 72, branch = 'EN', C = HEX('f086aa'), },
    Riona    = {order = 73, branch = 'DI', C = HEX('c92655'), },
    Niko     = {order = 74, branch = 'DI', C = HEX('f25e11'), },
    Suu      = {order = 75, branch = 'DI', C = HEX('71e5ff'), },
    Chihaya  = {order = 76, branch = 'DI', C = HEX('37baba'), },
    Vivi     = {order = 77, branch = 'DI', C = HEX('ff90cc'), },

}

Holo.memberlist = {}

for memb_name,memb_data in pairs(Holo.Members)do
    memb_data.gens={}
    for gen_key, gen_data in pairs(Holo.Generations)do
        for _,_memb_name in ipairs(gen_data.members)do
            if memb_name==_memb_name then
                memb_data.gens[#memb_data.gens+1] = gen_key
                if not (memb_name=="Fubuki" and gen_key=="gen_Gamers")then
                    Holo.Branches[gen_data.branch].members[#Holo.Branches[gen_data.branch].members+1] = memb_name
                end
                break
            end
        end
    end

    Holo.memberlist[memb_data.order] = memb_name
    Holo.C[memb_name] = memb_data.C

    -- 
end

local hl_loc_colour = loc_colour
function loc_colour(_c, _default)
    if Holo.C[_c] then return Holo.C[_c] end
    return hl_loc_colour(_c, _default)
end

Holo.H_Pool = {
    Fans = {},
    Mascots = {},
    Memes = {},
    Songs = {},
    Relics = {},
    Collabs = {},
    Others = {}
}

Holo.MemberJokerPools = {}
for _,member in ipairs(Holo.memberlist)do
    Holo.MemberJokerPools[member] = {}
end

function Holo.get_members(_set)
    if Holo.Branches[_set] then
        return Holo.Branches[_set].members
    elseif Holo.Generations[_set] then
        return Holo.Generations[_set].members
    end
end

function Holo.get_branch(member)
    return Holo.Members[member].branch
end
function Holo.get_gens(member)
    return Holo.Members[member].gens
end

function Holo.get_genmates(member)
    local genmates = {}
    for _,_gen_key in ipairs(Holo.Members[member].gens)do
        for _,_member in ipairs(Holo.Generations[_gen_key].members)do
            if _member ~= member then
                genmates[#genmates+1] = _member
            end
        end
    end
    return genmates
end

Holo.badge_colours = {
    -- JP012G.
    Sora     = { back = Holo.C.Sora     , text = HEX('fcc80d')},
    Roboco   = { back = Holo.C.Roboco   , text = HEX('a90005')},
    Suisei   = { back = Holo.C.Suisei   , text = HEX('454a93')},
    Mel      = { back = Holo.C.Mel      , text = HEX('ff7709')},
    Fubuki   = { back = Holo.C.Fubuki   , text = HEX('fdfdfd')},
    Matsuri  = { back = Holo.C.Matsuri  , text = HEX('a4d243')},
    Aki      = { back = Holo.C.Aki      , text = HEX('90fb3a')},
    Haato    = { back = Holo.C.Haato    , text = HEX('ffe3ae')},
    Miko     = { back = Holo.C.Miko     , text = HEX('ff4b74')},
    Aqua     = { back = Holo.C.Aqua     , text = HEX('aeebff')},
    Shion    = { back = Holo.C.Shion    , text = HEX('403d50')},
    Ayame    = { back = Holo.C.Ayame    , text = HEX('f0eaea')},
    Choco    = { back = Holo.C.Choco    , text = HEX('ffe1d8')},
    Subaru   = { back = Holo.C.Subaru   , text = HEX('e74a22')},
    AZKi     = { back = Holo.C.AZKi     , text = HEX('fdfdfd')},
    Mio      = { text = Holo.C.Mio      , back = HEX('353232')},
    Okayu    = { back = Holo.C.Okayu    , text = HEX('d6c0e0')},
    Korone   = { back = Holo.C.Korone   , text = HEX('a7492f')},
    -- JP34, ID1, JP5.
    Pekora   = { back = Holo.C.Pekora   , text = HEX('ffac4c')},
    Rushia   = { back = Holo.C.Rushia   , text = HEX('255073')},
    Flare    = { back = Holo.C.Flare    , text = HEX('ffd081')},
    Noel     = { back = Holo.C.Noel     , text = HEX('2b3e5c')},
    Marine   = { back = Holo.C.Marine   , text = HEX('ffd765')},
    Kanata   = { back = Holo.C.Kanata   , text = HEX('f3fbfe')},
    Coco     = { back = Holo.C.Coco     , text = HEX('843057')},
    Watame   = { back = Holo.C.Watame   , text = HEX('6e675d')},
    Towa     = { back = Holo.C.Towa     , text = HEX('edff36')},
    Luna     = { back = Holo.C.Luna     , text = HEX('fdfdfd')},
    Risu     = { back = Holo.C.Risu     , text = HEX('ad6e4f')},
    Moona    = { back = Holo.C.Moona    , text = HEX('e7d28e')},
    Iofi     = { back = Holo.C.Iofi     , text = HEX('fceceb')},
    Lamy     = { back = Holo.C.Lamy     , text = HEX('fdfdfd')},
    Nene     = { back = Holo.C.Nene     , text = HEX('603b27')},
    Botan    = { back = Holo.C.Botan    , text = HEX('383743')},
    Aloe     = { back = Holo.C.Aloe     , text = HEX('b0429c')},
    Polka    = { back = Holo.C.Polka    , text = HEX('f8ed9e')},
    -- EN1, ID2, EN2, JPX, ID3.
    Calli    = { back = Holo.C.Calli    , text = HEX('f493a4')},
    Kiara    = { back = Holo.C.Kiara    , text = HEX('67ebc9')},
    Ina      = { back = Holo.C.Ina      , text = HEX('f3a35f')},
    Gura     = { back = Holo.C.Gura     , text = HEX('83c5e5')},
    Ame      = { back = Holo.C.Ame      , text = HEX('a56d6e')},
    Ollie    = { back = Holo.C.Ollie    , text = HEX('d1c6ca')},
    Anya     = { text = Holo.C.Anya     , back = HEX('9c8285')},
    Reine    = { back = Holo.C.Reine    , text = HEX('eee1e8')},
    IRyS     = { back = Holo.C.IRyS     , text = HEX('fdfdfd')},
    Sana     = { back = Holo.C.Sana     , text = HEX('ff4baf')},
    Fauna    = { back = Holo.C.Fauna    , text = HEX('ffff72')},
    Kronii   = { back = Holo.C.Kronii   , text = HEX('5c607a')},
    Mumei    = { back = Holo.C.Mumei    , text = HEX('4799a5')},
    Bae      = { back = Holo.C.Bae      , text = HEX('f3f7fa')},
    Laplus   = { back = Holo.C.Laplus   , text = HEX('936cc6')},
    Lui      = { back = Holo.C.Lui      , text = HEX('ea9c9c')},
    Koyori   = { back = Holo.C.Koyori   , text = HEX('fef9f3')},
    Chloe    = { back = Holo.C.Chloe    , text = HEX('fef9f3')},
    Iroha    = { back = Holo.C.Iroha    , text = HEX('fadeaf')},
    Zeta     = { back = Holo.C.Zeta     , text = HEX('6073b5')},
    Kaela    = { back = Holo.C.Kaela    , text = HEX('ec9948')},
    Kobo     = { back = Holo.C.Kobo     , text = HEX('161c4f')},
    -- EN3, DI1, EN4, DI2.
    Shiori   = { back = Holo.C.Shiori   , text = HEX('b8a0cd')},
    Biboo    = { back = Holo.C.Biboo    , text = HEX('fc74ff')},
    Nerissa  = { text = Holo.C.Nerissa  , back = HEX('272627')},
    Fuwawa   = { back = Holo.C.Fuwawa   , text = Holo.C.Mococo},
    Mococo   = { back = Holo.C.Mococo   , text = Holo.C.Fuwawa},
    Ao       = { back = Holo.C.Ao       , text = HEX('aaa6a7')},
    Kanade   = { back = Holo.C.Kanade   , text = HEX('c93442')},
    Ririka   = { back = Holo.C.Ririka   , text = HEX('fdcc90')},
    Raden    = { back = Holo.C.Raden    , text = HEX('222024')},
    Hachime  = { back = Holo.C.Hachime  , text = HEX('f7ede5')},
    Elizabeth= { back = Holo.C.Elizabeth, text = HEX('50d5ff')},
    Gigi     = { back = Holo.C.Gigi     , text = HEX('3d1f0d')},
    Ceci     = { back = Holo.C.Ceci     , text = HEX('e5c49e')},
    Raora    = { back = Holo.C.Raora    , text = HEX('9fe7ff')},
    Riona    = { back = Holo.C.Riona    , text = HEX('c3bdbd')},
    Niko     = { back = Holo.C.Niko     , text = HEX('5c5c5c')},
    Suu      = { back = Holo.C.Suu      , text = HEX('6079b4')},
    Chihaya  = { back = Holo.C.Chihaya  , text = HEX('d7d7d7')},
    Vivi     = { back = Holo.C.Vivi     , text = HEX('7f72aa')},
}

Holo.type_colour = {
    Mascot = Holo.C.Hololive,

    Meme = Holo.C.Hololive_bright,

    Song = Holo.C.Hololive_dark,
    Unit = Holo.C.Hololive_dark,
    Collab = Holo.C.Hololive_dark,
}

function Holo.set_type_badge(card, badges, type)
    if type==nil then return end
    badges[#badges+1] = create_badge(type, Holo.type_colour[type], G.C.WHITE, 1 )
end

function Holo.set_member_badges(card, badges, member)
    member = member or card.config.center.member
    if member == nil then return end
    if Holo.Members[member] == nil then return end

    -- Member
    local member_name = localize('k_hololive_fullname_table')[member]
    local member_badge_colour = Holo.badge_colours[member] or {back = G.C.WHITE, text = Holo.C.Hololive}
    badges[#badges+1] = create_badge(member_name, member_badge_colour.back, member_badge_colour.text, 1.2 )
    if member == 'Haato' then
        local nickname = localize('k_hololive_fullname_table')['Haachama']
        badges[#badges+1] = create_badge(nickname, member_badge_colour.back, member_badge_colour.text, 1.2 )
    end

    -- Branch-Generation
    local _branch = Holo.Members[member].branch
    for _,gen_key in ipairs(Holo.Members[member].gens)do
        local gen_text = Holo.Branches[_branch].name..' '..localize('k_hololive_'..gen_key)
        badges[#badges+1] = create_badge(gen_text, G.C.WHITE, Holo.C[_branch], 0.9 )
    end
end

Holo.birthday_chart = {
    -- January
    ['0106'] = 'Ame',
    ['0112'] = 'Pekora',
    ['0115'] = 'Risu',
    ['0122'] = 'Rushia',
    --['0130'] = 'Polka',
    -- Febuary
    ['0201'] = 'Fuwawa',
    ['0202'] = 'Mococo',
    --['0204'] = 'Raden',
    ['0214'] = 'Choco',
    ['0215'] = 'Moona',
    ['0217'] = 'Aki',
    ['0222'] = 'Okayu',
    --['0227'] = 'Ao',
    ['0229'] = 'Bae',
    -- March
    --['0302'] = 'Nene',
    ['0305'] = 'Miko',
    ['0307'] = 'IRyS',
    --['0312'] = 'Anya',
    ['0314'] = 'Kronii',
    ['0315'] = 'Koyori',
    ['0321'] = 'Fauna',
    ['0322'] = 'Suisei',
    -- April
    ['0402'] = 'Flare',
    ['0404'] = 'Calli',
    ['0414'] = 'Biboo',
    --['0420'] = 'Kanade',
    --['0422'] = 'Kanata',
    ['0425'] = 'Elizabeth',
    -- May
    ['0502'] = 'Shiori',
    ['0511'] = 'Raora',
    --['0512'] = 'Ririka',
    ['0515'] = 'Sora',
    ['0518'] = 'Chloe',
    ['0520'] = 'Ina',
    ['0523'] = 'Roboco',
    ['0525'] = 'Laplus',
    --['0529'] = 'Riona',
    -- June
    --['0606'] = 'Watame',
    --['0607'] = 'Hajime',
    ['0610'] = 'Sana',
    ['0611'] = 'Lui',
    --['0616'] = 'Suu',
    --['0617'] = 'Coco',
    ['0618'] = 'Iroha',
    ['0620'] = 'Gura',
    -- July
    ['0701'] = 'AZKi',
    ['0702'] = 'Subaru',
    ['0706'] = 'Kiara',
    --['0708'] = 'Chihaya',
    ['0715'] = 'Iofi',
    ['0722'] = 'Matsuri',
    --['0725'] = 'Niko',
    ['0730'] = 'Marine',
    -- August
    ['0804'] = 'Mumei',
    --['0808'] = 'Towa',
    ['0810'] = 'Haato',
    ['0820'] = 'Mio',
    --['0827'] = 'Vivi',
    --['0830'] = 'Kaela',
    -- September
    --['0908'] = 'Botan',
    --['0909'] = 'Reine',
    -- October
    ['1001'] = 'Korone',
    ['1005'] = 'Fubuki',
    --['1010'] = 'Luna',
    --['1013'] = 'Ollie',
    ['1018'] = 'Gigi',
    --['1028'] = 'Aloe',
    ['1031'] = 'Mel',
    -- November
    --['1107'] = 'Zeta',
    ['1111'] = 'Ceci',
    --['1115'] = 'Lamy',
    ['1121'] = 'Nerissa',
    ['1124'] = 'Noel',
    -- December
    ['1201'] = 'Aqua',
    ['1208'] = 'Shion',
    --['1212'] = 'Kobo',
    ['1213'] = 'Ayame',
}

Holo.call_and_response_chart = {

    Flare = 'Ina',
    Noel = 'Subaru',

    --Calli = 'Suisei',
    --Kiara = 'Pekora',
    --Ina = 'Suisei',
    --Bae = 'Subaru',
    Laplus = 'Towa',
    Lui = 'Marine',
    --Koyori = 'Miko', -- Or is it Pekora? I'm very confused.
    Chloe = 'Shion',
    Iroha = 'Suisei',

    Nerissa = 'Kiara', -- and Marine
    Raden = 'Aki',
    Riona = 'Calli', -- and Luna
    Niko = 'Lui',
    Suu = 'Subaru',
}

Holo.Atlas_7195 = SMODS.Atlas:extend{px=71,py=95}

Holo.local_text = {}
function Holo.local_text.current_xmult(var_index)
    var_index = var_index or 1
    return '{C:inactive}(Currently {X:mult,C:white}X#'..var_index..'#{C:inactive} Mult)'
end
function Holo.local_text.if_no_room(var_index)
    if var_index then
        return '(If no room, accumulate them {C:inactive}[#'..var_index..'#]{} until there is.)'
    end
    return '(If no room, accumulate them until there is.)'
end
function Holo.local_text.consumeable(consumeable_key)
    local consumeable_set = G.P_CENTERS[consumeable_key].set
    local consumeable_loc_colours = {Tarot='tarot',Planet='planet',Spectral='spectral'}
    local consumeable_name = localize({key=consumeable_key, set=consumeable_set, type='name_text'})
    return '{C:'..(consumeable_loc_colours[consumeable_set]or'')..'}'..consumeable_name..'{}'
end
