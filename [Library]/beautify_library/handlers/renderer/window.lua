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

    local elementParent = getUIParent(element)
    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local window_borderSize = availableElements[elementType].minimumSize*0.5
        local window_startX, window_startY = elementReference.gui.x, elementReference.gui.y
        local window_width, window_height = elementReference.gui.width, elementReference.gui.height
        local window_color, window_titleBar_color = tocolor(unpackColor(elementTemplate.color)), tocolor(unpackColor(elementTemplate.titleBar.color))
        local window_titleBar_paddingX = availableElements[elementType].titleBar.paddingX
        local window_titleBar_divider_size, window_titleBar_divider_color = elementTemplate.titleBar.divider.size, tocolor(unpackColor(elementTemplate.titleBar.divider.color))
        local window_close_button_startX, window_close_button_startY = window_startX + window_width - window_borderSize, window_startY
        local window_renderTarget_startX, window_renderTarget_startY = window_startX + elementReference.gui.contentSection.startX, window_startY + elementReference.gui.contentSection.startY
        local window_renderTarget_width, window_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
        local window_renderTarget = elementReference.gui.renderTarget
        local window_postGUI = elementReference.gui.postGUI

        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX = window_startX
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY = window_startY
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width = window_width
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height = window_height
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].borderSize = window_borderSize
        if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"] then
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"] = {}
        end
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startX = window_close_button_startX
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startY = window_close_button_startY

        if not elementParent then dxSetRenderTarget() end
        if not elementReference.gui["__UI_CACHE__"]["Content Section"] or not elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture or elementReference.gui["__UI_CACHE__"]["Content Section"].updateTexture then
            if not elementReference.gui["__UI_CACHE__"]["Content Section"] then
                elementReference.gui["__UI_CACHE__"]["Content Section"] = {}
            end
            if not elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget then
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget = DxRenderTarget(window_width, window_height, true)
            end
            if elementReference.gui["__UI_CACHE__"]["Content Section"].updateTexture then
                if elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture and isElement(elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture) then
                    elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture:destroy()
                    elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture = nil
                end
            end
            dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget, true)
            dxSetBlendMode("modulate_add")
            dxDrawImage(0, 0, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, window_titleBar_color, false)
            dxDrawImage(window_width - window_borderSize, 0, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, window_titleBar_color, false)
            dxDrawImage(0, window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, window_color, false)
            dxDrawImage(window_width - window_borderSize, window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, window_color, false)
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
            if not elementReference.gui["__UI_CACHE__"]["Title Bar"] or (elementReference.gui["__UI_CACHE__"]["Title Bar"].font ~= elementTemplate.titleBar.font) then
                if not elementReference.gui["__UI_CACHE__"]["Title Bar"] then
                    elementReference.gui["__UI_CACHE__"]["Title Bar"] = {
                        padding = "",
                        font = false
                    }
                end
                elementReference.gui["__UI_CACHE__"]["Title Bar"].font = elementTemplate.titleBar.font
                while dxGetTextWidth(elementReference.gui["__UI_CACHE__"]["Title Bar"].padding, 1, elementReference.gui["__UI_CACHE__"]["Title Bar"].font) < window_borderSize do
                    elementReference.gui["__UI_CACHE__"]["Title Bar"].padding = elementReference.gui["__UI_CACHE__"]["Title Bar"].padding.." "
                end
            end
            dxDrawText(elementReference.gui["__UI_CACHE__"]["Title Bar"].padding..elementReference.gui.title, window_titleBar_paddingX, (elementTemplate.titleBar.fontPaddingY or 0), window_width - window_borderSize - window_titleBar_paddingX, window_borderSize, tocolor(unpackColor(elementTemplate.titleBar.fontColor)), elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, false, false)
            dxDrawText("X", window_close_button_startX - window_startX, window_close_button_startY - window_startY + (elementTemplate.titleBar.fontPaddingY or 0), window_close_button_startX - window_startX + window_borderSize, window_close_button_startY - window_startY + window_borderSize, tocolor(unpackColor(elementTemplate.titleBar.close_button.fontColor)), elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, false, false)
            dxDrawRectangle(0, window_borderSize, window_width, window_titleBar_divider_size, window_titleBar_divider_color, false)    
            dxSetBlendMode("blend")
            dxSetRenderTarget()
            local renderPixels = dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget)
            if renderPixels then
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture = DxTexture(renderPixels, "argb", false, "clamp")
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget:destroy()
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget = nil
                elementReference.gui["__UI_CACHE__"]["Content Section"].updateTexture = nil
            end
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
        if elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture then
            dxDrawImage(window_startX, window_startY, window_width, window_height, elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
        end
        if elementReference.gui.titleBar.close_button.animAlphaPercent > 0 then    
            dxDrawImage(window_close_button_startX, window_close_button_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(elementTemplate.titleBar.close_button.hoverColor[1], elementTemplate.titleBar.close_button.hoverColor[2], elementTemplate.titleBar.close_button.hoverColor[3], elementTemplate.titleBar.close_button.hoverColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), window_postGUI)
            dxDrawText("X", window_close_button_startX, window_close_button_startY + (elementTemplate.titleBar.fontPaddingY or 0), window_close_button_startX + window_borderSize, window_close_button_startY + window_borderSize, tocolor(elementTemplate.titleBar.close_button.hoverFontColor[1], elementTemplate.titleBar.close_button.hoverFontColor[2], elementTemplate.titleBar.close_button.hoverFontColor[3], elementTemplate.titleBar.close_button.hoverFontColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, window_postGUI, false)
        end
        dxDrawRectangle(window_close_button_startX, window_close_button_startY, window_titleBar_divider_size, window_borderSize, window_titleBar_divider_color, window_postGUI)
        if window_renderTarget and isElement(window_renderTarget) then
            renderElementChildren(element)
            dxSetBlendMode("blend")
            if not elementParent then
                dxSetRenderTarget()
            else
                dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
            dxDrawImage(window_renderTarget_startX, window_renderTarget_startY, window_renderTarget_width, window_renderTarget_height, window_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT == element
        local isCloseButtonHovered = false
        if isElementHovered then
            local isTitleBarClicked = false
            if isKeyClicked("mouse1") then
                isTitleBarClicked = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width - elementReference.gui["__UI_INPUT_FETCH_CACHE__"].borderSize, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].borderSize)
            end
            if isTitleBarClicked then
                if not elementReference.isDisabled and elementReference.isDraggable then
                    attachElement(element)
                end
            else
                if not getAttachedElement() then
                    isCloseButtonHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Close Button"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].borderSize, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].borderSize)
                end
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