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
            local elementType = getElementType(element)
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
        availableElements[elementType].renderFunction(element, true, {x = 0, y = 0, element = element})
    end
    return true

end

function renderElementChildren(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not element or not isElement(element) then return false end
    else
        if not mouseReference then return false end
    end

    local elementReference = createdElements[element]
    if #elementReference.renderIndexReference[(elementReference.renderIndex)].children <= 0 then return false end

    if not isFetchingInput then
        local element_renderTarget = elementReference.gui.renderTarget
        if not element_renderTarget or not isElement(element_renderTarget) then return false end

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
    else
        local propagatedMouseReference = false
        if mouseReference.element == element then
            propagatedMouseReference = mouseReference
        else
            propagatedMouseReference = cloneTableDatas(mouseReference)
            propagatedMouseReference.element = element
        end
        propagatedMouseReference.x = propagatedMouseReference.x + elementReference.gui.x + ((elementReference.gui.contentSection and elementReference.gui.contentSection.startX) or 0)
        propagatedMouseReference.y = propagatedMouseReference.y + elementReference.gui.y + ((elementReference.gui.contentSection and elementReference.gui.contentSection.startY) or 0)
        for i = #elementReference.renderIndexReference[(elementReference.renderIndex)].children, 1, -1 do
            local child = elementReference.renderIndexReference[(elementReference.renderIndex)].children[i].element
            if isUIValid(child) and isUIVisible(child) then
                local childType = child:getType()
                local childReference = createdElements[child]
                if (CLIENT_HOVERED_ELEMENT == element) and not isUIDisabled(child) then
                    if isMouseOnPosition(propagatedMouseReference.x + childReference.gui.x, propagatedMouseReference.y + childReference.gui.y, childReference.gui.width, childReference.gui.height, childReference.gui.height) then
                        CLIENT_HOVERED_ELEMENT = child
                    end
                end
                availableElements[childType].renderFunction(child, true, propagatedMouseReference)
            end
        end
    end
    return true

end


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

addEventHandler("onClientRender", root, function()

    if CLIENT_ATTACHED_ELEMENT then
        if not CLIENT_ATTACHED_ELEMENT.element or not isElement(CLIENT_ATTACHED_ELEMENT.element) or not createdElements[CLIENT_ATTACHED_ELEMENT.element] then
            detachElement()
        elseif CLIENT_MTA_WINDOW_ACTIVE or not CLIENT_IS_CURSOR_SHOWING or not getKeyState("mouse1") or not isUIValid(CLIENT_ATTACHED_ELEMENT.element) or not isUIVisible(CLIENT_ATTACHED_ELEMENT.element) then
            createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui["__UI_CACHE__"].updateElement = true
            detachElement()
        else
            if not CLIENT_ATTACHED_ELEMENT.isInternal then
                local cursorOffset = {getAbsoluteCursorPosition()}
                if cursorOffset[1] and cursorOffset[2] then
                    local attached_offsetX, attached_offsetY = interpolateBetween(createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.x, createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.y, 0, cursorOffset[1] - CLIENT_ATTACHED_ELEMENT.offsetX, cursorOffset[2] - CLIENT_ATTACHED_ELEMENT.offsetY, 0, 0.45, "InQuad")
                    createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.x, createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.y = math.ceil(attached_offsetX), math.ceil(attached_offsetY)
                    createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui["__UI_CACHE__"].updateElement = true
                end
            end
        end
    end

    clickedMouseKey = (not CLIENT_ATTACHED_ELEMENT and isMouseClicked())
    renderElements()
    if clickedMouseKey and CLIENT_HOVERED_ELEMENT then
        resetKeyClickCache(clickedMouseKey)
        triggerEvent("onClientUIClick", CLIENT_HOVERED_ELEMENT, (clickedMouseKey == "mouse1" and "left") or "right")
        clickedMouseKey = false
    end

    if not CLIENT_MTA_MINIMIZED and not reloadResourceTemplates.__cache.loaded then
        if reloadResourceTemplates.__cache.loadStatus == "initialized" then
            reloadResourceTemplates.__cache.loadStatus = "reload"
        elseif reloadResourceTemplates.__cache.loadStatus == "reload" then
            reloadResourceTemplates = {
                __cache = cloneTableDatas(reloadResourceTemplates.__cache, false)
            }
            reloadResourceTemplates.__cache.loaded = true
            reloadResourceTemplates.__cache.loadStatus = false
        end
    end
    CLIENT_MTA_RESTORED = false
    CLIENT_HOVERED_ELEMENT = false
    resetKeyClickCache()
    resetScrollCache()

end, false, UI_PRIORITY_LEVEL.RENDER)