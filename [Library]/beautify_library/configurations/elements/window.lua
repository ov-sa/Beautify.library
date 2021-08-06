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
        ["beautify_slider"] = true
    },
    isDraggable = true,
    minimumSize = 56,
    titleBar = {
        paddingX = 5,
        close_button = {
            hoverAnimDuration = 1000
        }
    },
    contentSection = {
        padding = 5
    }
}

availableElements[elementType]["APIs"] = {}