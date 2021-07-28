----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: window.lua
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
        font = DxFont("files/assets/fonts/teko_medium.ttf", 17),
        fontColor = {0, 0, 0, 255},
        color = {80, 80, 255, 255},
        divider = {
            size = 2,
            color = {5, 5, 5, 253}
        }
    },
    rowBar = {
        font = DxFont("files/assets/fonts/signika_semibold.ttf", 10),
        fontColor = {80, 80, 255, 255},
        color = {0, 0, 0, 255},
        hoverFontColor = {0, 0, 0, 255},
        hoverColor = {80, 80, 255, 255}
    }
}