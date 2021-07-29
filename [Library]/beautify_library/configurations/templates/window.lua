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

availableTemplates["beautify_window"] = {
    color = {0, 0, 0, 253},
    titleBar = {
        isOutLine = true,
        font = DxFont("files/assets/fonts/mukta_semibold.ttf", 15),
        fontColor = {125, 125, 255, 255},
        color = {0, 0, 0, 255},
        divider = {
            size = 1,
            color = {125, 125, 255, 75}
        },
        close_button = {
            isOutLine = true,
            fontColor = {125, 125, 255, 255},
            hoverFontColor = {0, 0, 0, 255},
            hoverColor = {125, 125, 255, 255}
        }
    }
}