----

SMODS.current_mod.config_tab = function()
    local config_nodes = {
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
        })
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
                                            text = "Playtester:",
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
                                            text = "    TRGreninja",
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
                                        align = 'tm',
                                    },
                                    nodes = {{
                                        n = G.UIT.T,
                                        config = {
                                            text = "All characters belongs to Cover Corp.",
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