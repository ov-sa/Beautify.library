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
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderSelector,
    allowedChildren = false,
    isDraggable = false
}

availableElements[elementType]["APIs"] = {}