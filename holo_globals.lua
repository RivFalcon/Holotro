--Class
Live = Object:extend()
Holo = Live()

--Class Methods
function Live:init()
    Holo = self
    Holo:init_global_vars()
end

function Live:init_global_vars()
    self.C = {Hololive = HEX('33C9FE'),}
    self.Branches = {
        JP = {order = 1, name = 'hololive', gens={},members={}, C = self.C.Hololive, },
        ID = {order = 2, name = 'INDONESIA',gens={},members={}, C = HEX('ff7c4d'), },
        EN = {order = 3, name = 'ENGLISH',  gens={},members={}, C = HEX('c283b6'), },
        DI = {order = 4, name = 'DEV_IS',   gens={},members={}, C = HEX('010101'), },
    }
    for branch_name,branch_data in pairs(self.Branches)do
        self.C[branch_name] = branch_data.C
    end
    self.Generations = {
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
    for gen_key, gen_data in pairs(self.Generations) do
        self.Branches[gen_data.branch].gens[#self.Branches[gen_data.branch].gens+1] = gen_key
        
        if type(gen_data.C) == 'table' then
            self.C[gen_key] = {back=G.C.WHITE,text=self.C.Hololive}
            if gen_data.C.back then
                self.C[gen_key].back = gen_data.C.back
            end
            if gen_data.C.text then
                self.C[gen_key].text = gen_data.C.text
            end
        end
    end

    self.Units = {
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

    self.Members = {

        Sora     = {order =  1, },
        Roboco   = {order =  2, },
        Suisei   = {order =  3, },
        Mel      = {order =  4, },
        Fubuki   = {order =  5, },
        Matsuri  = {order =  6, },
        Aki      = {order =  7, },
        Haato    = {order =  8, },
        Miko     = {order =  9, },
        Aqua     = {order = 10, },
        Shion    = {order = 11, },
        Ayame    = {order = 12, },
        Choco    = {order = 13, },
        Subaru   = {order = 14, },
        AZKi     = {order = 15, },
        Mio      = {order = 16, },
        Okayu    = {order = 17, },
        Korone   = {order = 18, },

        Pekora   = {order = 19, C = HEX('7dc4fc'), },
        Rushia   = {order = 20, C = HEX('04e3cb'), },
        Flare    = {order = 21, C = HEX('ff5028'), },
        Noel     = {order = 22, C = HEX('aebbc3'), },
        Marine   = {order = 23, C = HEX('923749'), },
        Kanata   = {order = 24, },
        Coco     = {order = 25, },
        Watame   = {order = 26, },
        Towa     = {order = 27, },
        Luna     = {order = 28, },
        Risu     = {order = 29, C = HEX('ef8381'), },
        Moona    = {order = 30, C = HEX('cbb3ff'), },
        Iofi     = {order = 31, C = HEX('bef167'), },
        Lamy     = {order = 32, },
        Nene     = {order = 33, },
        Botan    = {order = 34, },
        Aloe     = {order = 35, },
        Polka    = {order = 36, },

        Calli    = {order = 37, C = HEX('a1020b'), },
        Kiara    = {order = 38, C = HEX('dc3907'), },
        Ina      = {order = 39, C = HEX('3f3e69'), },
        Gura     = {order = 40, C = HEX('5d81c7'), },
        Ame      = {order = 41, C = HEX('f8db92'), },
        Ollie    = {order = 42, },
        Anya     = {order = 43, },
        Reine    = {order = 44, },
        IRyS     = {order = 45, C = HEX('3c0024'), },
        Sana     = {order = 46, C = HEX('fede4a'), },
        Fauna    = {order = 47, C = HEX('a4e5cf'), },
        Kronii   = {order = 48, C = HEX('0869ec'), },
        Mumei    = {order = 49, C = HEX('998274'), },
        Bae      = {order = 50, C = HEX('d2251e'), },
        Laplus   = {order = 51, },
        Lui      = {order = 52, },
        Koyori   = {order = 53, },
        Chloe    = {order = 54, },
        Iroha    = {order = 55, },
        Zeta     = {order = 56, },
        Kaela    = {order = 57, },
        Kobo     = {order = 58, },

        Shiori   = {order = 59, C = HEX('373741'), },
        Biboo    = {order = 60, C = HEX('6e5bf4'), },
        Nerissa  = {order = 61, C = HEX('2233fb'), },
        Fuwawa   = {order = 62, C = HEX('67b2ff'), },
        Mococo   = {order = 63, C = HEX('f7a6ca'), },
        Ao       = {order = 64, },
        Kanade   = {order = 65, },
        Ririka   = {order = 66, },
        Raden    = {order = 67, },
        Hachime  = {order = 68, },
        Elizabeth= {order = 69, C = HEX('c63639'), },
        Gigi     = {order = 70, C = HEX('feb543'), },
        Ceci     = {order = 71, C = HEX('109d5b'), },
        Raora    = {order = 72, C = HEX('f086aa'), },
        Riona    = {order = 73, },
        Niko     = {order = 74, },
        Suu      = {order = 75, },
        Chihaya  = {order = 76, },
        Vivi     = {order = 77, },

    }

    for memb_name,memb_data in pairs(self.Members)do
        memb_data.gens={}
        for gen_key, gen_data in pairs(self.Generations)do
            for _,_memb_name in ipairs(gen_data.members)do
                if memb_name==_memb_name then
                    memb_data.branch=gen_data.branch
                    memb_data.gens[#memb_data.gens+1] = gen_key
                    if not (memb_name=="Fubuki" and gen_key=="gen_Gamers")then
                        self.Branches[gen_data.branch].members[#self.Branches[gen_data.branch].members+1] = memb_name
                    end
                    break
                end
            end
        end

        if memb_data.C ~= nil then self.C[memb_name] = memb_data.C end

        -- 
    end

    self:inject_loc_colour()
end

function Live:get_members(_set)
    if self.Branches[_set] then
        return self.Branches[_set].members
    elseif self.Generations[_set] then
        return self.Generations[_set].members
    end
end

function Live:get_branch(member)
    return self.Members[member].branch
end
function Live:get_gens(member)
    return self.Members[member].gens
end

function Live:get_genmates(member)
    local genmates = {}
    for _,_gen_key in ipairs(self.Members[member].gens)do
        for _,_member in ipairs(self.Generations[_gen_key].members)do
            if _member ~= member then
                genmates[#genmates+1] = _member
            end
        end
    end
    return genmates
end

function Live:inject_loc_colour()
    local hl_loc_colour = loc_colour
    function loc_colour(_c, _default)
        if Holo.C[_c] then return Holo.C[_c] end
        return hl_loc_colour(_c, _default)
    end
end
