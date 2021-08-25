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

    ["dark-blue-theme"] = {
        color = {0, 0, 0, 253},
        titleBar = {
            fontColor = {125, 125, 255, 255},
            color = {0, 0, 0, 255},
            divider = {
                size = 1,
                color = {125, 125, 255, 150}
            },
            closeButton = {
                fontColor = {125, 125, 255, 255},
                hoverFontColor = {0, 0, 0, 255},
                hoverColor = {125, 125, 255, 255}
            }
        }
    },

    ["dark-red-theme"] = {
        color = {0, 0, 0, 253},
        titleBar = {
            fontColor = {255, 125, 125, 255},
            color = {0, 0, 0, 255},
            divider = {
                size = 1,
                color = {255, 125, 125, 150}
            },
            closeButton = {
                fontColor = {255, 125, 125, 255},
                hoverFontColor = {0, 0, 0, 255},
                hoverColor = {255, 125, 125, 255}
            }
        }
    }

}