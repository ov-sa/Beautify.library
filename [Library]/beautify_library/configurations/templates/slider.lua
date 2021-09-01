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
    fontScale = 0.5,
    font = dxCreateFont("files/assets/fonts/signika_semibold.ttf", 20),
    fontColor = {225, 225, 225, 255},
    track = {
        size = 3,
        progressedColor = {225, 225, 225, 255},
        unprogressedColor = {15, 15, 15, 255}
    },
    thumb = {
        size = 9.2,
        color = {225, 225, 225, 255}
    },
    slideBar_Horizontal = {
        isOutLine = true
    },
    slideBar_Vertical = {
        isOutLine = true
    }
}