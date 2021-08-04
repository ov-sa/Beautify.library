----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_slider"] = {
    font = DxFont("files/assets/fonts/poppins_medium.ttf", 15),
    color = {5, 5, 5, 253},
    fontColor = {255, 255, 255, 255},
    track = {
        size = 3,
        color = {125, 125, 255, 255}
    },
    thumb = {
        size = 7,
        color = {255, 255, 255, 255}
    },
    slideBar_Horizontal = {
        isOutLine = true
    },
    slideBar_Vertical = {
        isOutLine = true
    }
}