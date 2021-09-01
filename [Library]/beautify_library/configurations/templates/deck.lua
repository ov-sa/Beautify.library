----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: deck.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_deck"] = {
    color = {2, 2, 2, 253},
    titleBar = {
        isOutLine = true,
        font = dxCreateFont("files/assets/fonts/signika_semibold.ttf", 11),
        color = {225, 225, 225, 255},
        fontColor = {0, 0, 0, 255},
        divider = {
            size = 1,
            color = {0, 0, 0, 255},
        },
        toggleButton = {
            isOutLine = true,
            color = {0, 0, 0, 255}
        }
    }
}