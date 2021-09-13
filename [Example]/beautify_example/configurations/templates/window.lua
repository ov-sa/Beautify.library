----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: configurations: templates: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_window"] = {

    ["dark-silver-theme"] = {},

    ["dark-blue-theme"] = {
        color = {6, 6, 6, 253},
        titleBar = {
            fontColor = {158, 158, 255, 255},
            color = {6, 6, 6, 255},
            divider = {
                color = {158, 158, 255, 150}
            },
            closeButton = {
                fontColor = {158, 158, 255, 255},
                hoverColor = {158, 158, 255, 255},
                hoverFontColor = {6, 6, 6, 255}
            }
        }
    },

    ["dark-red-theme"] = {
        color = {6, 6, 6, 253},
        titleBar = {
            fontColor = {255, 158, 158, 255},
            color = {6, 6, 6, 255},
            divider = {
                color = {255, 158, 158, 150}
            },
            closeButton = {
                fontColor = {255, 158, 158, 255},
                hoverColor = {255, 158, 158, 255},
                hoverFontColor = {6, 6, 6, 255}
            }
        }
    },

    ["dark-green-theme"] = {
        color = {6, 6, 6, 253},
        titleBar = {
            fontColor = {158, 255, 158, 255},
            color = {6, 6, 6, 255},
            divider = {
                color = {158, 255, 158, 150}
            },
            closeButton = {
                fontColor = {158, 255, 158, 255},
                hoverColor = {158, 255, 158, 255},
                hoverFontColor = {6, 6, 6, 255}
            }
        }
    },

    ["dark-yellow-theme"] = {
        color = {6, 6, 6, 253},
        titleBar = {
            fontColor = {255, 255, 158, 255},
            color = {6, 6, 6, 255},
            divider = {
                color = {255, 255, 158, 150}
            },
            closeButton = {
                fontColor = {255, 255, 158, 255},
                hoverColor = {255, 255, 158, 255},
                hoverFontColor = {6, 6, 6, 255}
            }
        }
    }

}