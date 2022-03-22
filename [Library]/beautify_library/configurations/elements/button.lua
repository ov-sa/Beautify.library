----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: button.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_button"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "button",
    syntax = {
        functionName = "createButton",
        parameters = {
            {name = "text", type = "string"},
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "type", type = "string", isTemplateType = true},
            ["TEMPLATE_PARAMETERS"] = {
                ["default"] = {
                    {name = "width", type = "float"},
                    {name = "height", type = "float"}
                }
            }
        }
    },
    renderFunction = renderButton,
    allowedChildren = false,
    isDraggable = false,
    minimumSize = 24,
    ["TEMPLATE_PROPERTIES"] = {
        ["default"] = {}
    },
    viewSection = {
        paddingX = 5,
        hoverAnimDuration = 1250
    }
}

availableElements[elementType]["APIs"] = {
    ["setButtonText"] = {
        parameters = {
            {name = "button", type = "userdata", userDataType = elementType},
            {name = "text", type = "string"}
        }
    },
    ["getButtonText"] = {
        parameters = {
            {name = "button", type = "userdata", userDataType = elementType}
        }
    }
}