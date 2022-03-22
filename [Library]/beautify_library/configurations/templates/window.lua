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

availableTemplates["beautify_window"] = {
    color = {6, 6, 6, 253},
    titleBar = {
        isOutLine = true,
        font = dxCreateFont("files/assets/fonts/poppins_medium.rw", 15),
        fontColor = {235, 235, 235, 255},
        color = {6, 6, 6, 255},
        divider = {
            size = 1,
            color = {235, 235, 235, 150}
        },
        closeButton = {
            isOutLine = true,
            fontColor = {235, 235, 235, 255},
            hoverColor = {235, 235, 235, 255},
            hoverFontColor = {6, 6, 6, 255}
        }
    }
}