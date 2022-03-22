----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: logger: client.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Logger Handler ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    unpack = unpack,
    outputDebugString = outputDebugString
}


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

    imports.outputDebugString("[Beautify Library] | "..logMessage, 4, imports.unpack(logTypes[logType].color))
    return true
    
end