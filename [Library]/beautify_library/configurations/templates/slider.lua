----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: templates: slider.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_slider"] = {
    fontScale = 0.5,
    font = dxCreateFont("files/assets/fonts/signika_semibold.rw", 20),
    fontColor = {235, 235, 235, 255},
    track = {
        size = 3,
        progressedColor = {235, 235, 235, 255},
        unprogressedColor = {32, 32, 32, 255}
    },
    thumb = {
        slideAcceleration = 0.25,
        size = 9.2,
        color = {235, 235, 235, 255}
    },
    slideBar_Horizontal = {
        isOutLine = true
    },
    slideBar_Vertical = {
        isOutLine = true
    }
}