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
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"},
            {name = "text", type = "string"}
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