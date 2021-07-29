----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: event.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Event's Cache Handler ]]--
----------------------------------------------------------------


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    for i, j in pairs(availableEvents) do
        for k, v in ipairs(j) do
            addEvent(v, false)
        end
    end

end)