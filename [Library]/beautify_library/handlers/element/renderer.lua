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

    --TODO: DRAW NON PARENT ELEMENTS FIRSTS.

    for i, j in pairs(createdParentElements) do
        if isUIValid(i) then
            local elementType = i:getType()
            if availableElements[elementType] and availableElements[elementType].__renderFunction and type(availableElements[elementType].__renderFunction) == "function" then
                availableElements[elementType].__renderFunction(i)
            end
        end
    end

end)