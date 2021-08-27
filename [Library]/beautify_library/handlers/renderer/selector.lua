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
    renderElementChildren = renderElementChildren,
    setSelectorSelection = setSelectorSelection,
    unpackColor = unpackColor,
    isMouseOnPosition = isMouseOnPosition,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxDrawImage = dxDrawImage,
    dxDrawText = dxDrawText,
    math = {
        min = math.min
    }
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_selector"


------------------------------------
--[[ Function: Renders Selector ]]--
------------------------------------

function renderSelector(element, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
        local selector_type = elementReference.gui.type
        local selector_postGUI = elementReference.gui.postGUI

        if isElementToBeUpdated then
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
            local selector_startX, selector_startY = elementReference.gui.x, elementReference.gui.y
            local selector_width, selector_height = elementReference.gui.width, elementReference.gui.height
            local selector_arrow_size = availableElements[elementType].minimumSize
            local selector_arrow_icon_size = imports.math.min(selector_arrow_size, availableElements[elementType].arrowIconSize)
            local selector_content_padding = availableElements[elementType].contentSection.padding
            local selector_arrow_icon_padding = (selector_arrow_size - selector_arrow_icon_size)*0.5
            if selector_type == "horizontal" then
                local selector_arrow_offsetY = selector_startY + ((selector_height - selector_arrow_size)*0.5)
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX = selector_startX
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX = selector_startX + selector_width - elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = selector_startX + selector_arrow_size + selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = selector_startY + selector_content_padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = selector_startX + selector_width - selector_arrow_size - selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = selector_startY + selector_height - selector_content_padding
            elseif selector_type == "vertical" then
                local selector_arrow_offsetX = selector_startX + ((selector_width - selector_arrow_size)*0.5)
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY = selector_startY
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Previous"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY = selector_startY + selector_height - elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.height
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow Next"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = selector_startX + selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = selector_startY + selector_arrow_size + selector_content_padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = selector_startX + selector_width - selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = selector_startY + selector_height - selector_arrow_size - selector_content_padding
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
        if selector_type == "horizontal" then
            selector_arrow_prevIcon, selector_arrow_nextIcon = createdAssets["images"]["arrow/left.png"], createdAssets["images"]["arrow/right.png"]
        elseif selector_type == "vertical" then
            selector_arrow_prevIcon, selector_arrow_nextIcon = createdAssets["images"]["arrow/top.png"], createdAssets["images"]["arrow/bottom.png"]
        end
        if selector_arrow_prevIcon and selector_arrow_nextIcon then
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
            if elementReference.gui.arrow_Previous.hoverStatus == "forward" then
                if elementReference.gui.arrow_Previous.animAlphaPercent < 1 then
                    elementReference.gui.arrow_Previous.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Previous.animAlphaPercent, 0, 0, 1, 0, 0, imports.getInterpolationProgress(elementReference.gui.arrow_Previous.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
                end
            else
                if elementReference.gui.arrow_Previous.animAlphaPercent > 0 then
                    elementReference.gui.arrow_Previous.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Previous.animAlphaPercent, 0, 0, 0, 0, 0, imports.getInterpolationProgress(elementReference.gui.arrow_Previous.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
                end
            end
            if elementReference.gui.arrow_Next.hoverStatus == "forward" then
                if elementReference.gui.arrow_Next.animAlphaPercent < 1 then
                    elementReference.gui.arrow_Next.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Next.animAlphaPercent, 0, 0, 1, 0, 0, imports.getInterpolationProgress(elementReference.gui.arrow_Next.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
                end
            else
                if elementReference.gui.arrow_Next.animAlphaPercent > 0 then
                    elementReference.gui.arrow_Next.animAlphaPercent = imports.interpolateBetween(elementReference.gui.arrow_Next.animAlphaPercent, 0, 0, 0, 0, 0, imports.getInterpolationProgress(elementReference.gui.arrow_Next.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
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
            if not elementReference.gui.animAlphaPercent then
                elementReference.gui.animAlphaPercent = 0.8
                elementReference.gui.hoverStatus = "backward"
                elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
            end
            if elementReference.gui.hoverStatus == "forward" then
                if elementReference.gui.animAlphaPercent < 1 then
                    elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, imports.getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
                end
            else
                if elementReference.gui.animAlphaPercent > 0.8 then
                    elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.8, 0, 0, imports.getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
                end
            end
            local selector_fontColor = (elementReference.gui.fontColor and imports.tocolor(elementReference.gui.fontColor[1], elementReference.gui.fontColor[2], elementReference.gui.fontColor[3], elementReference.gui.fontColor[4]*elementReference.gui.animAlphaPercent)) or imports.tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Selector"].text.text, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY, selector_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, selector_postGUI, false)
        end
        imports.renderElementChildren(element)
        imports.dxSetBlendMode("blend")
        if not elementParent then
            imports.dxSetRenderTarget()
        else
            imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Arrow Previous"].offsets.startY and elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Arrow Next"].offsets.startY then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            imports.renderElementChildren(element, true, mouseReference)
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