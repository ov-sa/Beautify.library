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
    getUIAncestors = getUIAncestors,
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
        preRenderedElements = {},
        nextTickRemoval = {},
        structure = {
            totalChildren = 0,
            renderChildren = {}
        }
    }
}
local clickedMouseKey = false


---------------------------------------------------------
--[[ Functions: Manages Element's Force Render State ]]--
---------------------------------------------------------

function destroyElementForceRender(element, onNextTick)

    if onNextTick and CLIENT_ELEMENT_FORCE_RENDERED[element] then
        if not CLIENT_ELEMENT_FORCE_RENDERED.__cache.nextTickRemoval[element] then
            CLIENT_ELEMENT_FORCE_RENDERED.__cache.nextTickRemoval[element] = true
            return true
        end
    end
    CLIENT_ELEMENT_FORCE_RENDERED.__cache.nextTickRemoval[element] = nil
    CLIENT_ELEMENT_FORCE_RENDERED[element] = nil
    return true

end

function manageElementForceRender(element, renderState)

    local elementAncestors = imports.getUIAncestors(element)
    if not elementAncestors then return false end

    local totalAncestorsToBeRendered = #elementAncestors.ancestorIndex
    local elementRoot = elementAncestors.ancestorIndex[totalAncestorsToBeRendered]
    if renderState then
        if CLIENT_ELEMENT_FORCE_RENDERED.__cache.nextTickRemoval[elementRoot] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].isAttached = nil
            CLIENT_ELEMENT_FORCE_RENDERED.__cache.nextTickRemoval[elementRoot] = nil
        end
        if not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = imports.cloneTableDatas(CLIENT_ELEMENT_FORCE_RENDERED.__cache.structure, false)
        end
        if not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[element] then
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[element] = true
            CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren = CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren + 1
        end
        for i, j in imports.pairs(elementAncestors.ancestors) do
            if (i ~= elementRoot) and not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[i] then
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[i] = true
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren = CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren + 1
            end
        end
        return true
    else
        if CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] and not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].isAttached then
            if CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[element] then
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[element] = nil
                CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren = CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren - 1
                if CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].totalChildren <= 1 then
                    destroyElementForceRender(elementRoot)
                end
                return true
            end
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

    CLIENT_ELEMENT_FORCE_RENDERED.__cache.preRenderedElements = {}
    local validatedRenderingPriority = {}
    for i = 1, renderingPriorityCount, 1 do
        local element = createdRenderingPriority[i].element
        if imports.isUIValid(element) and imports.isUIVisible(element) then
            local elementType = createdElements[element].elementType
            availableElements[elementType].renderFunction(element, false)
            imports.table.insert(validatedRenderingPriority, {element = element, type = elementType})
        end
    end
    for i = #validatedRenderingPriority, 1, -1 do
        local element = validatedRenderingPriority[i].element
        if not CLIENT_HOVERED_ELEMENT.element and not imports.isUIDisabled(element) then
            local elementReference = createdElements[element]
            if imports.isMouseOnPosition(elementReference.gui.x, elementReference.gui.y, elementReference.gui.width, elementReference.gui.height) then
                local elementType = validatedRenderingPriority[i].type
                CLIENT_HOVERED_ELEMENT.elementRoot = element
                CLIENT_HOVERED_ELEMENT.element = element
                availableElements[elementType].renderFunction(element, false, true, {x = 0, y = 0, element = element})
                CLIENT_ELEMENT_FORCE_RENDERED.__cache.preRenderedElements[element] = true
                break
            end
        end
    end
    for element, _ in imports.pairs(CLIENT_ELEMENT_FORCE_RENDERED) do
        if (element ~= "__cache") and not CLIENT_ELEMENT_FORCE_RENDERED.__cache.preRenderedElements[element] then
            if not CLIENT_ELEMENT_FORCE_RENDERED.__cache.nextTickRemoval[element] and imports.isUIValid(element) and imports.isUIVisible(element) then
                local elementType = createdElements[element].elementType
                availableElements[elementType].renderFunction(element, false, true, {x = 0, y = 0, element = element})
            else
                destroyElementForceRender(element)
            end
        end
    end
    return true

end

function renderElementChildren(element, isPassiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    local elementChildrenCount = #elementReference.renderIndexReference[(elementReference.renderIndex)].children
    if elementChildrenCount <= 0 then return false end
    local elementRoot = elementReference.elementRoot or element
    local isElementRootHovered = CLIENT_HOVERED_ELEMENT.elementRoot == elementRoot
    local isChildrenToBeForceRendered = CLIENT_MTA_RESTORED or (not CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loaded and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)])
    if not isChildrenToBeForceRendered and not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] and not isElementRootHovered then
        return false
    end

    if not isFetchingInput then
        local element_renderTarget = elementReference.gui.renderTarget
        if not element_renderTarget or not imports.isElement(element_renderTarget) then return false end

        imports.dxSetRenderTarget(element_renderTarget, true)
        imports.dxSetBlendMode("modulate_add")
        for i = 1, elementChildrenCount, 1 do
            --TODO: NEEDS TO BE BETTER CODED, Add passive mode drawing feature...
            --if isChildrenToBeForceRendered or not elementReference.elementRoot or isElementRootHovered then
                local childElement = elementReference.renderIndexReference[(elementReference.renderIndex)].children[i].element
                if imports.isUIValid(childElement) and imports.isUIVisible(childElement) then
                    local childElementType = createdElements[childElement].elementType
                    availableElements[childElementType].renderFunction(childElement, isPassiveMode)
                    imports.dxSetRenderTarget(element_renderTarget)
                    imports.dxSetBlendMode("modulate_add")
                end
            --end
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
            if isChildrenToBeForceRendered or isElementRootHovered or (CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] and CLIENT_ELEMENT_FORCE_RENDERED[elementRoot].renderChildren[childElement]) then
                if imports.isUIValid(childElement) and imports.isUIVisible(childElement) then
                    local childElementType = createdElements[childElement].elementType
                    local childReference = createdElements[childElement]
                    if imports.isMouseOnPosition(propagatedMouseReference.x + childReference.gui.x, propagatedMouseReference.y + childReference.gui.y, childReference.gui.width, childReference.gui.height, childReference.gui.height) then
                        CLIENT_HOVERED_ELEMENT.element = childElement
                    end
                    availableElements[childElementType].renderFunction(childElement, false, true, propagatedMouseReference)
                end
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
                destroyElementForceRender(elementRoot)
            end
            imports.detachUIElement()
        elseif CLIENT_MTA_WINDOW_ACTIVE or not CLIENT_IS_CURSOR_SHOWING or not imports.isKeyOnHold("mouse1") or not imports.isUIValid(CLIENT_ATTACHED_ELEMENT.element) or not imports.isUIVisible(CLIENT_ATTACHED_ELEMENT.element) then
            if elementRoot then
                destroyElementForceRender(elementRoot, true)
            end
            createdElements[(CLIENT_ATTACHED_ELEMENT.element)].gui["__UI_CACHE__"].updateElement = true
            imports.detachUIElement()
        else
            if elementRoot then
                if not CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] then
                    CLIENT_ELEMENT_FORCE_RENDERED[elementRoot] = imports.cloneTableDatas(CLIENT_ELEMENT_FORCE_RENDERED.__cache.structure, false)
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