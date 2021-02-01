----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

--inputDelayDuration = 500 --(In milliseconds)
availableElements = {

    ["ov_window"] = {
        __functionName = "createWindow",
        __parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"},
            {name = "title", type = "string"}
        },
        __destroyReferences = destroyWindow
    }

}