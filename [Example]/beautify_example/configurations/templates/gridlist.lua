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
        color = {20, 20, 20, 253},
        columnBar = {
            color = {158, 158, 255, 255},
            fontColor = {6, 6, 6, 255},
            divider = {
                color = {20, 20, 20, 253}
            }
        },
        rowBar = {
            color = {6, 6, 6, 255},
            fontColor = {136, 136, 255, 255},
            hoverColor = {136, 136, 255, 255},
            hoverFontColor = {6, 6, 6, 255}
        }
    },

    ["dark-red-theme"] = {
        color = {20, 20, 20, 253},
        columnBar = {
            color = {255, 158, 158, 255},
            fontColor = {6, 6, 6, 255},
            divider = {
                color = {20, 20, 20, 253}
            }
        },
        rowBar = {
            color = {6, 6, 6, 255},
            fontColor = {255, 136, 136, 255},
            hoverColor = {255, 136, 136, 255},
            hoverFontColor = {6, 6, 6, 255}
        }
    },

    ["dark-green-theme"] = {
        color = {20, 20, 20, 253},
        columnBar = {
            color = {158, 255, 158, 255},
            fontColor = {6, 6, 6, 255},
            divider = {
                color = {20, 20, 20, 253}
            }
        },
        rowBar = {
            color = {6, 6, 6, 255},
            fontColor = {136, 255, 136, 255},
            hoverColor = {136, 255, 136, 255},
            hoverFontColor = {6, 6, 6, 255}
        }
    },

    ["dark-yellow-theme"] = {
        color = {20, 20, 20, 253},
        columnBar = {
            color = {255, 255, 158, 255},
            fontColor = {6, 6, 6, 255},
            divider = {
                color = {20, 20, 20, 253}
            }
        },
        rowBar = {
            color = {6, 6, 6, 255},
            fontColor = {255, 255, 136, 255},
            hoverColor = {255, 255, 136, 255},
            hoverFontColor = {6, 6, 6, 255}
        }
    }

}