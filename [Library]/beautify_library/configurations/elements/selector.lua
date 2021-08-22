----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: selector.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_selector"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "selector",
    syntax = {
        functionName = "createSelector",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"},
            {name = "type", type = "string"}
        }
    },
    renderFunction = renderSelector,
    allowedChildren = false,
    isDraggable = false,
    minimumSize = 24,
    minimumArrowSize = 11,
    validTypes = {
        ["horizontal"] = true,
        ["vertical"] = true
    },
    contentSection = {
        padding = 1,
        hoverAnimDuration = 1250
    }
}

availableElements[elementType]["APIs"] = {}