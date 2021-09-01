----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: configurations: templates: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_gridlist"] = {

    ["dark-silver-theme"] = {},

    ["dark-blue-theme"] = {
        color = {5, 5, 5, 253},
        columnBar = {
            color = {125, 125, 255, 255},
            fontColor = {0, 0, 0, 255},
            divider = {
                color = {5, 5, 5, 253}
            }
        },
        rowBar = {
            color = {0, 0, 0, 255},
            fontColor = {100, 100, 255, 255},
            hoverColor = {100, 100, 255, 255},
            hoverFontColor = {0, 0, 0, 255}
        }
    },

    ["dark-red-theme"] = {
        color = {5, 5, 5, 253},
        columnBar = {
            color = {255, 125, 125, 255},
            fontColor = {0, 0, 0, 255},
            divider = {
                color = {5, 5, 5, 253}
            }
        },
        rowBar = {
            color = {0, 0, 0, 255},
            fontColor = {255, 100, 100, 255},
            hoverColor = {255, 100, 100, 255},
            hoverFontColor = {0, 0, 0, 255}
        }
    },

    ["dark-green-theme"] = {
        color = {5, 5, 5, 253},
        columnBar = {
            color = {125, 255, 125, 255},
            fontColor = {0, 0, 0, 255},
            divider = {
                color = {5, 5, 5, 253}
            }
        },
        rowBar = {
            color = {0, 0, 0, 255},
            fontColor = {100, 255, 100, 255},
            hoverColor = {100, 255, 100, 255},
            hoverFontColor = {0, 0, 0, 255}
        }
    },

    ["dark-yellow-theme"] = {
        color = {5, 5, 5, 253},
        columnBar = {
            color = {255, 255, 125, 255},
            fontColor = {0, 0, 0, 255},
            divider = {
                color = {5, 5, 5, 253}
            }
        },
        rowBar = {
            color = {0, 0, 0, 255},
            fontColor = {255, 255, 100, 255},
            hoverColor = {255, 255, 100, 255},
            hoverFontColor = {0, 0, 0, 255}
        }
    }

}