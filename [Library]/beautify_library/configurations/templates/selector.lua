----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: selector.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_selector"] = {
    fontPaddingY = 3,
    font = dxCreateFont("files/assets/fonts/poppins_medium.ttf", 14),
    color = {50, 50, 50, 255},
    hoverColor = {125, 125, 255, 255},
    fontColor = {200, 200, 200, 255},
    arrow_Previous = {
        isOutLine = true
    },
    arrow_Next = {
        isOutLine = true
    }
}