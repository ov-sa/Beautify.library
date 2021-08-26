----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: checkbox.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_checkbox"] = {
    fontPaddingY = 3,
    font = dxCreateFont("files/assets/fonts/poppins_medium.ttf", 14),
    fontColor = {200, 200, 200, 255},
    tickBox = {
        isOutLine = true,
        color = {50, 50, 50, 255},
        iconColor = {125, 125, 255, 255}
    }
}