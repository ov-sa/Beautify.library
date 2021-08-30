----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: deckpane.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_deckpane"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "deckpane",
    syntax = {
        functionName = "createDeckpane",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderDeckPane,
    allowedChildren = {
        ["beautify_deck"] = true
    },
    isDraggable = false
}

availableElements[elementType]["APIs"] = {}