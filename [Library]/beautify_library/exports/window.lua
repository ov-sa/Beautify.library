----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Exports ]]--
----------------------------------------------------------------


----------------------------------
--[[ Function: Creates Window ]]--
----------------------------------

function createWindow(...)

    local passedParams = {...}
    if not isUIParametersValid(passedParams, "ov_window") then return false end

    outputChatBox("CREATED UI")
    return true

end