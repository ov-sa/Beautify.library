----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_window"


----------------------------------
--[[ Function: Renders Window ]]--
----------------------------------

function renderWindow(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = __getUIParent(element)
        if not elementParent then dxSetRenderTarget() end
        local isElementToBeUpdated = elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local window_titleBar_divider_size, window_titleBar_divider_color = elementTemplate.titleBar.divider.size, ((elementReference.gui["__UI_CACHE__"]["Window"] and elementReference.gui["__UI_CACHE__"]["Window"].divider.color) or tocolor(unpackColor(elementTemplate.titleBar.divider.color)))
        local window_postGUI = elementReference.gui.postGUI
        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Window"] then
                elementReference.gui["__UI_CACHE__"]["Window"] = {
                    offsets = {},
                    divider = {},
                    view = {
                        offsets = {}
                    }
                }
            end
            if not elementReference.gui["__UI_CACHE__"]["Title Bar"] then
                elementReference.gui["__UI_CACHE__"]["Title Bar"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
            end
            if not elementReference.gui["__UI_CACHE__"]["Close Button"] then
                elementReference.gui["__UI_CACHE__"]["Close Button"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
            end
            if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"] then
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"] = {}
            end
            if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"] then
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"] = {}
            end
            local window_startX, window_startY = elementReference.gui.x, elementReference.gui.y
            local window_width, window_height = elementReference.gui.width, elementReference.gui.height
            local window_view_width, window_view_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            local window_borderSize = availableElements[elementType].minimumSize*0.5
            elementReference.gui["__UI_CACHE__"]["Window"].offsets.startX = window_startX
            elementReference.gui["__UI_CACHE__"]["Window"].offsets.startY = window_startY
            elementReference.gui["__UI_CACHE__"]["Window"].offsets.width = window_width
            elementReference.gui["__UI_CACHE__"]["Window"].offsets.height = window_height
            --TODO: ONLY ON TEMPLATE UPDATE
            elementReference.gui["__UI_CACHE__"]["Window"].divider.fontColor = window_titleBar_divider_color
            ---
            elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Window"].offsets.startX + elementReference.gui.contentSection.startX
            elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Window"].offsets.startY + elementReference.gui.contentSection.startY
            elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.width = window_view_width
            elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.height = window_view_height
            local window_titleBar_paddingX = availableElements[elementType].titleBar.paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX = elementReference.gui["__UI_CACHE__"]["Window"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY = elementReference.gui["__UI_CACHE__"]["Window"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width = elementReference.gui["__UI_CACHE__"]["Window"].offsets.width
            elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height = window_borderSize
            --TODO: ADD UPDATE ONLY ON TEMPLATE CHANGE...
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding = ""
            while dxGetTextWidth(elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding, 1, elementTemplate.titleBar.font) < window_borderSize do
                elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding = elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding.." "
            end
            ---
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.text = elementReference.gui["__UI_CACHE__"]["Title Bar"].text.padding..elementReference.gui.title
            --TODO: ADD UPDATE ONLY ON TEMPLATE CHANGE...
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.fontColor = tocolor(unpackColor(elementTemplate.titleBar.fontColor))
            ----
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + window_titleBar_paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY + (elementTemplate.titleBar.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height - window_titleBar_paddingX
            elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].width = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].height = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.width - elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height = elementReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.text = "X"
            --TODO: ADD UPDATE ONLY ON TEMPLATE CHANGE...
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.fontColor = tocolor(unpackColor(elementTemplate.titleBar.close_button.fontColor))
            ---
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY + (elementTemplate.titleBar.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width
            elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startX = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startY = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].width = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].height = elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height
            if not elementReference.gui["__UI_CACHE__"]["Window"].renderTexture or elementReference.gui["__UI_CACHE__"]["Window"].updateTexture then
                if not elementReference.gui["__UI_CACHE__"]["Window"].renderTarget then
                    elementReference.gui["__UI_CACHE__"]["Window"].renderTarget = DxRenderTarget(window_width, window_height, true)
                end
                if elementReference.gui["__UI_CACHE__"]["Window"].updateTexture then
                    if elementReference.gui["__UI_CACHE__"]["Window"].renderTexture and isElement(elementReference.gui["__UI_CACHE__"]["Window"].renderTexture) then
                        elementReference.gui["__UI_CACHE__"]["Window"].renderTexture:destroy()
                        elementReference.gui["__UI_CACHE__"]["Window"].renderTexture = nil
                    end
                end
                dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Window"].renderTarget, true)
                dxSetBlendMode("modulate_add")
                local window_color, window_titleBar_color = tocolor(unpackColor(elementTemplate.color)), tocolor(unpackColor(elementTemplate.titleBar.color))
                dxDrawImage(0, 0, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/regular/top_left.png"], 0, 0, 0, window_titleBar_color, false)
                dxDrawImage(window_width - window_borderSize, 0, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/regular/top_right.png"], 0, 0, 0, window_titleBar_color, false)
                dxDrawImage(0, window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/regular/bottom_left.png"], 0, 0, 0, window_color, false)
                dxDrawImage(window_width - window_borderSize, window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/regular/bottom_right.png"], 0, 0, 0, window_color, false)
                if window_width > availableElements[elementType].minimumSize then
                    dxDrawRectangle(window_borderSize, 0, window_width - availableElements[elementType].minimumSize, window_borderSize, window_titleBar_color, false)
                    dxDrawRectangle(window_borderSize, window_height - window_borderSize, window_width - availableElements[elementType].minimumSize, window_borderSize, window_color, false)
                end
                if window_height > availableElements[elementType].minimumSize then
                    dxDrawRectangle(0, window_borderSize, window_borderSize, window_height - availableElements[elementType].minimumSize, window_color, false)
                    dxDrawRectangle(window_width - window_borderSize, window_borderSize, window_borderSize, window_height - availableElements[elementType].minimumSize, window_color, false)
                end
                if window_width > availableElements[elementType].minimumSize and window_height > availableElements[elementType].minimumSize then
                    dxDrawRectangle(window_borderSize, window_borderSize, window_width - availableElements[elementType].minimumSize, window_height - availableElements[elementType].minimumSize, window_color, false)
                end
                dxDrawRectangle(0, window_borderSize, window_width, window_titleBar_divider_size, window_titleBar_divider_color, false)    
                dxSetBlendMode("blend")
                dxSetRenderTarget()
                local renderPixels = dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Window"].renderTarget)
                if renderPixels then
                    elementReference.gui["__UI_CACHE__"]["Window"].renderTexture = DxTexture(renderPixels, "argb", false, "clamp")
                    elementReference.gui["__UI_CACHE__"]["Window"].renderTarget:destroy()
                    elementReference.gui["__UI_CACHE__"]["Window"].renderTarget = nil
                    elementReference.gui["__UI_CACHE__"]["Window"].updateTexture = nil
                end
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end
        if not elementReference.gui.titleBar.close_button.animAlphaPercent then
            elementReference.gui.titleBar.close_button.animAlphaPercent = 0
            elementReference.gui.titleBar.close_button.hoverStatus = "backward"
            elementReference.gui.titleBar.close_button.hoverAnimTickCounter = getTickCount()
        end
        if elementReference.gui.titleBar.close_button.hoverStatus == "forward" then
            elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements[elementType].titleBar.close_button.hoverAnimDuration), "InQuad")
        else
            elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements[elementType].titleBar.close_button.hoverAnimDuration), "InQuad")
        end
        if elementReference.gui["__UI_CACHE__"]["Window"].renderTexture then
            dxDrawImage(elementReference.gui["__UI_CACHE__"]["Window"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Window"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Window"].offsets.width, elementReference.gui["__UI_CACHE__"]["Window"].offsets.height, elementReference.gui["__UI_CACHE__"]["Window"].renderTexture, 0, 0, 0, -1, window_postGUI)
        end
        local isRenderCloseButtonHover = elementReference.gui.titleBar.close_button.animAlphaPercent > 0
        dxDrawText(elementReference.gui["__UI_CACHE__"]["Title Bar"].text.text, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Title Bar"].text.fontColor, elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, window_postGUI, false)
        if isRenderCloseButtonHover then    
            dxDrawImage(elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.width, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height, createdAssets["images"]["curved_square/regular/top_right.png"], 0, 0, 0, tocolor(elementTemplate.titleBar.close_button.hoverColor[1], elementTemplate.titleBar.close_button.hoverColor[2], elementTemplate.titleBar.close_button.hoverColor[3], elementTemplate.titleBar.close_button.hoverColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), window_postGUI)
        end
        dxDrawText(elementReference.gui["__UI_CACHE__"]["Close Button"].text.text, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Close Button"].text.fontColor, elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, window_postGUI, false)
        if isRenderCloseButtonHover then    
            dxDrawText(elementReference.gui["__UI_CACHE__"]["Close Button"].text.text, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Close Button"].text.offsets.endY, tocolor(elementTemplate.titleBar.close_button.hoverFontColor[1], elementTemplate.titleBar.close_button.hoverFontColor[2], elementTemplate.titleBar.close_button.hoverFontColor[3], elementTemplate.titleBar.close_button.hoverFontColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, window_postGUI, false)
        end
        dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.startY, window_titleBar_divider_size, elementReference.gui["__UI_CACHE__"]["Close Button"].offsets.height, window_titleBar_divider_color, window_postGUI)
        renderElementChildren(element)
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        local window_renderTarget = elementReference.gui.renderTarget
        if window_renderTarget and isElement(window_renderTarget) then
            dxDrawImage(elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Window"].view.offsets.height, window_renderTarget, 0, 0, 0, -1, window_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT == element
        local isCloseButtonHovered = false
        if isElementHovered then
            local isTitleBarClicked = false
            if isKeyClicked("mouse1") then
                isTitleBarClicked = isMouseOnPosition(elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startX, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Title Bar"].height)
            end
            if isTitleBarClicked then
                if not elementReference.isDisabled and elementReference.isDraggable then
                    attachElement(element)
                end
            else
                isCloseButtonHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].height)
            end
        end
        if isCloseButtonHovered then
            if isKeyClicked("mouse1") then
                setUIVisible(element, false)
            end
            if elementReference.gui.titleBar.close_button.hoverStatus ~= "forward" then
                elementReference.gui.titleBar.close_button.hoverStatus = "forward"
                elementReference.gui.titleBar.close_button.hoverAnimTickCounter = getTickCount()
            end
        else
            if elementReference.gui.titleBar.close_button.hoverStatus ~= "backward" then
                elementReference.gui.titleBar.close_button.hoverStatus = "backward"
                elementReference.gui.titleBar.close_button.hoverAnimTickCounter = getTickCount()
            end
        end
    end
    return true

end