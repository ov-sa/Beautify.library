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

function renderWindow(element)

    if not isUIValid(element) or (element:getType() ~= elementType) then return false end

    local elementTemplate = getUITemplate(elementType)
    local elementReference = createdElements[element]
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

    dxSetRenderTarget()
    if not elementReference.gui["__UI_CACHE__"]["Content Section"] or CLIENT_MTA_RESTORED then
        if not elementReference.gui["__UI_CACHE__"]["Content Section"] then
            elementReference.gui["__UI_CACHE__"]["Content Section"] = {
                renderTarget = DxRenderTarget(window_width, window_height, true)
            }
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
    end

    local isCloseButtonHovered = false
    local isTitleBarClicked = isMouseOnPosition(window_startX, window_startY, window_width - window_borderSize, window_borderSize) and isKeyClicked("mouse1")
    if isTitleBarClicked then
        resetKeyClickCache("mouse1")
        if not elementReference.isDisabled and elementReference.isDraggable then
            attachElement(element)
        end
    else
        if not getAttachedElement() then
            isCloseButtonHovered = isMouseOnPosition(window_close_button_startX, window_close_button_startY, window_borderSize, window_borderSize)
        end
    end
    if isCloseButtonHovered then
        if isKeyClicked("mouse1") then
            resetKeyClickCache("mouse1")
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
    if not elementReference.gui.titleBar.close_button.animAlphaPercent then elementReference.gui.titleBar.close_button.animAlphaPercent = 0 end
    if elementReference.gui.titleBar.close_button.hoverStatus == "forward" then
        elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements[elementType].titleBar.close_button.hoverAnimDuration), "InQuad")
    else
        elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements[elementType].titleBar.close_button.hoverAnimDuration), "InQuad")
    end
    dxDrawImage(window_startX, window_startY, window_width, window_height, elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
    if elementReference.gui.titleBar.close_button.animAlphaPercent > 0 then    
        dxDrawImage(window_close_button_startX, window_close_button_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(elementTemplate.titleBar.close_button.hoverColor[1], elementTemplate.titleBar.close_button.hoverColor[2], elementTemplate.titleBar.close_button.hoverColor[3], elementTemplate.titleBar.close_button.hoverColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), window_postGUI)
        dxDrawText("X", window_close_button_startX, window_close_button_startY + (elementTemplate.titleBar.fontPaddingY or 0), window_close_button_startX + window_borderSize, window_close_button_startY + window_borderSize, tocolor(elementTemplate.titleBar.close_button.hoverFontColor[1], elementTemplate.titleBar.close_button.hoverFontColor[2], elementTemplate.titleBar.close_button.hoverFontColor[3], elementTemplate.titleBar.close_button.hoverFontColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), elementTemplate.titleBar.fontScale or 1, elementTemplate.titleBar.font, "center", "center", true, false, window_postGUI, false)
    end
    dxDrawRectangle(window_close_button_startX, window_close_button_startY, window_titleBar_divider_size, window_borderSize, window_titleBar_divider_color, window_postGUI)
    if (window_width >= window_borderSize) and (window_height >= window_borderSize) and window_renderTarget and isElement(window_renderTarget) then
        renderElementChildren(element)
        dxDrawImage(window_renderTarget_startX, window_renderTarget_startY, window_renderTarget_width, window_renderTarget_height, window_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
    end
    return true

end