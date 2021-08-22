----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: selector.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Selector's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_selector"


------------------------------------
--[[ Function: Renders Selector ]]--
------------------------------------

function renderSelector(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = __getUIParent(element)
        if not elementParent then dxSetRenderTarget() end
        local isElementToBeReloaded = elementReference.gui["__UI_CACHE__"].reloadElement
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local selector_type = elementReference.gui.type
        local selector_postGUI = elementReference.gui.postGUI

        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Selector"] then
                elementReference.gui["__UI_CACHE__"]["Selector"] = {
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"] = {
                    offsets = {},
                    icon = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"] = {
                    offsets = {},
                    icon = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"] = {}
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"] = {}
            end
            local selector_startX, selector_startY = elementReference.gui.x, elementReference.gui.y
            local selector_width, selector_height = elementReference.gui.width, elementReference.gui.height
            local selector_arrow_size = availableElements[elementType].minimumSize
            local selector_arrow_icon_size = math.min(selector_arrow_size, availableElements[elementType].minimumArrowSize)
            local selector_content_padding = availableElements[elementType].contentSection.padding
            local selector_arrow_icon_padding = (selector_arrow_size - selector_arrow_icon_size)*0.5
            if selector_type == "horizontal" then
                local selector_arrow_offsetY = selector_startY + ((selector_height - selector_arrow_size)*0.5)
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX = selector_startX
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY + selector_arrow_icon_padding                
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX = selector_startX + selector_width - elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = selector_startX + selector_arrow_size + selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = selector_startY + selector_content_padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = selector_startX + selector_width - selector_arrow_size - selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = selector_startY + selector_height - selector_content_padding
            elseif selector_type == "vertical" then
                local selector_arrow_offsetX = selector_startX + ((selector_width - selector_arrow_size)*0.5)
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY = selector_startY
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY = selector_startY + selector_height - elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.width = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.height = selector_arrow_icon_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY + selector_arrow_icon_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = selector_startX + selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = selector_startY + selector_arrow_size + selector_content_padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = selector_startX + selector_width - selector_content_padding
                elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = selector_startY + selector_height - selector_arrow_size - selector_content_padding
            end
            local slider_text = (elementReference.selectorDataList.selection and elementReference.selectorDataList.list[elementReference.selectorDataList.selection]) or "-"
            elementReference.gui["__UI_CACHE__"]["Selector"].text.text = ((elementReference.gui.text and elementReference.gui.text.." | ") or "")..slider_text
            elementReference.gui["__UI_CACHE__"]["Selector"].text.isToBeRendered = ((elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX - elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX) > 0) and ((elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY - elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY) > 0)
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].startX = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].startY = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].width = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].height = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].startX = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].startY = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].width = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].height = elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].color = tocolor(unpackColor(elementTemplate.color))
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].color = elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].color
            end
            elementReference.gui["__UI_CACHE__"].reloadElement = nil
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
                elementReference.gui.arrow_Previous.hoverAnimTickCounter = getTickCount()
            end
            if not elementReference.gui.arrow_Next.animAlphaPercent then
                elementReference.gui.arrow_Next.animAlphaPercent = 0
                elementReference.gui.arrow_Next.hoverStatus = "backward"
                elementReference.gui.arrow_Next.hoverAnimTickCounter = getTickCount()
            end
            if elementReference.gui.arrow_Previous.hoverStatus == "forward" then
                elementReference.gui.arrow_Previous.animAlphaPercent = interpolateBetween(elementReference.gui.arrow_Previous.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.arrow_Previous.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            else
                elementReference.gui.arrow_Previous.animAlphaPercent = interpolateBetween(elementReference.gui.arrow_Previous.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.arrow_Previous.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            end
            if elementReference.gui.arrow_Next.hoverStatus == "forward" then
                elementReference.gui.arrow_Next.animAlphaPercent = interpolateBetween(elementReference.gui.arrow_Next.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.arrow_Next.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            else
                elementReference.gui.arrow_Next.animAlphaPercent = interpolateBetween(elementReference.gui.arrow_Next.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.arrow_Next.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            end
            dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.height, selector_arrow_prevIcon, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].color, slider_postGUI)
            dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.height, selector_arrow_nextIcon, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].color, slider_postGUI)
            if elementReference.gui.arrow_Previous.animAlphaPercent > 0 then
                dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].icon.offsets.height, selector_arrow_prevIcon, 0, 0, 0, tocolor(elementTemplate.hoverColor[1], elementTemplate.hoverColor[2], elementTemplate.hoverColor[3], elementTemplate.hoverColor[4]*elementReference.gui.arrow_Previous.animAlphaPercent), slider_postGUI)
            end
            if elementReference.gui.arrow_Next.animAlphaPercent > 0 then
                dxDrawImage(elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].icon.offsets.height, selector_arrow_nextIcon, 0, 0, 0, tocolor(elementTemplate.hoverColor[1], elementTemplate.hoverColor[2], elementTemplate.hoverColor[3], elementTemplate.hoverColor[4]*elementReference.gui.arrow_Next.animAlphaPercent), slider_postGUI)
            end
        end
        if elementReference.gui["__UI_CACHE__"]["Selector"].text.isToBeRendered then
            if not elementReference.gui.animAlphaPercent then
                elementReference.gui.animAlphaPercent = 0.8
                elementReference.gui.hoverStatus = "backward"
                elementReference.gui.hoverAnimTickCounter = getTickCount()
            end
            if elementReference.gui.hoverStatus == "forward" then
                elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            else
                elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.8, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            end
            local selector_fontColor = (elementReference.gui.fontColor and tocolor(elementReference.gui.fontColor[1], elementReference.gui.fontColor[2], elementReference.gui.fontColor[3], elementReference.gui.fontColor[4]*elementReference.gui.animAlphaPercent)) or tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            dxDrawText(elementReference.gui["__UI_CACHE__"]["Selector"].text.text, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY, selector_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, selector_postGUI, false)
        end
        renderElementChildren(element)
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY and elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            renderElementChildren(element, true, mouseReference)
            local isElementHovered = CLIENT_HOVERED_ELEMENT == element
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
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
                isArrowPreviousHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"].height)
                isArrowNextHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"].height)
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
            end
            if isArrowPreviousHovered then
                if isKeyClicked("mouse1") then
                    local currentSelection = getSelectorSelection(element)
                    if currentSelection then
                        setSelectorSelection(element, currentSelection - 1)
                    end
                end
                if elementReference.gui.arrow_Previous.hoverStatus ~= "forward" then
                    elementReference.gui.arrow_Previous.hoverStatus = "forward"
                    elementReference.gui.arrow_Previous.hoverAnimTickCounter = getTickCount()
                end
            else
                if elementReference.gui.arrow_Previous.hoverStatus ~= "backward" then
                    elementReference.gui.arrow_Previous.hoverStatus = "backward"
                    elementReference.gui.arrow_Previous.hoverAnimTickCounter = getTickCount()
                end
            end
            if isArrowNextHovered then
                if isKeyClicked("mouse1") then
                    local currentSelection = getSelectorSelection(element)
                    if currentSelection then
                        setSelectorSelection(element, currentSelection + 1)
                    end
                end
                if elementReference.gui.arrow_Next.hoverStatus ~= "forward" then
                    elementReference.gui.arrow_Next.hoverStatus = "forward"
                    elementReference.gui.arrow_Next.hoverAnimTickCounter = getTickCount()
                end
            else
                if elementReference.gui.arrow_Next.hoverStatus ~= "backward" then
                    elementReference.gui.arrow_Next.hoverStatus = "backward"
                    elementReference.gui.arrow_Next.hoverAnimTickCounter = getTickCount()
                end
            end
        end
    end
    return true

end