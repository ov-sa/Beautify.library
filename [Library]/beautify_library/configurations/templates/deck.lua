----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: deck.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_deck"] = {
    color = {12, 12, 12, 253},
    titleBar = {
        isOutLine = true,
        font = dxCreateFont("files/assets/fonts/signika_semibold.rw", 11),
        color = {235, 235, 235, 255},
        fontColor = {6, 6, 6, 255},
        divider = {
            size = 1,
            color = {6, 6, 6, 255},
        },
        toggleButton = {
            isOutLine = true,
            color = {6, 6, 6, 255}
        }
    }
}