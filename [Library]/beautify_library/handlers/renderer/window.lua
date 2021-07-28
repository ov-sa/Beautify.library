----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Renderer ]]--
----------------------------------------------------------------


----------------------------------
--[[ Function: Renders Window ]]--
----------------------------------

function renderWindow(element)

    if not isUIValid(element) or element:getType() ~= "beautify_window" then return false end

    local elementReference = createdElements[element]
    local window_borderSize = availableElements["beautify_window"].minimumSize/2
    local window_startX, window_startY = elementReference.gui.x, elementReference.gui.y
    local window_width, window_height = elementReference.gui.width, elementReference.gui.height
    local window_color, window_titleBar_color = tocolor(unpack(elementReference.gui.color)), tocolor(unpack(elementReference.gui.titleBar.color))
    local window_titleBar_paddingX = availableElements["beautify_window"].titleBar.paddingX
    local window_titleBar_divider_size, window_titleBar_divider_color = elementReference.gui.titleBar.divider.size, tocolor(unpack(elementReference.gui.titleBar.divider.color))
    local window_renderTarget_startX, window_renderTarget_startY = window_startX + elementReference.gui.contentSection.startX, window_startY + elementReference.gui.contentSection.startY
    local window_renderTarget_width, window_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
    local window_renderTarget = elementReference.gui.renderTarget
    local window_postGUI = elementReference.gui.postGUI

    dxSetRenderTarget()
    local isCloseButtonHovered = false
    local window_close_button_startX, window_close_button_startY = window_startX + window_width - window_borderSize, window_startY
    local isTitleBarClicked = isMouseOnPosition(window_startX, window_startY, window_width - window_borderSize, window_borderSize) and isLMBClicked
    if isTitleBarClicked then
        if elementReference.isDraggable then
            attachElement(element)
        end
    else
        if not getAttachedElement() then
            isCloseButtonHovered = isMouseOnPosition(window_close_button_startX, window_close_button_startY, window_borderSize, window_borderSize)
        end
    end
    if isCloseButtonHovered then
        if isLMBClicked then
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
        elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].titleBar.close_button.hoverAnimDuration), "InQuad")
    else
        elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].titleBar.close_button.hoverAnimDuration), "InQuad")
    end
    dxDrawImage(window_startX, window_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, window_titleBar_color, window_postGUI)
    dxDrawImage(window_startX + window_width - window_borderSize, window_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, window_titleBar_color, window_postGUI)
    dxDrawImage(window_startX + window_width - window_borderSize, window_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(elementReference.gui.titleBar.close_button.hoverColor[1], elementReference.gui.titleBar.close_button.hoverColor[2], elementReference.gui.titleBar.close_button.hoverColor[3], elementReference.gui.titleBar.close_button.hoverColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), window_postGUI)
    dxDrawImage(window_startX, window_startY + window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, window_color, window_postGUI)
    dxDrawImage(window_startX + window_width - window_borderSize, window_startY + window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, window_color, window_postGUI)
    if window_width > availableElements["beautify_window"].minimumSize then
        dxDrawRectangle(window_startX + window_borderSize, window_startY, window_width - availableElements["beautify_window"].minimumSize, window_borderSize, window_titleBar_color, window_postGUI)
        dxDrawRectangle(window_startX + window_borderSize, window_startY + window_height - window_borderSize, window_width - availableElements["beautify_window"].minimumSize, window_borderSize, window_color, window_postGUI)
    end
    if window_height > availableElements["beautify_window"].minimumSize then
        dxDrawRectangle(window_startX, window_startY + window_borderSize, window_borderSize, window_height - availableElements["beautify_window"].minimumSize, window_color, window_postGUI)
        dxDrawRectangle(window_startX + window_width - window_borderSize, window_startY + window_borderSize, window_borderSize, window_height - availableElements["beautify_window"].minimumSize, window_color, window_postGUI)
    end
    if window_width > availableElements["beautify_window"].minimumSize and window_height > availableElements["beautify_window"].minimumSize then
        dxDrawRectangle(window_startX + window_borderSize, window_startY + window_borderSize, window_width - availableElements["beautify_window"].minimumSize, window_height - availableElements["beautify_window"].minimumSize, window_color, window_postGUI)
    end
    dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + window_borderSize, window_startY + window_borderSize, tocolor(unpack(elementReference.gui.titleBar.close_button.fontColor)), 1, elementReference.gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)
    dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + window_borderSize, window_startY + window_borderSize, tocolor(elementReference.gui.titleBar.close_button.hoverFontColor[1], elementReference.gui.titleBar.close_button.hoverFontColor[2], elementReference.gui.titleBar.close_button.hoverFontColor[3], elementReference.gui.titleBar.close_button.hoverFontColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), 1, elementReference.gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)
    dxDrawText(elementReference.gui.title, window_startX + window_titleBar_paddingX, window_startY, window_startX + window_width - window_borderSize - window_titleBar_paddingX, window_startY + window_borderSize, tocolor(unpack(elementReference.gui.titleBar.fontColor)), 1, elementReference.gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)
    dxDrawRectangle(window_close_button_startX, window_close_button_startY, window_titleBar_divider_size, window_borderSize, window_titleBar_divider_color, window_postGUI, true)
    dxDrawRectangle(window_startX, window_startY + window_borderSize, window_width, window_titleBar_divider_size, window_titleBar_divider_color, window_postGUI, true)
    if (window_width >= window_borderSize) and (window_height >= window_borderSize) and window_renderTarget and isElement(window_renderTarget) then
        renderElementChildren(element)
        dxDrawImage(window_renderTarget_startX, window_renderTarget_startY, window_renderTarget_width, window_renderTarget_height, window_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
    end
    return true

end




-------------------------------------------
--[[ Function: Draws Rounded Rectangle ]]--
-------------------------------------------

--[[
local roundedEdgePaths = {
    DxTexture("files/assets/images/curved_square/top_left.png", "argb", true, "clamp"),
    DxTexture("files/assets/images/curved_square/top_right.png", "argb", true, "clamp"),
    DxTexture("files/assets/images/curved_square/bottom_left.png", "argb", true, "clamp"),
    DxTexture("files/assets/images/curved_square/bottom_right.png", "argb", true, "clamp"),
    DxTexture("files/assets/images/curved_square/left.png", "argb", true, "clamp"),
    DxTexture("files/assets/images/curved_square/right.png", "argb", true, "clamp"),
    DxTexture("files/assets/images/curved_square/square.png", "argb", true, "clamp")
}

function dxDrawRoundedRectangle(x, y, width, height, color, postGUI, duoCorneringMode)

    x = tonumber(x); y = tonumber(y); width = tonumber(width); height = tonumber(height);
    if not x or not y or not width or not height or not color then return false end

    if not duoCorneringMode then
        local availableElements["beautify_window"].minimumSize = 50
        if width < availableElements["beautify_window"].minimumSize then width = availableElements["beautify_window"].minimumSize end
        if height < availableElements["beautify_window"].minimumSize then height = availableElements["beautify_window"].minimumSize end
        dxDrawImage(x, y, window_borderSize, window_borderSize, roundedEdgePaths[1], 0, 0, 0, color, postGUI)
        dxDrawImage(x + width - window_borderSize, y, window_borderSize, window_borderSize, roundedEdgePaths[2], 0, 0, 0, color, postGUI)
        dxDrawImage(x, y + height - window_borderSize, window_borderSize, window_borderSize, roundedEdgePaths[3], 0, 0, 0, color, postGUI)
        dxDrawImage(x + width - window_borderSize, y + height - window_borderSize, window_borderSize, window_borderSize, roundedEdgePaths[4], 0, 0, 0, color, postGUI)
        if width > availableElements["beautify_window"].minimumSize then
            dxDrawRectangle(x + window_borderSize, y, width - availableElements["beautify_window"].minimumSize, window_borderSize, color, postGUI)
            dxDrawRectangle(x + window_borderSize, y + height - window_borderSize, width - availableElements["beautify_window"].minimumSize, window_borderSize, color, postGUI)
        end
        if height > availableElements["beautify_window"].minimumSize then
            dxDrawRectangle(x, y + window_borderSize, window_borderSize, height - availableElements["beautify_window"].minimumSize, color, postGUI)
            dxDrawRectangle(x + width - window_borderSize, y + window_borderSize, window_borderSize, height - availableElements["beautify_window"].minimumSize, color, postGUI)
        end
        if width > availableElements["beautify_window"].minimumSize and height > availableElements["beautify_window"].minimumSize then
            dxDrawRectangle(x + window_borderSize, y + window_borderSize, width - availableElements["beautify_window"].minimumSize, height - availableElements["beautify_window"].minimumSize, color, postGUI)
        end
    end
    return true

end
]]--