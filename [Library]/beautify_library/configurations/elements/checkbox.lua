----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: checkbox.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_checkbox"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "checkbox",
    syntax = {
        functionName = "createCheckbox",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderCheckbox,
    allowedChildren = false,
    isDraggable = false,
    minimumSize = 20,
    tickboxSize = 12,
    contentSection = {
        padding = 1,
        hoverAnimDuration = 1250
    }
}

availableElements[elementType]["APIs"] = {
    ["setCheckboxSelection"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType},
            {name = "state", type = "boolean"}
        }
    },
    ["getCheckboxSelection"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType}
        }
    },
    ["clearCheckboxText"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType}
        }
    },
    ["setCheckboxText"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType},
            {name = "text", type = "string"}
        }
    },
    ["getCheckboxText"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType}
        }
    },
    ["clearCheckboxTextColor"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType}
        }
    },
    ["setCheckboxTextColor"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType},
            {name = "color", type = "table"}
        }
    },
    ["getCheckboxTextColor"] = {
        parameters = {
            {name = "checkbox", type = "userdata", userDataType = elementType}
        }
    }
}