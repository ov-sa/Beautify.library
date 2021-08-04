----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: label.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableElements["beautify_label"] = {
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
    allowedChildren = false
}

availableElements["beautify_label"]["APIs"] = {
    ["setLabelText"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = "beautify_label"},
            {name = "text", type = "string"}
        }
    },
    ["getLabelText"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = "beautify_label"}
        }
    },
    ["setLabelHorizontalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = "beautify_label"},
            {name = "alignment", type = "string"}
        }
    },
    ["getLabelHorizontalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = "beautify_label"}
        }
    },
    ["setLabelVerticalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = "beautify_label"},
            {name = "alignment", type = "string"}
        }
    },
    ["getLabelVerticalAlignment"] = {
        parameters = {
            {name = "label", type = "userdata", userDataType = "beautify_label"}
        }
    }
}