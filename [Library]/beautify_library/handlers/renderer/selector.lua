----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: selector.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Selector's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    isKeyClicked = isKeyClicked,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    manageElementForceRender = manageElementForceRender,
    setSelectorSelection = setSelectorSelection,
    unpackColor = unpackColor,
    isMouseOnPosition = isMouseOnPosition,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxSetRenderTarget = dxSetRenderTarget,
    dxDrawImage = dxDrawImage,
    dxDrawText = dxDrawText,
    math = math
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_selector"


------------------------------------
--[[ Function: Renders Selector ]]--
------------------------------------

function renderSelector(element, isActiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementToBeRendered, isElementToBeForceRendered = true, false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)

        if not isElementToBeRendered then return false end
        if (isActiveMode or isElementToBeReloaded) and isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Selector"] then
                elementReference.gui["__UI_CACHE__"]["Selector"] = {
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"] = {
                    offsets = {},
                    icon = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Arrow Next"] = {
                    offsets = {},
                    icon = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"] = {}
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"] = {}
            end
            local selector_arrow_icon_size = imports.math.min(availableElements[elementType].minimumSize, availableElements[elementType].arrowIconSize)
            local selector_arrow_icon_padding = (availableElements[elementType].minimumSize - selector_arrow_icon_size)*0.5
            if elementReference.gui.type == "horizontal" then
                local selector_arrow_offsetY = elementReference.gui.y + ((elementReference.gui.height - availableElements[elementType].minimumSize)*0.5)
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.width = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.height = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX = elementReference.gui.x
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX = elementReference.gui.x + elementReference.gui.width - elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = elementReference.gui.x + availableElements[elementType].minimumSize + availableElements[elementType].viewSection.padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = elementReference.gui.y + availableElements[elementType].viewSection.padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = elementReference.gui.x + elementReference.gui.width - availableElements[elementType].minimumSize - availableElements[elementType].viewSection.padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = elementReference.gui.y + elementReference.gui.height - availableElements[elementType].viewSection.padding
            elseif elementReference.gui.type == "vertical" then
                local selector_arrow_offsetX = elementReference.gui.x + ((elementReference.gui.width - availableElements[elementType].minimumSize)*0.5)
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.width = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.height = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY = elementReference.gui.y
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height = availableElements[elementType].minimumSize
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY = elementReference.gui.y + elementReference.gui.height - elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = elementReference.gui.x + availableElements[elementType].viewSection.padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = elementReference.gui.y + availableElements[elementType].minimumSize + availableElements[elementType].viewSection.padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = elementReference.gui.x + elementReference.gui.width - availableElements[elementType].viewSection.padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = elementReference.gui.y + elementReference.gui.height - availableElements[elementType].minimumSize - availableElements[elementType].viewSection.padding
            end
            local slider_text = (elementReference.selectorDataList.selection and elementReference.selectorDataList.list[elementReference.selectorDataList.selection]) or "-"
            elementReference.gui["__UI_CACHE__"]["Selector"].text.text = ((elementReference.gui.text and elementReference.gui.text.." | ") or "")..slider_text
            elementReference.gui["__UI_CACHE__"]["Selector"].text.isToBeRendered = ((elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX - elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX) > 0) and ((elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY - elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY) > 0)
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].startX = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].startY = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].width = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].height = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].startX = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].startY = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].width = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].height = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].color = imports.tocolor(imports.unpackColor(elementTemplate.color))
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].color = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].color
            end
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        local selector_arrow_prevIcon, selector_arrow_nextIcon = false, false
        if elementReference.gui.type == "horizontal" then
            selector_arrow_prevIcon, selector_arrow_nextIcon = createdAssets["images"]["arrow/left.rw"], createdAssets["images"]["arrow/right.rw"]
        elseif elementReference.gui.type == "vertical" then
            selector_arrow_prevIcon, selector_arrow_nextIcon = createdAssets["images"]["arrow/top.rw"], createdAssets["images"]["arrow/bottom.rw"]
        end
        if selector_arrow_prevIcon and selector_arrow_nextIcon then
            if isActiveMode then
                if not elementReference.gui.arrow_Previous.animAlphaPercent then
                    elementReference.gui.arrow_Previous.animAlphaPercent = 0
                    elementReference.gui.arrow_Previous.hoverStatus = "backward"
                    elementReference.gui.arrow_Previous.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
                if not elementReference.gui.arrow_Next.animAlphaPercent then
                    elementReference.gui.arrow_Next.animAlphaPercent = 0
                    elementReference.gui.arrow_Next.hoverStatus = "backward"
                    elementReference.gui.arrow_Next.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
                elementReference.gui.arrow_Previous.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.arrow_Previous.hoverAnimTickCounter, availableElements[elementType].viewSection.hoverAnimDuration)
                local isPrevArrowHoverInterpolationRendering = elementReference.gui.arrow_Previous.interpolationProgress < 1
                isElementToBeForceRendered = isElementToBeForceRendered or isPrevArrowHoverInterpolationRendering or (elementReference.gui.arrow_Previous.hoverStatus ~= "backward")
                if isElementInterpolationToBeRefreshed or isPrevArrowHoverInterpolationRendering then
                    if elementReference.gui.arrow_Previous.hoverStatus == "forward" then
                        elementReference.gui.arrow_Previous.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Previous.animAlphaPercent, 0, 0, 1, 0, 0, elementReference.gui.arrow_Previous.interpolationProgress, "InQuad")
                    else
                        elementReference.gui.arrow_Previous.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Previous.animAlphaPercent, 0, 0, 0, 0, 0, elementReference.gui.arrow_Previous.interpolationProgress, "InQuad")
                    end
                end
                elementReference.gui.arrow_Next.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.arrow_Next.hoverAnimTickCounter, availableElements[elementType].viewSection.hoverAnimDuration)
                local isNextArrowHoverInterpolationRendering = elementReference.gui.arrow_Next.interpolationProgress < 1
                isElementToBeForceRendered = isElementToBeForceRendered or isNextArrowHoverInterpolationRendering or (elementReference.gui.arrow_Next.hoverStatus ~= "backward")
                if isElementInterpolationToBeRefreshed or isNextArrowHoverInterpolationRendering then
                    if elementReference.gui.arrow_Next.hoverStatus == "forward" then
                        elementReference.gui.arrow_Next.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Next.animAlphaPercent, 0, 0, 1, 0, 0, elementReference.gui.arrow_Next.interpolationProgress, "InQuad")
                    else
                        elementReference.gui.arrow_Next.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Next.animAlphaPercent, 0, 0, 0, 0, 0, elementReference.gui.arrow_Next.interpolationProgress, "InQuad")
                    end
                end
            end
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.height, selector_arrow_prevIcon, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].color, slider_postGUI)
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.height, selector_arrow_nextIcon, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Arrow Next"].color, slider_postGUI)
            if elementReference.gui.arrow_Previous.animAlphaPercent > 0 then
                imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.height, selector_arrow_prevIcon, 0, 0, 0, imports.tocolor(elementTemplate.hoverColor[1], elementTemplate.hoverColor[2], elementTemplate.hoverColor[3], elementTemplate.hoverColor[4]*elementReference.gui.arrow_Previous.animAlphaPercent), slider_postGUI)
            end
            if elementReference.gui.arrow_Next.animAlphaPercent > 0 then
                imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.height, selector_arrow_nextIcon, 0, 0, 0, imports.tocolor(elementTemplate.hoverColor[1], elementTemplate.hoverColor[2], elementTemplate.hoverColor[3], elementTemplate.hoverColor[4]*elementReference.gui.arrow_Next.animAlphaPercent), slider_postGUI)
            end
        end
        if elementReference.gui["__UI_CACHE__"]["Selector"].text.isToBeRendered then
            if isActiveMode then
                if not elementReference.gui.animAlphaPercent then
                    elementReference.gui.animAlphaPercent = 0.8
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
                elementReference.gui.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].viewSection.hoverAnimDuration)
                local isTextHoverInterpolationRendering = elementReference.gui.interpolationProgress < 1
                isElementToBeForceRendered = isElementToBeForceRendered or isTextHoverInterpolationRendering or (elementReference.gui.hoverStatus ~= "backward")
                if isElementInterpolationToBeRefreshed or isTextHoverInterpolationRendering then
                    if elementReference.gui.hoverStatus == "forward" then
                        elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, elementReference.gui.interpolationProgress, "InQuad")
                    else
                        elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.8, 0, 0, elementReference.gui.interpolationProgress, "InQuad")
                    end
                end
            end
            local selector_fontColor = (elementReference.gui.fontColor and imports.tocolor(elementReference.gui.fontColor[1], elementReference.gui.fontColor[2], elementReference.gui.fontColor[3], elementReference.gui.fontColor[4]*elementReference.gui.animAlphaPercent)) or imports.tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Selector"].text.text, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY, selector_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, elementReference.gui.postGUI, false)
        end
        if isActiveMode then
            imports.manageElementForceRender(element, isElementToBeForceRendered)
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY and elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
            local isSelectorHovered = false
            local isArrowPreviousHovered, isArrowNextHovered = false, false
            if isElementHovered then
                if not elementReference.isDisabled then
                    isSelectorHovered = isElementHovered
                end
            end
            if isSelectorHovered then
                if elementReference.gui.hoverStatus ~= "forward" then
                    elementReference.gui.hoverStatus = "forward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
                isArrowPreviousHovered = imports.isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Previous"].height)
                isArrowNextHovered = imports.isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow Next"].height)
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            end
            if isArrowPreviousHovered then
                if imports.isKeyClicked("mouse1") then
                    local currentSelection = elementReference.selectorDataList.selection
                    if currentSelection then
                        imports.setSelectorSelection(element, currentSelection - 1)
                    end
                end
                if elementReference.gui.arrow_Previous.hoverStatus ~= "forward" then
                    elementReference.gui.arrow_Previous.hoverStatus = "forward"
                    elementReference.gui.arrow_Previous.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            else
                if elementReference.gui.arrow_Previous.hoverStatus ~= "backward" then
                    elementReference.gui.arrow_Previous.hoverStatus = "backward"
                    elementReference.gui.arrow_Previous.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            end
            if isArrowNextHovered then
                if imports.isKeyClicked("mouse1") then
                    local currentSelection = elementReference.selectorDataList.selection
                    if currentSelection then
                        imports.setSelectorSelection(element, currentSelection + 1)
                    end
                end
                if elementReference.gui.arrow_Next.hoverStatus ~= "forward" then
                    elementReference.gui.arrow_Next.hoverStatus = "forward"
                    elementReference.gui.arrow_Next.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            else
                if elementReference.gui.arrow_Next.hoverStatus ~= "backward" then
                    elementReference.gui.arrow_Next.hoverStatus = "backward"
                    elementReference.gui.arrow_Next.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            end
        end
    end
    return true

end