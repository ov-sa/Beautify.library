----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: card.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_card"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "card",
    syntax = {
        functionName = "createCard",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderCard,
    allowedChildren = {
        ["beautify_gridlist"] = true,
        ["beautify_button"] = true,
        ["beautify_label"] = true,
        ["beautify_slider"] = true,
        ["beautify_selector"] = true,
        ["beautify_checkbox"] = true,
        ["beautify_deckpane"] = true
    },
    isDraggable = false,
    minimumSize = 56,
    viewSection = {
        padding = 5
    }
}

availableElements[elementType]["APIs"] = {}