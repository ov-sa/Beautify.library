----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: renderer.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Renderer ]]--
----------------------------------------------------------------


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

addEventHandler("onClientRender", root, function()

    for i, j in pairs(createdElements) do
        local elementType = i:getType()
        if elementType and availableElements[elementType] then
            --outputChatBox(elementType)
        end
    end

end)