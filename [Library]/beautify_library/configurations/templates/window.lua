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

availableTemplates["beautify_window"] = {
    color = {0, 0, 0, 253},
    titleBar = {
        isOutLine = true,
        font = DxFont("files/assets/fonts/mukta_semibold.ttf", 15),
        fontColor = {80, 80, 255, 255},
        color = {0, 0, 0, 255},
        divider = {
            size = 2,
            color = {80, 80, 255, 75}
        },
        close_button = {
            isOutLine = true,
            fontColor = {80, 80, 255, 255},
            hoverFontColor = {0, 0, 0, 255},
            hoverColor = {80, 80, 255, 255}
        }
    }
}