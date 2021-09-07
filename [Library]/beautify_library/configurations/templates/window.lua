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
        font = dxCreateFont("files/assets/fonts/poppins_medium.rw", 15),
        fontColor = {225, 225, 225, 255},
        color = {0, 0, 0, 255},
        divider = {
            size = 1,
            color = {225, 225, 225, 150}
        },
        closeButton = {
            isOutLine = true,
            fontColor = {225, 225, 225, 255},
            hoverColor = {225, 225, 225, 255},
            hoverFontColor = {0, 0, 0, 255}
        }
    }
}