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
    local clickedMouseKey = isMouseClicked()
    local validatedRenderingPriority = {}
    for i = 1, #createdRenderingPriority[(createdElements[element].renderIndex)].children, 1 do
        local j = createdRenderingPriority[(createdElements[element].renderIndex)].children[i].element
        if isUIValid(j) and isUIVisible(j) then
            local elementType = j:getType()
            if availableElements[elementType] and availableElements[elementType].renderFunction and type(availableElements[elementType].renderFunction) == "function" then
                table.insert(validatedRenderingPriority, {index = i, element = j, type = elementType})
                availableElements[elementType].renderFunction(j)
                dxSetRenderTarget(element_renderTarget)
                dxSetBlendMode("modulate_add")
            end
        end
    end
    for i = #validatedRenderingPriority, 1, -1 do
        local j = validatedRenderingPriority[i].element
        local elementType = validatedRenderingPriority[i].type
        availableElements[elementType].renderFunction(j, true)
        if clickedMouseKey and not isUIDisabled(j) then
            if isMouseOnPosition(createdElements[j].gui.x, createdElements[j].gui.y, createdElements[j].gui.width, createdElements[j].gui.height) then
                triggerEvent("onClientUIClick", j, (clickedMouseKey == "mouse1" and "left") or "right")
                clickedMouseKey = false
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
    local validatedRenderingPriority = {}
    for i = 1, #createdRenderingPriority, 1 do
        local j = createdRenderingPriority[i].element
        if isUIValid(j) and isUIVisible(j) then
            local elementType = j:getType()
            if availableElements[elementType] and availableElements[elementType].renderFunction and type(availableElements[elementType].renderFunction) == "function" then
                table.insert(validatedRenderingPriority, {index = i, element = j, type = elementType})
                availableElements[elementType].renderFunction(j)
            end
        end
    end
    for i = #validatedRenderingPriority, 1, -1 do
        local j = validatedRenderingPriority[i].element
        local elementType = validatedRenderingPriority[i].type
        availableElements[elementType].renderFunction(j, true)
        if clickedMouseKey and not isUIDisabled(j) then
            if isMouseOnPosition(createdElements[j].gui.x, createdElements[j].gui.y, createdElements[j].gui.width, createdElements[j].gui.height) then
                triggerEvent("onClientUIClick", j, (clickedMouseKey == "mouse1" and "left") or "right")
                clickedMouseKey = false
            end
        end
    end

    if CLIENT_MTA_RESTORED then
        CLIENT_MTA_RESTORED = false
    end
    resetKeyClickCache()
    resetScrollCache()

end, false, UI_PRIORITY_LEVEL.RENDER)