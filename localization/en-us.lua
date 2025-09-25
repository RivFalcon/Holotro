local fullname = {
    Sora = "Tokino Sora",
    Roboco = "Roboco",
    Suisei = "Hoshimachi Suisei",
    Mel = "Yozora Mel",
    Fubuki = "Shirakami Fubuki",
    Matsuri = "Natsuiro Matsuri",
    Aki = "Aki Rosenthal",
    Haato = "Akai Haato", Haachama = "Haachama",
    Miko = "Sakura Miko",
    Aqua = "Minato Aqua",
    Shion = "Murasaki Shion",
    Ayame = "Nagiri Ayame",
    Choco = "Yuzuki Choco",
    Subaru = "Oozora Subaru",
    AZKi = "AZKi",
    Mio = "Ookami Mio",
    Okayu = "Nekomata Okayu",
    Korone = "Inugami Korone",

    Pekora = "Usada Pekora",
    Rushia = "Uruha Rushia",
    Flare = "Shiranui Flare",
    Noel = "Shirogane Noel",
    Marine = "Houshou Marine",
    Kanata = "Amane Kanata",
    Coco = "Kiryu Coco",
    Watame = "Tsunomaki Watame",
    Towa = "Tokoyami Towa",
    Luna = "Himemori Luna",
    Risu = "Ayunda Risu",
    Moona = "Moona Hoshinova",
    Iofi = "Airani Iofifteen",
    Lamy = "Yukihana Lamy",
    Nene = "Momosuzu Nene",
    Botan = "Shishiro Botan",
    Aloe = "Mano Aloe",
    Polka = "Omaru Polka",

    Calli = "Mori Calliope",
    Kiara = "Takanashi Kiara",
    Ina = "Ninomae Ina'nis",
    Gura = "Gawr Gura",
    Ame = "Watson Amelia",
    Ollie = "Kureiji Ollie",
    Anya = "Anya Melfissa",
    Reine = "Pavolia Reine",
    IRyS = "IRyS",
    Sana = "Tsukumo Sana",
    Fauna = "Ceres Fauna",
    Kronii = "Ouro Kronii",
    Mumei = "Nanashi Mumei",
    Bae = "Hakos Baelz",
    Laplus = "La+ Darknesss",
    Lui = "Takane Lui",
    Koyori = "Hakui Koyori",
    Chloe = "Sakamata Chloe",
    Iroha = "Kazama Iroha",
    Zeta = "Vestia Zeta",
    Kaela = "Kaela Kovalskia",
    Kobo = "Kobo Kanaeru",

    Shiori = "Shiori Novella",
    Biboo = "Koseki Bijou",
    Nerissa = "Nerissa Ravencroft",
    Fuwawa = "Fuwawa Abyssgard",
    Mococo = "Mococo Abyssgard",
    Ao = "Hiodoshi Ao",
    Kanade = "Otonose Kanade",
    Ririka = "Ichijou Ririka",
    Raden = "Juufuutei Raden",
    Hajime = "Todoroki Hajime",
    Elizabeth = "Elizabeth Rose Bloodflame",
    Gigi = "Gigi Murin",
    Ceci = "Cecilia Immergreen",
    Raora = "Raora Panthera",
    Riona = "Isaki Riona",
    Niko = "Koganei Niko",
    Suu = "Mizumiya Su",
    Chihaya = "Rindo Chihaya",
    Vivi = "Kikirara Vivi",

}

local relicgacha_text={
    "Creates a",
    "{V:1,E:1}#1# Relic",
    "{C:inactive}(Must have room)",
}

return {
    descriptions={
        Other={
            --- Gen Members ---
            hololive_gen_origin={
                name="Hololive 0th Generation",
                text={
                    fullname.Sora,
                    fullname.Roboco,
                    fullname.Suisei,
                    fullname.Miko,
                    fullname.AZKi
                }
            },
            hololive_gen_first={
                name="Hololive 1st Generation",
                text={
                    fullname.Mel,
                    fullname.Fubuki,
                    fullname.Matsuri,
                    fullname.Aki,
                    fullname.Haato
                }
            },
            hololive_gen_exodia={
                name="Hololive 2nd Generation",
                text={
                    fullname.Aqua,
                    fullname.Shion,
                    fullname.Ayame,
                    fullname.Choco,
                    fullname.Subaru
                }
            },
            hololive_gen_gamers={
                name="hololive Gamers",
                text={
                    fullname.Fubuki,
                    fullname.Mio,
                    fullname.Okayu,
                    fullname.Korone
                }
            },
            hololive_gen_fantasy={
                name="Hololive 3rd Generation: Fantasy",
                text={
                    fullname.Pekora,
                    "{C:inactive}"..fullname.Rushia,
                    fullname.Flare,
                    fullname.Noel,
                    fullname.Marine
                }
            },
            hololive_gen_force={
                name="Hololive 4th Generation: Force",
                text={
                    fullname.Kanata,
                    fullname.Coco,
                    fullname.Watame,
                    fullname.Towa,
                    fullname.Luna
                }
            },
            hololive_gen_area15={
                name="Hololive Indonesia 1st Generation -Area 15-",
                text={
                    fullname.Risu,
                    fullname.Moona,
                    fullname.Iofi
                }
            },
            hololive_gen_nplab={
                name="Hololive 5th Generation: NePoLABo",
                text={
                    fullname.Lamy,
                    fullname.Nene,
                    fullname.Botan,
                    fullname.Aloe,
                    fullname.Polka
                }
            },
            hololive_gen_myth={
                name="Hololive English -Myth-",
                text={
                    fullname.Calli,
                    fullname.Kiara,
                    fullname.Ina,
                    fullname.Gura,
                    fullname.Ame
                }
            },
            hololive_gen_holoro={
                name="Hololive Indonesia 2nd Generation -Holoro-",
                text={
                    fullname.Ollie,
                    fullname.Anya,
                    fullname.Reine
                }
            },
            hololive_gen_promise={
                name="Hololive English -Promise-",
                text={
                    fullname.IRyS,
                    fullname.Sana,
                    fullname.Fauna,
                    fullname.Kronii,
                    fullname.Mumei,
                    fullname.Bae
                }
            },
            hololive_gen_holox={
                name="Hololive 6th Generation: holoX",
                text={
                    fullname.Laplus,
                    fullname.Lui,
                    fullname.Koyori,
                    fullname.Chloe,
                    fullname.Iroha
                }
            },
            hololive_gen_holoh3ro={
                name="Hololive Indonesia 3rd Generation -HoloH3ro-",
                text={
                    fullname.Zeta,
                    fullname.Kaela,
                    fullname.Kobo
                }
            },
            hololive_gen_advent={
                name="Hololive English -Advent-",
                text={
                    fullname.Shiori,
                    fullname.Biboo,
                    fullname.Nerissa,
                    fullname.Fuwawa,
                    fullname.Mococo
                }
            },
            hololive_gen_regloss={
                name="Hololive DEV_IS: ReGLOSS",
                text={
                    fullname.Ao,
                    fullname.Kanade,
                    fullname.Ririka,
                    fullname.Raden,
                    fullname.Hajime
                }
            },
            hololive_gen_justice={
                name="Hololive English -Justice-",
                text={
                    fullname.Elizabeth,
                    fullname.Gigi,
                    fullname.Ceci,
                    fullname.Raora
                }
            },
            hololive_gen_flowglow={
                name="Hololive DEV_IS: FLOW GLOW",
                text={
                    fullname.Riona,
                    fullname.Niko,
                    fullname.Suu,
                    fullname.Chihaya,
                    fullname.Vivi
                }
            },
            ---

            --- Info tips ---
            holo_info_english_speaking_members={
                name="English Speaking Members",
                text={
                    "All of EN and ID,",
                    fullname.Haato..",",
                    fullname.Coco..",",
                    fullname.Ririka..".",
                }
            },
            holo_info_even={
                name="Even Ranks",
                text={
                    " 10, 8, 6, 4, 2. ",
                }
            },
            holo_info_odd={
                name="Odd Ranks",
                text={
                    " A, 9, 7, 5, 3. ",
                }
            },
            holo_info_forbiddenSpectrals={
                name=" ! Notice ! ",
                text={
                    'If you see some {C:dark_edition}forbidden {C:spectral}Spectrals{},',
                    'no, they are intentional features.'
                }
            },
            holo_info_rat_index={
                name="Rat Index",
                text={
                    'Probability Multiplier.',
                    '{C:inactive}(Currently {C:green}X#1# {C:inactive}Chance)'
                }
            }
        },
    },
    misc={
        dictionary={
            ---- Branches
            k_hololive_branch_jp="Japan",
            k_hololive_branch_id="Indonesia",
            k_hololive_branch_en="English",
            k_hololive_branch_di="DEV_IS",

            ---- Generations
            k_hololive_gen_origin="0th Generation",
            k_hololive_gen_first="1st Generation",
            k_hololive_gen_exodia="2nd Generation",
            k_hololive_gen_gamers="Gamers",
            k_hololive_gen_fantasy="3rd Generation: Fantasy",
            k_hololive_gen_force="4th Generation: Force",
            k_hololive_gen_area15="-Area 15-",
            k_hololive_gen_nplab="5th Generation",
            k_hololive_gen_myth="-Myth-",
            k_hololive_gen_holoro="-Holoro-",
            k_hololive_gen_promise="-Promise-",
            k_hololive_gen_holox="Secret Society holoX",
            k_hololive_gen_holoh3ro="-HoloH3ro-",
            k_hololive_gen_advent="-Advent-",
            k_hololive_gen_regloss="ReGLOSS",
            k_hololive_gen_justice="-Justice-",
            k_hololive_gen_flowglow="FLOW GLOW",

            ---- Full Name Table
            k_hololive_fullname_table=fullname,

            ---- Badge Texts ----
            k_hololive_fan="Fan",
            k_hololive_mascot="Mascot",
            k_hololive_relic="Relic",
            k_hololive_song="Original Song",

            ---- Localized Messages/Texts
            k_hololive_moon_full="Full Moon",
            k_hololive_moon_new="New Moon",

            ph_hololive_necromancy="Saved by Necromancy",
        },
        labels={
            ---- Seal Badges
            hololive_geopin_seal="Geo-Pin Seal",

            ---- Sticker Badges
            hololive_kapumark="Yozora Vampirism",
            hololive_handcuff="Oozora Police Station",
            hololive_potion_red  ="Hakui Chemicals",
            hololive_potion_cyan ="Hakui Chemicals",
            hololive_potion_pink ="Hakui Chemicals",
            hololive_potion_green="Hakui Chemicals",
            hololive_potion_gold ="Hakui Chemicals",
            hololive_potion_blue ="Hakui Chemicals",
            hololive_durable = "Immergreen Workshop",

            ---- Rarity Badges
            k_hololive_fan="Fan",
            k_hololive_mascot="Mascot",
            k_hololive_relic="Relic",
            k_hololive_song="Original Song",
        }
    },
}
