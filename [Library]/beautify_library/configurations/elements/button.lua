----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: button.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableElements["beautify_button"] = {
    syntax = {
        functionName = "createButton",
        parameters = {
            {name = "text", type = "string"},
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "type", type = "string", isTemplateType = true},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderButton,
    allowedChildren = {},
    --minimumSize = 55,
    buttonBody = {
        hoverAnimDuration = 1000
    }
}

availableElements["beautify_button"]["apis"] = {}