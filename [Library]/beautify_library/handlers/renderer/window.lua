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
    local window_borderSize = availableElements["beautify_window"].__minimumSize/2
    local window_startX, window_startY = elementReference.gui.x, elementReference.gui.y
    local window_width, window_height = elementReference.gui.width, elementReference.gui.height
    local window_color, window_titleBar_color = tocolor(unpack(elementReference.gui.color)), tocolor(unpack(elementReference.gui.titleBar.color))
    local window_titleBar_paddingX, window_titleBar_height = availableElements["beautify_window"].__titleBar.paddingX, availableElements["beautify_window"].__titleBar.height
    local window_titleBar_divider_size, window_titleBar_divider_color = elementReference.gui.titleBar.divider.size, tocolor(unpack(elementReference.gui.titleBar.divider.color))
    local window_renderTarget_startX, window_renderTarget_startY = window_startX + elementReference.gui.contentSection.startX, window_startY + elementReference.gui.contentSection.startY
    local window_renderTarget_width, window_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
    local window_renderTarget = elementReference.gui.renderTarget
    local window_postGUI = elementReference.gui.postGUI

    dxSetRenderTarget()
    dxDrawImage(window_startX, window_startY + window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, window_color, window_postGUI)
    dxDrawImage(window_startX + window_width - window_borderSize, window_startY + window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, window_color, window_postGUI)
    if window_width > availableElements["beautify_window"].__minimumSize then
        if window_borderSize > window_titleBar_height then
            dxDrawRectangle(window_startX + window_borderSize, window_startY + window_titleBar_height, window_width - availableElements["beautify_window"].__minimumSize, window_borderSize - window_titleBar_height, window_color, window_postGUI, true)
        end
        dxDrawRectangle(window_startX + window_borderSize, window_startY + window_height - window_borderSize, window_width - availableElements["beautify_window"].__minimumSize, window_borderSize, window_color, window_postGUI, true)
    end
    if window_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(window_startX, window_startY + window_titleBar_height, window_borderSize, window_height - window_borderSize - window_titleBar_height, window_color, window_postGUI, true)
        dxDrawRectangle(window_startX + window_width - window_borderSize, window_startY + window_titleBar_height, window_borderSize, window_height - window_borderSize - window_titleBar_height, window_color, window_postGUI, true)
    end
    if window_width > availableElements["beautify_window"].__minimumSize and window_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(window_startX + window_borderSize, window_startY + window_borderSize, window_width - availableElements["beautify_window"].__minimumSize, window_height - availableElements["beautify_window"].__minimumSize, window_color, window_postGUI, true)
    end
    if (window_width >= window_titleBar_height) and (window_height >= window_titleBar_height) then
        local isCloseButtonHovered = false
        local window_close_button_startX, window_close_button_startY = window_startX + window_width - window_titleBar_height, window_startY
        local isTitleBarClicked = isMouseOnPosition(window_startX, window_startY, window_width - window_titleBar_height, window_titleBar_height) and isLMBClicked
        if isTitleBarClicked then
            Timer(function(element)
                attachElement(element)
            end, 1, 1, element)
        else
            if not getAttachedElement() then
                isCloseButtonHovered = isMouseOnPosition(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height)
            end
        end
        if isCloseButtonHovered then
            if isLMBClicked then
                Timer(function(element)
                    setUIVisible(element, false)
                end, 1, 1, element)
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
            elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].__titleBar.close_button.hoverAnimDuration), "InQuad")
        else
            elementReference.gui.titleBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.titleBar.close_button.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.titleBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].__titleBar.close_button.hoverAnimDuration), "InQuad")
        end
        dxDrawImage(window_startX, window_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, window_titleBar_color, window_postGUI)
        dxDrawRectangle(window_startX + window_titleBar_height, window_startY, window_width - (window_titleBar_height*2), window_titleBar_height, window_titleBar_color, window_postGUI, true)
        dxDrawImage(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, window_titleBar_color, window_postGUI)
        dxDrawImage(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(elementReference.gui.titleBar.close_button.hoverColor[1], elementReference.gui.titleBar.close_button.hoverColor[2], elementReference.gui.titleBar.close_button.hoverColor[3], elementReference.gui.titleBar.close_button.hoverColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), window_postGUI)
        dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + window_titleBar_height, window_startY + window_titleBar_height, tocolor(unpack(elementReference.gui.titleBar.close_button.fontColor)), 1, elementReference.gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)
        dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + window_titleBar_height, window_startY + window_titleBar_height, tocolor(elementReference.gui.titleBar.close_button.hoverFontColor[1], elementReference.gui.titleBar.close_button.hoverFontColor[2], elementReference.gui.titleBar.close_button.hoverFontColor[3], elementReference.gui.titleBar.close_button.hoverFontColor[4]*elementReference.gui.titleBar.close_button.animAlphaPercent), 1, elementReference.gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)
        dxDrawText(elementReference.gui.title, window_startX + window_titleBar_paddingX, window_startY, window_startX + window_width - window_titleBar_height - window_titleBar_paddingX, window_startY + window_titleBar_height, tocolor(unpack(elementReference.gui.titleBar.fontColor)), 1, elementReference.gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)
    	dxDrawLine(window_close_button_startX, window_close_button_startY, window_close_button_startX, window_close_button_startY + window_titleBar_height, window_titleBar_divider_color, window_titleBar_divider_size, window_postGUI)
        dxDrawLine(window_startX, window_startY + window_titleBar_height, window_startX + window_width, window_startY + window_titleBar_height, window_titleBar_divider_color, window_titleBar_divider_size, window_postGUI)
        --TODO: ADD NIGHT/DAY MODE TOGGLER..
    end
    if window_renderTarget and isElement(window_renderTarget) then
        dxSetRenderTarget(window_renderTarget, true)
        dxSetBlendMode("modulate_add")
        for i, j in pairs(createdParentElements[element]) do
            if isUIValid(i) and isUIVisible(i) then
                local child_elementType = i:getType()
                if availableElements[child_elementType] and availableElements[child_elementType].__renderFunction and type(availableElements[child_elementType].__renderFunction) == "function" then
                    availableElements[child_elementType].__renderFunction(i)
                    dxSetRenderTarget(window_renderTarget)
                end
            end
        end
        dxSetBlendMode("blend")
        dxSetRenderTarget()
        dxDrawImage(window_renderTarget_startX, window_renderTarget_startY, window_renderTarget_width, window_renderTarget_height, window_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
    end
    return true

end