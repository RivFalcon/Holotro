----

SMODS.current_mod.config_tab = function()
	return {
        n = G.UIT.ROOT,
        config = {
	    },
        nodes = {
        }
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
                            },
                            nodes = {
                                {
                                    n = G.UIT.R,
                                    config = {
                                        padding = 0.3
                                    },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Main Author:",
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.7
                                            }
                                        },
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Riv_Falcon",
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.7
                                            }
                                        },
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        padding = 0.3
                                    },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Playtester:",
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.7
                                            }
                                        },
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Greninja",
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.7
                                            }
                                        },
                                    }
                                },
                                {
                                    n = G.UIT.R,
                                    config = {
                                        padding = 0.3
                                    },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "",
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 1
                                            }
                                        },
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "All character rights belongs to Cover Corp.",
                                                -- Is this the correct wording?
                                                colour = G.C.UI.TEXT_LIGHT,
                                                scale = 0.5
                                            }
                                        },
                                    }
                                },
                            }
                        },
                    }
                }
            end
        }
    }
end