----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: renderer.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Renderer ]]--
----------------------------------------------------------------


----------------------------------------------
--[[ Function: Renders Element's Children ]]--
----------------------------------------------

function renderElementChildren(element)

    if not element or not isElement(element) or not createdParentElements[element] then return false end
    local elementReference = createdElements[element]
    local element_renderTarget = elementReference.gui.renderTarget
    if not element_renderTarget or not isElement(element_renderTarget) then return false end

    dxSetRenderTarget(element_renderTarget, true)
    dxSetBlendMode("modulate_add")
    for i, j in pairs(createdParentElements[element]) do
        if isUIValid(i) and isUIVisible(i) then
            local child_elementType = i:getType()
            if availableElements[child_elementType] and availableElements[child_elementType].renderFunction and type(availableElements[child_elementType].renderFunction) == "function" then
                availableElements[child_elementType].renderFunction(i)
                dxSetRenderTarget(element_renderTarget)
                dxSetBlendMode("modulate_add")
            end
        end
    end
    dxSetBlendMode("blend")
    dxSetRenderTarget()
    return true

end


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

addEventHandler("onClientRender", root, function()

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
    local clickedMouseKey = isMouseClicked()
    for i, j in pairs(createdParentElements) do
        if isUIValid(i) and isUIVisible(i) then
            local elementType = i:getType()
            if availableElements[elementType] and availableElements[elementType].renderFunction and type(availableElements[elementType].renderFunction) == "function" then
                availableElements[elementType].renderFunction(i)
            end
            if clickedMouseKey and not isUIDisabled(i) then
                if isMouseOnPosition(createdElements[i].gui.x, createdElements[i].gui.y, createdElements[i].gui.width, createdElements[i].gui.height) then
                    triggerEvent("onClientUIClick", i, (clickedMouseKey == "mouse1" and "left") or "right")
                    clickedMouseKey = false
                end
            end
        end
    end

    if CLIENT_MTA_RESTORED then
        CLIENT_MTA_RESTORED = false
    end
    resetKeyClickCache()
    resetScrollCache()

end, false, UI_PRIORITY_LEVEL.RENDER)