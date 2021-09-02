----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: renderer.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    pairs = pairs,
    isElement = isElement,
    addEventHandler = addEventHandler,
    triggerEvent = triggerEvent,
    updateElement = updateElement,
    isUIValid = isUIValid,
    isUIVisible = isUIVisible,
    isUIDisabled = isUIDisabled,
    isKeyOnHold = isKeyOnHold,
    isMouseClicked = isMouseClicked,
    resetKeyClickCache = resetKeyClickCache,
    resetScrollCache = resetScrollCache,
    cloneTableDatas = cloneTableDatas,
    getAbsoluteCursorPosition = getAbsoluteCursorPosition,
    interpolateBetween = interpolateBetween,
    isMouseOnPosition = isMouseOnPosition,
    detachUIElement = detachUIElement,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    table = {
        insert = table.insert
    },
    math = {
        ceil = math.ceil
    }
}


-------------------
--[[ Variables ]]--
-------------------

CLIENT_ELEMENT_FORCE_RENDERED = {
    __cache = {
        pendingRemovalList = {}
    }
}
local clickedMouseKey = false


----------------------------------------------
--[[ Function: Force Renders Element Root ]]--
----------------------------------------------

local function disableElementForceRender(element, addToRemovalList)

    if addToRemovalList and CLIENT_ELEMENT_FORCE_RENDERED[element] then
        if not CLIENT_ELEMENT_FORCE_RENDERED.__cache.pendingRemovalList[element] then
            CLIENT_ELEMENT_FORCE_RENDERED.__cache.pendingRemovalList[element] = true
            return true
        end
    end
    CLIENT_ELEMENT_FORCE_RENDERED.__cache.pendingRemovalList[element] = nil
    CLIENT_ELEMENT_FORCE_RENDERED[element] = nil
    return true

end

function forceRenderElementRoot(elementRoot, liableElement, renderState)

    if renderState then
        if not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = {
                totalLiableElements = 0,
                liableElements = {}
            }
        end
        if CLIENT_ELEMENT_FORCE_RENDERED.__cache.pendingRemovalList[elementRoot] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].isAttached = nil
            CLIENT_ELEMENT_FORCE_RENDERED.__cache.pendingRemovalList[elementRoot] = nil
        end
        if not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].liableElements[liableElement] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].liableElements[liableElement] = true
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalLiableElements = CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalLiableElements + 1
        end
        return true
    else
        if CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] and (not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].isAttached) and CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].liableElements[liableElement] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].liableElements[liableElement] = nil
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalLiableElements = CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalLiableElements - 1
            if CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalLiableElements <= 0 then
                disableElementForceRender(elementRoot)
            end
            return true
        end
    end
    return false

end


--------------------------------------------------------
--[[ Functions: Renders Elements/Element's Children ]]--
--------------------------------------------------------

local function renderElements()

    local renderingPriorityCount = #createdRenderingPriority
    if renderingPriorityCount <= 0 then return false end

    local preRenderedElements = {}
    local validatedRenderingPriority = {}
    for i = 1, renderingPriorityCount, 1 do
        local element = createdRenderingPriority[i].element
        if imports.isUIValid(element) and imports.isUIVisible(element) then
            local elementType = createdElements[element].elementType
            availableElements[elementType].renderFunction(element)
            imports.table.insert(validatedRenderingPriority, {element = element, type = elementType})
        end
    end
    for i = #validatedRenderingPriority, 1, -1 do
        local element = validatedRenderingPriority[i].element
        local elementType = validatedRenderingPriority[i].type
        if not CLIENT_HOVERED_ELEMENT.element and not imports.isUIDisabled(element) then
            local elementReference = createdElements[element]
            if imports.isMouseOnPosition(elementReference.gui.x, elementReference.gui.y, elementReference.gui.width, elementReference.gui.height) then
                CLIENT_HOVERED_ELEMENT.elementRoot = element
                CLIENT_HOVERED_ELEMENT.element = element
                availableElements[elementType].renderFunction(element, true, {x = 0, y = 0, element = element})
                preRenderedElements[element] = true
                break
            end
        end
    end
    for element, _ in imports.pairs(CLIENT_ELEMENT_FORCE_RENDERED) do
        if (element ~= "__cache") and not preRenderedElements[element] then
            if not CLIENT_ELEMENT_FORCE_RENDERED.__cache.pendingRemovalList[element] and imports.isUIValid(element) and imports.isUIVisible(element) then
                local elementType = createdElements[element].elementType
                availableElements[elementType].renderFunction(element, true, {x = 0, y = 0, element = element})
            else
                disableElementForceRender(element)
            end
        end
    end
    return true

end

function renderElementChildren(element, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    local elementChildrenCount = #elementReference.renderIndexReference[(elementReference.renderIndex)].children
    if elementChildrenCount <= 0 then return false end

    local isChildrenToBeRendered = CLIENT_MTA_RESTORED or (not CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loaded and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)])
    if not isChildrenToBeRendered then
        local elementRoot = elementReference.elementRoot
        local isChildrenToBeForceRendered = (elementRoot and CLIENT_ELEMENT_FORCE_RENDERED[elementRoot]) or CLIENT_ELEMENT_FORCE_RENDERED[element]
        if not isChildrenToBeForceRendered then
            if not elementRoot then
                if CLIENT_HOVERED_ELEMENT.elementRoot ~= element then
                    return false
                end
            else
                if CLIENT_HOVERED_ELEMENT.elementRoot ~= elementRoot then
                    return false
                end
            end
        end
    end

    if not isFetchingInput then
        local element_renderTarget = elementReference.gui.renderTarget
        if not element_renderTarget or not imports.isElement(element_renderTarget) then return false end

        imports.dxSetRenderTarget(element_renderTarget, true)
        imports.dxSetBlendMode("modulate_add")
        for i = 1, elementChildrenCount, 1 do
            local childElement = elementReference.renderIndexReference[(elementReference.renderIndex)].children[i].element
            if imports.isUIValid(childElement) and imports.isUIVisible(childElement) then
                local childElementType = createdElements[childElement].elementType
                availableElements[childElementType].renderFunction(childElement)
                imports.dxSetRenderTarget(element_renderTarget)
                imports.dxSetBlendMode("modulate_add")
            end
        end
    else
        if not mouseReference then return false end

        local propagatedMouseReference = false
        if mouseReference.element == element then
            propagatedMouseReference = mouseReference
        else
            propagatedMouseReference = imports.cloneTableDatas(mouseReference)
            propagatedMouseReference.element = element
        end
        propagatedMouseReference.x = propagatedMouseReference.x + elementReference.gui.x + ((elementReference.gui.contentSection and elementReference.gui.contentSection.startX) or 0)
        propagatedMouseReference.y = propagatedMouseReference.y + elementReference.gui.y + ((elementReference.gui.contentSection and elementReference.gui.contentSection.startY) or 0)
        for i = elementChildrenCount, 1, -1 do
            local childElement = elementReference.renderIndexReference[(elementReference.renderIndex)].children[i].element
            if imports.isUIValid(childElement) and imports.isUIVisible(childElement) then
                local childElementType = createdElements[childElement].elementType
                if (CLIENT_HOVERED_ELEMENT.element == element) and not imports.isUIDisabled(childElement) then
                    local childReference = createdElements[childElement]
                    if imports.isMouseOnPosition(propagatedMouseReference.x + childReference.gui.x, propagatedMouseReference.y + childReference.gui.y, childReference.gui.width, childReference.gui.height, childReference.gui.height) then
                        CLIENT_HOVERED_ELEMENT.element = childElement
                    end
                end
                availableElements[childElementType].renderFunction(childElement, true, propagatedMouseReference)
            end
        end
    end
    return true

end


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

imports.addEventHandler("onClientRender", root, function()

    if CLIENT_ATTACHED_ELEMENT then
        local elementRoot = createdElements[(CLIENT_ATTACHED_ELEMENT.element)].elementRoot
        if not CLIENT_ATTACHED_ELEMENT.element or not imports.isElement(CLIENT_ATTACHED_ELEMENT.element) or not createdElements[CLIENT_ATTACHED_ELEMENT.element] then
            if elementRoot then
                disableElementForceRender(elementRoot)
            end
            imports.detachUIElement()
        elseif CLIENT_MTA_WINDOW_ACTIVE or not CLIENT_IS_CURSOR_SHOWING or not imports.isKeyOnHold("mouse1") or not imports.isUIValid(CLIENT_ATTACHED_ELEMENT.element) or not imports.isUIVisible(CLIENT_ATTACHED_ELEMENT.element) then
            if elementRoot then
                disableElementForceRender(elementRoot, true)
            end
            createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui["__UI_CACHE__"].updateElement = true
            imports.detachUIElement()
        else
            if elementRoot then
                if CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] then
                    CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = {
                        totalLiableElements = 0,
                        liableElements = {}
                    }
                end
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].isAttached = true
            end
            if not CLIENT_ATTACHED_ELEMENT.isInternal then
                local cursor_offsetX, cursor_offsetY = imports.getAbsoluteCursorPosition()
                if cursor_offsetX and cursor_offsetY then
                    local attached_offsetX, attached_offsetY = imports.interpolateBetween(createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.x, createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.y, 0, cursor_offsetX - CLIENT_ATTACHED_ELEMENT.offsetX, cursor_offsetY - CLIENT_ATTACHED_ELEMENT.offsetY, 0, 0.45, "InQuad")
                    createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.x, createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.y = imports.math.ceil(attached_offsetX), imports.math.ceil(attached_offsetY)
                    imports.updateElement(CLIENT_ATTACHED_ELEMENT.element)
                end
            end
        end
    end

    clickedMouseKey = (not CLIENT_ATTACHED_ELEMENT and imports.isMouseClicked())
    renderElements()
    if clickedMouseKey and CLIENT_HOVERED_ELEMENT.element then
        imports.resetKeyClickCache(clickedMouseKey)
        imports.triggerEvent("onClientUIClick", CLIENT_HOVERED_ELEMENT.element, (clickedMouseKey == "mouse1" and "left") or "right")
        clickedMouseKey = false
    end

    if not CLIENT_MTA_MINIMIZED and not CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loaded then
        if CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loadStatus == "initialized" then
            CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loadStatus = "reload"
        elseif CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loadStatus == "reload" then
            CLIENT_RESOURCE_TEMPLATE_RELOAD = {
                __cache = imports.cloneTableDatas(CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache, false)
            }
            CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loaded = true
            CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loadStatus = false
        end
    end
    CLIENT_MTA_RESTORED = false
    if not CLIENT_HOVERED_ELEMENT.element then
        CLIENT_HOVERED_ELEMENT.elementRoot = false
    end
    CLIENT_HOVERED_ELEMENT.element = false
    imports.resetKeyClickCache()
    imports.resetScrollCache()

end, false, UI_PRIORITY_LEVEL.RENDER)