  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: utilities: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------


------------------------------------------
--[[ Event: On Client Element Destroy ]]--
------------------------------------------

addEventHandler("onClientElementDestroy", resourceRoot, function()

    local elementType = source:getType()
    if availableElements[elementType] and availableElements[elementType].__clearCache and getType(availableElements[elementType].__clearCache) == "function" then
        availableElements[elementType].__clearCache(source, true)
        destroyElement(source, true)
    end

end)