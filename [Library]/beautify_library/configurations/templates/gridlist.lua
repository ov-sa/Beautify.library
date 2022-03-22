----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: window.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_gridlist"] = {
    color = {20, 20, 20, 253},
    columnBar = {
        isOutLine = true,
        font = dxCreateFont("files/assets/fonts/teko_medium.rw", 18),
        color = {235, 235, 235, 255},
        fontColor = {6, 6, 6, 255},
        divider = {
            size = 2,
            color = {20, 20, 20, 253}
        }
    },
    rowBar = {
        isOutLine = true,
        font = dxCreateFont("files/assets/fonts/signika_semibold.rw", 11),
        color = {6, 6, 6, 255},
        fontColor = {217, 217, 217, 255},
        hoverColor = {217, 217, 217, 255},
        hoverFontColor = {6, 6, 6, 255}
    },
    scrollBar_Horizontal = {
        isOutLine = true
    },
    scrollBar_Vertical = {
        isOutLine = true
    }
}