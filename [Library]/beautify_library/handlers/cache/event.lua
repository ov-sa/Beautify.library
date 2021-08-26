----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: event.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Event's Cache Handler ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    pairs = pairs,
    ipairs = ipairs,
    addEvent = addEvent
}


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    for i, j in imports.pairs(availableEvents) do
        for k, v in imports.ipairs(j) do
            imports.addEvent(v, false)
        end
    end

end)