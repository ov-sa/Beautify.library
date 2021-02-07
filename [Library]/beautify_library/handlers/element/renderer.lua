----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: renderer.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Renderer ]]--
----------------------------------------------------------------

-------------------
--[[ Variables ]]--
-------------------

isLMBClicked = false
local prevLMBClickState = false


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

addEventHandler("onClientRender", root, function()

    if not GuiElement.isMTAWindowActive() then
        if not prevLMBClickState then
            if getKeyState("mouse1") then
                isLMBClicked = true
                prevLMBClickState = true
            end
        else
            if not getKeyState("mouse1") then
                prevLMBClickState = false
            end
        end
    else
        isLMBClicked = false
    end

    for i, j in pairs(_____getChildElements()) do
        if isUIValid(i) then
            local elementType = i:getType()
            if availableElements[elementType] and availableElements[elementType].__renderFunction and type(availableElements[elementType].__renderFunction) == "function" then
                availableElements[elementType].__renderFunction(i)
            end
        end
    end

    for i, j in pairs(createdParentElements) do
        if isUIValid(i) then
            local elementType = i:getType()
            if availableElements[elementType] and availableElements[elementType].__renderFunction and type(availableElements[elementType].__renderFunction) == "function" then
                availableElements[elementType].__renderFunction(i)
            end
        end
    end

    isLMBClicked = false

end, true, "low-999")