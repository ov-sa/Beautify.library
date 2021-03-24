----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: template.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplate = {

    ["beautify_window"] = {
        color = {0, 0, 0, 250},
        titleBar = {
            font = DxFont("files/assets/fonts/signika_semibold.ttf", 12),
            fontColor = {80, 80, 255, 255},
            color = {0, 0, 0, 255},
            divider = {
                size = 2,
                color = {80, 80, 255, 75}
            },
            close_button = {
                fontColor = {80, 80, 255, 255},
                hoverFontColor = {0, 0, 0, 255},
                hoverColor = {50, 75, 200, 255}
            }
        }
    },

    ["beautify_gridlist"] = {
        color = {10, 10, 10, 250},
        columnBar = {
            font = DxFont("files/assets/fonts/teko_medium.ttf", 18),
            fontColor = {0, 0, 0, 255},
            color = {80, 80, 255, 255},
            divider = {
                size = 2,
                color = {10, 10, 10, 255}
            }
        },
        rowBar = {
            fontColor = {0, 0, 0, 255},
            color = {0, 0, 0, 255}
        }
    }

}