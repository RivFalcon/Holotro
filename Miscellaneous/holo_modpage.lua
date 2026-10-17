----

Holo.gacha_rate_options = {0.05,0.1,0.2}
G.FUNCS.holo_update_gacha_rate = function(arg)
    Holo.mod_config.gacha_rate = Holo.gacha_rate_options[arg.to_key]
    for _,c in ipairs(G.P_CENTER_POOLS.relicgacha) do
        c.soul_rate = Holo.mod_config.gacha_rate
    end
end

SMODS.current_mod.config_tab = function()
    local config_nodes = {
        create_option_cycle({
            label = "Gacha Rate",
            options = {
                "5% (Default)",
                "10%",
                "20%"
            },
            current_option = get_index(Holo.gacha_rate_options, Holo.mod_config.gacha_rate or 0.05) or 1,
            w = 6,
            scale = 0.8,
            text_scale = 0.5,
            opt_callback = 'holo_update_gacha_rate',
        }),
        create_toggle({
            label = "Allow Birthday Event",
            ref_table = Holo.mod_config,
            ref_value = "allow_birthday_event",
            info = {"Relics, if available, will be guaranteed on members' birthdays."},
        }),
        create_toggle({
            label = "Allow Profanity",
            ref_table = Holo.mod_config,
            ref_value = "allow_profanity",
            info = {
                "For meme purposes, some no-no words are included in this mod.",
                "Toggle this off to get alternatives/censorship."
            },
        }),
        create_toggle({
            label = "Allow \"HELL OF DOOT\"",
            ref_table = Holo.mod_config,
            ref_value = "allow_hell_of_doot",
            info = {"DO NOT TOUCH THIS unless you desperately want to experience hell."},
        }),
    }
    return {
        n = G.UIT.ROOT,
        config = {
            minh = 6,
            minw = 8,
            r = 0.2,
            align = "cm",
            padding = 0.3,
            colour = G.C.BLACK
        },
        nodes = config_nodes
    }
end

SMODS.current_mod.extra_tabs = function ()
    return {
        {
            label = 'Credits',
            tab_definition_function = function ()
                return {
                    n = G.UIT.ROOT,
                    config = {
                        align = "tm",
                        r= 0.2,
                        colour = G.C.BLACK
                    },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = {
                                padding = 0.3,
                            },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tl',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "Main Author:",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.5
                                        }
                                    }},
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tl',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "    Riv_Falcon",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.7
                                        }
                                    }},
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tl',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "Playtest Contributers:",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.5
                                        }
                                    }},
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tl',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "    TRGreninja, Minh, b2198.",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.7
                                        }
                                    }},
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tm',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = " ",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 1
                                        }
                                    }},
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tl',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "All character rights belongs to Cover Corp.",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.5
                                        }
                                    }},
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        align = 'tl',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "All memes belongs to Hololive Fandom Community.",
                                            colour = G.C.UI.TEXT_LIGHT,
                                            scale = 0.5
                                        }
                                    }},
                                },
                            }
                        },
                    }
                }
            end
        }
    }
end