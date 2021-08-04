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
    color = {5, 5, 5, 255},
    fontColor = {255, 255, 255, 255},
    track = {
        size = 3,
        color = {125, 125, 255, 253}
    },
    thumb = {
        minSize = 75,
        color = {175, 175, 175, 255}
    }
}