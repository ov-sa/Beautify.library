  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: settings: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
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

UI_PRIORITY_LEVEL = {
    RENDER = "low-999",
    INPUT = "low-1000"
}

UI_INPUT_FRAME = {
    SCROLL_DELAY = 300
}