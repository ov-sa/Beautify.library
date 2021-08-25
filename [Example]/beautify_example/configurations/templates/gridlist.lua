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

    ["dark-blue-theme"] = {
        color = {5, 5, 5, 253},
        columnBar = {
            fontColor = {0, 0, 0, 255},
            color = {125, 125, 255, 255},
            divider = {
                size = 2,
                color = {5, 5, 5, 253}
            }
        },
        rowBar = {
            fontColor = {100, 100, 255, 255},
            color = {0, 0, 0, 255},
            hoverFontColor = {0, 0, 0, 255},
            hoverColor = {100, 100, 255, 255}
        }
    },

    ["dark-red-theme"] = {
        color = {5, 5, 5, 253},
        columnBar = {
            fontColor = {0, 0, 0, 255},
            color = {255, 125, 125, 255},
            divider = {
                size = 2,
                color = {5, 5, 5, 253}
            }
        },
        rowBar = {
            fontColor = {255, 100, 100, 255},
            color = {0, 0, 0, 255},
            hoverFontColor = {0, 0, 0, 255},
            hoverColor = {255, 100, 100, 255}
        }
    }

}