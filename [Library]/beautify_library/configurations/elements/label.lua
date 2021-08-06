----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: label.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_label"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    syntax = {
        functionName = "createLabel",
        parameters = {
            {name = "text", type = "string"},
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderLabel,
    allowedChildren = false,
    isDraggable = false
}

availableElements[elementType]["APIs"] = {
    ["setLabelText"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType},
            {name = "text", type = "string"}
        }
    },
    ["getLabelText"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType}
        }
    },
    ["clearLabelColor"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType}
        }
    },
    ["setLabelColor"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType},
            {name = "color", type = "table"}
        }
    },
    ["getLabelColor"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType}
        }
    },
    ["setLabelHorizontalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType},
            {name = "alignment", type = "string"}
        }
    },
    ["getLabelHorizontalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType}
        }
    },
    ["setLabelVerticalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType},
            {name = "alignment", type = "string"}
        }
    },
    ["getLabelVerticalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = elementType}
        }
    }
}