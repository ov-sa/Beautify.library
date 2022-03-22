  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: settings: client.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Client Sided Settings ]]--
----------------------------------------------------------------


------------------
--[[ Settings ]]--
------------------

resource = getResourceRootElement(getThisResource())

UI_VALID_ALIGNMENT = {
    horizontal = {
        ["left"] = true,
        ["right"] = true,
        ["center"] = true
    },
    vertical = {
        ["top"] = true,
        ["bottom"] = true,
        ["center"] = true
    }
}

UI_VALID_SCROLLERS = {
    ["scrollBar_Horizontal"] = {
        isHorizontal = true
    },
    ["scrollBar_Vertical"] = {}
}

UI_PRIORITY_LEVEL = {
    RENDER = "low-999",
    INPUT = "low-1000"
}

UI_INPUT_FRAME = {
    SCROLL_DELAY = 300
}