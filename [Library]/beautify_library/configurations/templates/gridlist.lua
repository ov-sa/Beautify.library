----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_gridlist"] = {
    color = {5, 5, 5, 253},
    columnBar = {
        isOutLine = true,
        font = DxFont("files/assets/fonts/teko_medium.ttf", 18),
        fontColor = {0, 0, 0, 255},
        color = {125, 125, 255, 255},
        divider = {
            size = 2,
            color = {5, 5, 5, 253}
        }
    },
    rowBar = {
        isOutLine = true,
        font = DxFont("files/assets/fonts/signika_semibold.ttf", 11),
        fontColor = {100, 100, 255, 255},
        color = {0, 0, 0, 255},
        hoverFontColor = {0, 0, 0, 255},
        hoverColor = {100, 100, 255, 255}
    },
    scrollBar_Horizontal = {
        isOutLine = true
    },
    scrollBar_Vertical = {
        isOutLine = true
    }
}