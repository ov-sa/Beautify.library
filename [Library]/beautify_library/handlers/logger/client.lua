----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: logger: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Logger Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local logTypes = {

    ["info"] = {
        color = {200, 200, 200}
    },

    ["error"] = {
        color = {255, 0, 0}
    }

}


----------------------------------
--[[ Function: Outputs UI Log ]]--
----------------------------------

function outputUILog(logMessage, logType)

    if not logMessage or not logType or not logTypes[logType] then return false end

    outputDebugString("[Beautify Library] | "..logMessage, 4, unpackColor(logTypes[logType].color))
    return true
    
end