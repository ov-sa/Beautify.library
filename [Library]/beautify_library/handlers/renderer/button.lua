----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: button.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Button's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_button"


----------------------------------
--[[ Function: Renders Button ]]--
----------------------------------

function renderButton(element, isFetchingInput, mouseReference)

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
        local button_width, button_height = elementReference.gui.size or elementReference.gui.width, elementReference.gui.size or elementReference.gui.height

        if button_width and button_height then
            local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
            local button_type = elementReference.gui.type
            elementTemplate = elementTemplate[button_type]
            local button_postGUI = elementReference.gui.postGUI
            if isElementToBeUpdated then
                if not elementReference.gui["__UI_CACHE__"]["Button"] then
                    elementReference.gui["__UI_CACHE__"]["Button"] = {
                        offsets = {},
                        text = {
                            offsets = {}
                        }
                    }
                end
                local button_startX, button_startY = elementReference.gui.x, elementReference.gui.y
                local button_content_padding = availableElements[elementType].contentSection.paddingX
                elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX = button_startX
                elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY = button_startY
                elementReference.gui["__UI_CACHE__"]["Button"].offsets.width = button_width
                elementReference.gui["__UI_CACHE__"]["Button"].offsets.height = button_height
                elementReference.gui["__UI_CACHE__"]["Button"].text.text = elementReference.gui.text
                elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX + button_content_padding
                elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY + (elementTemplate.fontPaddingY or 0)
                elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Button"].offsets.width - button_content_padding
                elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Button"].offsets.height
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width = elementReference.gui["__UI_CACHE__"]["Button"].offsets.width
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height = elementReference.gui["__UI_CACHE__"]["Button"].offsets.height
                if not elementReference.gui["__UI_CACHE__"]["Button"].renderTexture then
                    if not elementReference.gui["__UI_CACHE__"]["Button"].renderTarget then
                        elementReference.gui["__UI_CACHE__"]["Button"].renderTarget = DxRenderTarget(button_width, button_height, true)
                    end
                    if elementReference.gui["__UI_CACHE__"]["Button"].renderTexture and isElement(elementReference.gui["__UI_CACHE__"]["Button"].renderTexture) then
                        elementReference.gui["__UI_CACHE__"]["Button"].renderTexture:destroy()
                        elementReference.gui["__UI_CACHE__"]["Button"].renderTexture = nil
                    end
                    dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Button"].renderTarget, true)
                    dxSetBlendMode("modulate_add")
                    if button_type == "default" then
                        local button_borderSize = availableElements[elementType].minimumSize*0.5
                        dxDrawImage(0, 0, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/top_left.png"], 0, 0, 0, -1, false)
                        dxDrawImage(button_width - button_borderSize, 0, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/top_right.png"], 0, 0, 0, -1, false)
                        dxDrawImage(0, button_height - button_borderSize, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/bottom_left.png"], 0, 0, 0, -1, false)
                        dxDrawImage(button_width - button_borderSize, button_height - button_borderSize, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/bottom_right.png"], 0, 0, 0, -1, false)
                        if button_width > availableElements[elementType].minimumSize then
                            dxDrawRectangle(button_borderSize, 0, button_width - availableElements[elementType].minimumSize, button_height, -1, false)
                        end
                        if button_height > availableElements[elementType].minimumSize then
                            dxDrawRectangle(0, button_borderSize, button_borderSize, button_height - availableElements[elementType].minimumSize, -1, false)
                            dxDrawRectangle(button_width - button_borderSize, button_borderSize, button_borderSize, button_height - availableElements[elementType].minimumSize, -1, false)
                        end
                    end
                    dxSetBlendMode("blend")
                    if not elementParent then
                        dxSetRenderTarget()
                    else
                        dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
                    end
                    local renderPixels = dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Button"].renderTarget)
                    if renderPixels then
                        elementReference.gui["__UI_CACHE__"]["Button"].renderTexture = DxTexture(renderPixels, "argb", false, "clamp")
                        elementReference.gui["__UI_CACHE__"]["Button"].renderTarget:destroy()
                        elementReference.gui["__UI_CACHE__"]["Button"].renderTarget = nil
                    end
                end
                if not CLIENT_MTA_MINIMIZED then
                    elementReference.gui["__UI_CACHE__"].reloadElement = nil
                end
                elementReference.gui["__UI_CACHE__"].updateElement = nil
            end

            if not elementReference.gui.animAlphaPercent then
                elementReference.gui.animAlphaPercent = 0.25
                elementReference.gui.hoverStatus = "backward"
                elementReference.gui.hoverAnimTickCounter = getTickCount()
            end
            if elementReference.gui.hoverStatus == "forward" then
                elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            else
                elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.25, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
            end
            local button_fontColor = tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            if elementReference.gui["__UI_CACHE__"]["Button"].renderTexture then
                dxDrawImage(elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Button"].offsets.width, elementReference.gui["__UI_CACHE__"]["Button"].offsets.height, elementReference.gui["__UI_CACHE__"]["Button"].renderTexture, 0, 0, 0, tocolor(elementTemplate.color[1], elementTemplate.color[2], elementTemplate.color[3], elementTemplate.color[4]*math.max(0.3, elementReference.gui.animAlphaPercent)), button_postGUI)
            end
            dxDrawText(elementReference.gui["__UI_CACHE__"]["Button"].text.text, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endY, button_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, button_postGUI, false)
            renderElementChildren(element)
            dxSetBlendMode("blend")
            if not elementParent then
                dxSetRenderTarget()
            else
                dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Button"].offsets.width and elementReference.gui["__UI_CACHE__"]["Button"].offsets.height then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            renderElementChildren(element, true, mouseReference)
            local isElementHovered = CLIENT_HOVERED_ELEMENT == element
            local isButtonHovered = false
            if isElementHovered then
                if not elementReference.isDisabled then
                    isButtonHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height)
                end
            end
            if isButtonHovered then
                if elementReference.gui.hoverStatus ~= "forward" then
                    elementReference.gui.hoverStatus = "forward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
            end
        end
    end
    return true

end