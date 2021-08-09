----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_slider"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
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
    isDraggable = false,
    minimumSize = 24,
    minimumWidth = 24,
    minimumHeight = 27,
    validTypes = {
        ["horizontal"] = true,
        ["vertical"] = true
    },
    contentSection = {
        padding = 5,
        hoverAnimDuration = 1250
    }
}

availableElements[elementType]["APIs"] = {
    ["clearSliderText"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType}
        }
    },
    ["setSliderText"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType},
            {name = "text", type = "string"}
        }
    },
    ["getSliderText"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType}
        }
    }
}