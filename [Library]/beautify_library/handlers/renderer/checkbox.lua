----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: checkbox.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Checkbox's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_checkbox"


------------------------------------
--[[ Function: Renders Checkbox ]]--
------------------------------------

function renderCheckbox(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = __getUIParent(element)
        if not elementParent then dxSetRenderTarget() end
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (reloadResourceTemplates[(elementReference.sourceResource)] and reloadResourceTemplates[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local checkbox_type = elementReference.gui.type
        local checkbox_postGUI = elementReference.gui.postGUI

        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Checkbox"] then
                elementReference.gui["__UI_CACHE__"]["Checkbox"] = {
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Tick Box"] = {
                    offsets = {},
                    icon = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Checkbox"] = {}
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"] = {}
            end
            local checkbox_startX, checkbox_startY = elementReference.gui.x, elementReference.gui.y
            local checkbox_width, checkbox_height = elementReference.gui.width, elementReference.gui.height
            local checkbox_tickbox_size = availableElements[elementType].minimumSize
            local checkbox_tickbox_icon_size = math.min(checkbox_tickbox_size, availableElements[elementType].tickboxSize)
            local checkbox_content_padding, checkbox_content_paddingLeft = availableElements[elementType].contentSection.padding, availableElements[elementType].contentSection.paddingLeft
            local checkbox_tickbox_icon_padding = (checkbox_tickbox_size - checkbox_tickbox_icon_size)*0.5
            local checkbox_tickbox_offsetY = checkbox_startY + ((checkbox_height - checkbox_tickbox_size)*0.5)
            elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.width = checkbox_tickbox_size
            elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.height = checkbox_tickbox_size
            elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.startX = checkbox_startX
            elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.startY = checkbox_tickbox_offsetY
            elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.width = checkbox_tickbox_icon_size
            elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.height = checkbox_tickbox_icon_size
            elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startX = elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.startX + checkbox_tickbox_icon_padding
            elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startY = elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.startY + checkbox_tickbox_icon_padding
            if elementReference.gui.text then
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.text = elementReference.gui.text
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startX = checkbox_startX + checkbox_tickbox_size + checkbox_content_paddingLeft
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startY = checkbox_startY + checkbox_content_padding + elementTemplate.fontPaddingY
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endX = checkbox_startX + checkbox_width - checkbox_content_padding
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endY = checkbox_startY + checkbox_height - checkbox_content_padding
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.isToBeRendered = ((elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endX - elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startX) > 0) and ((elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endY - elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startY) > 0)
            else
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.text = false
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startX = false
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startY = false
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endX = false
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endY = false
                elementReference.gui["__UI_CACHE__"]["Checkbox"].text.isToBeRendered = false
            end
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].startX = elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].startY = elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].width = elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].height = elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.height
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Tick Box"].color = tocolor(unpackColor(elementTemplate.tickBox.color))
                elementReference.gui["__UI_CACHE__"]["Tick Box"].iconColor = tocolor(unpack(elementTemplate.tickBox.iconColor))
            end
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if not elementReference.gui.tickBox.animAlphaPercent then
            elementReference.gui.tickBox.animAlphaPercent = 0
            elementReference.gui.tickBox.hoverStatus = "backward"
            elementReference.gui.tickBox.hoverAnimTickCounter = getTickCount()
        end
        if elementReference.gui.tickBox.hoverStatus == "forward" then
            elementReference.gui.tickBox.animAlphaPercent = interpolateBetween(elementReference.gui.tickBox.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.tickBox.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
        else
            elementReference.gui.tickBox.animAlphaPercent = interpolateBetween(elementReference.gui.tickBox.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.tickBox.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
        end
        if elementReference.gui.tickBox.animAlphaPercent < 1 then
            dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.height, elementReference.gui["__UI_CACHE__"]["Tick Box"].color, checkbox_postGUI)
            if elementReference.gui.tickBox.animAlphaPercent > 0 then
                dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.height, tocolor(elementTemplate.tickBox.iconColor[1], elementTemplate.tickBox.iconColor[2], elementTemplate.tickBox.iconColor[3], elementTemplate.tickBox.iconColor[4]*elementReference.gui.tickBox.animAlphaPercent), checkbox_postGUI)
            end
        else
            dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startX, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.startY, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.width, elementReference.gui["__UI_CACHE__"]["Tick Box"].icon.offsets.height, elementReference.gui["__UI_CACHE__"]["Tick Box"].iconColor, checkbox_postGUI)
        end
        if elementReference.gui["__UI_CACHE__"]["Checkbox"].text.isToBeRendered then
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
            local checkbox_fontColor = (elementReference.gui.fontColor and tocolor(elementReference.gui.fontColor[1], elementReference.gui.fontColor[2], elementReference.gui.fontColor[3], elementReference.gui.fontColor[4]*elementReference.gui.animAlphaPercent)) or tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            dxDrawText(elementReference.gui["__UI_CACHE__"]["Checkbox"].text.text, elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Checkbox"].text.offsets.endY, checkbox_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "left", "center", true, false, checkbox_postGUI, false)
        end
        renderElementChildren(element)
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Tick Box"].offsets.startY then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            renderElementChildren(element, true, mouseReference)
            local isElementHovered = CLIENT_HOVERED_ELEMENT == element
            local isCheckBoxHovered, isTickBoxHovered = false, false
            local isTickBoxSelected = elementReference.gui.selection
            if isElementHovered then
                if not elementReference.isDisabled then
                    isCheckBoxHovered = isElementHovered
                end
            end
            if isCheckBoxHovered then
                if elementReference.gui.hoverStatus ~= "forward" then
                    elementReference.gui.hoverStatus = "forward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
                isTickBoxHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Tick Box"].height)
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
            end
            if isTickBoxHovered or isTickBoxSelected then
                if isTickBoxHovered and isKeyClicked("mouse1") then
                    setCheckboxSelection(element, not isTickBoxSelected)
                end
                if elementReference.gui.tickBox.hoverStatus ~= "forward" then
                    elementReference.gui.tickBox.hoverStatus = "forward"
                    elementReference.gui.tickBox.hoverAnimTickCounter = getTickCount()
                end
            else
                if elementReference.gui.tickBox.hoverStatus ~= "backward" then
                    elementReference.gui.tickBox.hoverStatus = "backward"
                    elementReference.gui.tickBox.hoverAnimTickCounter = getTickCount()
                end
            end
        end
    end
    return true

end