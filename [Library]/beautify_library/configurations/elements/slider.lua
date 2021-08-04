----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableElements["beautify_slider"] = {
    syntax = {
        functionName = "createSlider",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderSlider,
    allowedChildren = false,
    minimumSize = 24,
    minimumWidth = 50,
    minimumHeight = 37,
    contentSection = {
        padding = 5
    }
}

availableElements["beautify_slider"]["APIs"] = {}