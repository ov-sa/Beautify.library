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

    -->> Detects Key State <<--
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

    -->> Attaches Element <<--
    local attachedElement = getAttachedElement()
    if attachedElement then
        if not attachedElement.element or not isElement(attachedElement.element) or not createdElements[attachedElement.element] then
            detachElement()
        elseif GuiElement.isMTAWindowActive() or not isCursorShowing() or not getKeyState("mouse1") or not isUIValid(attachedElement.element) or not isUIVisible(attachedElement.element) then
            detachElement()
        else
            local cX, cY = getAbsoluteCursorPosition()
            if cX and cY then
                local attached_offsetX, attached_offsetY = interpolateBetween(createdElements[attachedElement.element].gui.x, createdElements[attachedElement.element].gui.y, 0, cX - attachedElement.offsetX, cY - attachedElement.offsetY, 0, 0.45, "InQuad")
                createdElements[attachedElement.element].gui.x, createdElements[attachedElement.element].gui.y = math.ceil(attached_offsetX), math.ceil(attached_offsetY)
            end
        end
    end

    -->> Renders Element <<--
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