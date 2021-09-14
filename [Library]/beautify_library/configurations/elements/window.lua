----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_window"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "window",
    syntax = {
        functionName = "createWindow",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"},
            {name = "title", type = "string"}
        }
    },
    renderFunction = renderWindow,
    allowedChildren = {
        ["beautify_gridlist"] = true,
        ["beautify_button"] = true,
        ["beautify_label"] = true,
        ["beautify_slider"] = true,
        ["beautify_selector"] = true,
        ["beautify_checkbox"] = true,
        ["beautify_deckpane"] = true
    },
    isDraggable = true,
    minimumSize = 56,
    titleBar = {
        paddingX = 5,
        closeButton = {
            hoverAnimDuration = 1000
        }
    },
    viewSection = {
        padding = 5
    }
}

availableElements[elementType]["APIs"] = {}