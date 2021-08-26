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
    type = type,
    pairs = pairs,
    isElement = isElement,
    addEventHandler = addEventHandler,
    triggerEvent = triggerEvent,
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

local clickedMouseKey = false
CLIENT_ELEMENT_FORCE_RENDERED = {}


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
    for element, j in pairs(CLIENT_ELEMENT_FORCE_RENDERED) do
        if not preRenderedElements[element] then
            local elementType = createdElements[element].elementType
            availableElements[elementType].renderFunction(element)
            availableElements[elementType].renderFunction(element, true, {x = 0, y = 0, element = element})
        end
    end
    return true

end

function renderElementChildren(element, isFetchingInput, mouseReference)

    if not CLIENT_MTA_RESTORED then
        local elementRoot = createdElements[element].elementRoot
        local isElementForceRendered = (elementRoot and CLIENT_ELEMENT_FORCE_RENDERED[elementRoot]) or CLIENT_ELEMENT_FORCE_RENDERED[element]
        if not isElementForceRendered then
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

    local elementReference = createdElements[element]
    local elementChildrenCount = #elementReference.renderIndexReference[(elementReference.renderIndex)].children
    if elementChildrenCount <= 0 then return false end

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
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = nil
            end
            imports.detachUIElement()
        elseif CLIENT_MTA_WINDOW_ACTIVE or not CLIENT_IS_CURSOR_SHOWING or not imports.isKeyOnHold("mouse1") or not imports.isUIValid(CLIENT_ATTACHED_ELEMENT.element) or not imports.isUIVisible(CLIENT_ATTACHED_ELEMENT.element) then
            if elementRoot then
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = nil
            end
            createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui["__UI_CACHE__"].updateElement = true
            imports.detachUIElement()
        else
            if elementRoot then
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = true
            end
            if not CLIENT_ATTACHED_ELEMENT.isInternal then
                local cursor_offsetX, cursor_offsetY = imports.getAbsoluteCursorPosition()
                if cursor_offsetX and cursor_offsetY then
                    local attached_offsetX, attached_offsetY = imports.interpolateBetween(createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.x, createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.y, 0, cursor_offsetX - CLIENT_ATTACHED_ELEMENT.offsetX, cursor_offsetY - CLIENT_ATTACHED_ELEMENT.offsetY, 0, 0.45, "InQuad")
                    createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.x, createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui.y = imports.math.ceil(attached_offsetX), imports.math.ceil(attached_offsetY)
                    createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui["__UI_CACHE__"].updateElement = true
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

    if not CLIENT_MTA_MINIMIZED and not reloadResourceTemplates.__cache.loaded then
        if reloadResourceTemplates.__cache.loadStatus == "initialized" then
            reloadResourceTemplates.__cache.loadStatus = "reload"
        elseif reloadResourceTemplates.__cache.loadStatus == "reload" then
            reloadResourceTemplates = {
                __cache = imports.cloneTableDatas(reloadResourceTemplates.__cache, false)
            }
            reloadResourceTemplates.__cache.loaded = true
            reloadResourceTemplates.__cache.loadStatus = false
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