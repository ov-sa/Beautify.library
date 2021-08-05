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
            {name = "height", type = "float"},
            {name = "type", type = "string"}
        }
    },
    renderFunction = renderSlider,
    allowedChildren = false,
    minimumSize = 24,
    minimumWidth = 24,
    minimumHeight = 24,
    validTypes = {
        ["horizontal"] = true,
        ["vertical"] = true
    },
    contentSection = {
        padding = 5,
        hoverAnimDuration = 1250
    }
}

availableElements["beautify_slider"]["APIs"] = {
    ["clearSliderText"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = "beautify_slider"}
        }
    },
    ["setSliderText"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = "beautify_slider"},
            {name = "text", type = "string"}
        }
    },
    ["getSliderText"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = "beautify_slider"}
        }
    }
}