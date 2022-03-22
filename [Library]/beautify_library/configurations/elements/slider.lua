----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: slider.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
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
    reference = "slider",
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
    minimumSize = 28,
    validTypes = {
        ["horizontal"] = true,
        ["vertical"] = true
    },
    viewSection = {
        padding = 5,
        hoverAnimDuration = 1250
    }
}

availableElements[elementType]["APIs"] = {
    ["setSliderPercent"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType},
            {name = "percent", type = "float"}
        }
    },
    ["getSliderPercent"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType}
        }
    },
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
    },
    ["clearSliderTextColor"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType}
        }
    },
    ["setSliderTextColor"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType},
            {name = "color", type = "table"}
        }
    },
    ["getSliderTextColor"] = {
        parameters = {
            {name = "slider", type = "userdata", userDataType = elementType}
        }
    }
}