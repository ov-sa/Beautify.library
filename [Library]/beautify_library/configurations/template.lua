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

availableOverlays = {

    night = {175, 175, 175},
    autumn = {255, 196, 133}

}

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
                hoverColor = {80, 80, 255, 255}
            }
        }
    },

    ["beautify_gridlist"] = {
        color = {10, 10, 10, 253},
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
            font = DxFont("files/assets/fonts/teko_medium.ttf", 15),
            fontColor = {80, 80, 255, 255},
            color = {0, 0, 0, 255},
            hoverFontColor = {0, 0, 0, 255},
            hoverColor = {80, 80, 255, 255}
        }
    }

}