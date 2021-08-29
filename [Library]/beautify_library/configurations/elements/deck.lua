----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: deck.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_deck"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "deck",
    syntax = {
        functionName = "createDeck",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"},
            {name = "title", type = "string"}
        }
    },
    renderFunction = renderDeck,
    allowedChildren = availableElements["beautify_window"].allowedChildren,
    isDraggable = true,
    minimumSize = 56,
    titleBar = {
        paddingX = 5,
        toggleButton = {
            hoverAnimDuration = 1000
        }
    },
    contentSection = {
        padding = 5
    }
}

availableElements[elementType]["APIs"] = {}