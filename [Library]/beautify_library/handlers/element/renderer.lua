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

local clickedMouseKey = false


--------------------------------------------------------
--[[ Functions: Renders Elements/Element's Children ]]--
--------------------------------------------------------

local function renderElements()

    local renderingPriorityCount = #createdRenderingPriority
    if renderingPriorityCount <= 0 then return false end

    local validatedRenderingPriority = {}
    for i = 1, renderingPriorityCount, 1 do
        local element = createdRenderingPriority[i].element
        if isUIValid(element) and isUIVisible(element) then
            local elementType = element:getType()
            if availableElements[elementType] and availableElements[elementType].renderFunction and type(availableElements[elementType].renderFunction) == "function" then
                table.insert(validatedRenderingPriority, {index = i, element = element, type = elementType})
                availableElements[elementType].renderFunction(element)
            end
        end
    end
    for i = #validatedRenderingPriority, 1, -1 do
        local element = validatedRenderingPriority[i].element
        local elementType = validatedRenderingPriority[i].type
        if not CLIENT_HOVERED_ELEMENT and not isUIDisabled(element) then
            local elementReference = createdElements[element]
            if isMouseOnPosition(elementReference.gui.x, elementReference.gui.y, elementReference.gui.width, elementReference.gui.height) then
                CLIENT_HOVERED_ELEMENT = element
            end
        end
        availableElements[elementType].renderFunction(element, true)
    end
    return true

end

function renderElementChildren(element, isFetchingInput)

    if not isFetchingInput and (not element or not isElement(element)) then return false end
    local elementReference = createdElements[element]
    local element_renderTarget = elementReference.gui.renderTarget
    if not isFetchingInput and (not element_renderTarget or not isElement(element_renderTarget)) then return false end

    if not isFetchingInput then
        dxSetRenderTarget(element_renderTarget, true)
        dxSetBlendMode("modulate_add")
        for i = 1, #elementReference.renderIndexReference[(elementReference.renderIndex)].children, 1 do
            local child = elementReference.renderIndexReference[(elementReference.renderIndex)].children[i].element
            if isUIValid(child) and isUIVisible(child) then
                local childType = child:getType()
                if availableElements[childType] and availableElements[childType].renderFunction and type(availableElements[childType].renderFunction) == "function" then
                    availableElements[childType].renderFunction(child)
                    dxSetRenderTarget(element_renderTarget)
                    dxSetBlendMode("modulate_add")
                end
            end
        end
        dxSetBlendMode("blend")
        dxSetRenderTarget()
    else
        for i = #elementReference.renderIndexReference[(elementReference.renderIndex)].children, 1, -1 do
            local child = elementReference.renderIndexReference[(elementReference.renderIndex)].children[i].element
            if isUIValid(child) and isUIVisible(child) then
                local childType = child:getType()
                if (CLIENT_HOVERED_ELEMENT == element) and not isUIDisabled(child) then
                    local childReference = createdElements[child]
                    local isParentContentHovered = isMouseOnPosition(elementReference.gui.x, elementReference.gui.y, elementReference.gui.width, elementReference.gui.height) and isMouseOnPosition(elementReference.gui.x + elementReference.gui.contentSection.startX, elementReference.gui.y + elementReference.gui.contentSection.startY, elementReference.gui.contentSection.width, elementReference.gui.contentSection.height)
                    if isParentContentHovered then
                        if isMouseOnPosition(elementReference.gui.x + elementReference.gui.contentSection.startX + childReference.gui.x, elementReference.gui.y + elementReference.gui.contentSection.startY + childReference.gui.y, childReference.gui.width, childReference.gui.height) then
                            CLIENT_HOVERED_ELEMENT = child
                        end
                    end
                end
                availableElements[childType].renderFunction(child, true)
            end
        end
    end
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
                local attached_offsetX, attached_offsetY = interpolateBetween(createdElements[(attachedElement.element)].gui.x, createdElements[(attachedElement.element)].gui.y, 0, cX - attachedElement.offsetX, cY - attachedElement.offsetY, 0, 0.45, "InQuad")
                createdElements[(attachedElement.element)].gui.x, createdElements[(attachedElement.element)].gui.y = math.ceil(attached_offsetX), math.ceil(attached_offsetY)
            end
        end
    end

    -->> Renders Element <<--
    clickedMouseKey = isMouseClicked()
    renderElements()
    if clickedMouseKey and CLIENT_HOVERED_ELEMENT then
        resetKeyClickCache(clickedMouseKey)
        triggerEvent("onClientUIClick", CLIENT_HOVERED_ELEMENT, (clickedMouseKey == "mouse1" and "left") or "right")
        clickedMouseKey = false
    end

    CLIENT_MTA_RESTORED = false
    CLIENT_HOVERED_ELEMENT = false
    resetKeyClickCache()
    resetScrollCache()

end, false, UI_PRIORITY_LEVEL.RENDER)