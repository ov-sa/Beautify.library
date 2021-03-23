----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Grid List's Renderer ]]--
----------------------------------------------------------------


-------------------------------------
--[[ Function: Renders Grid List ]]--
-------------------------------------

function renderGridlist(element)

    if not isUIValid(element) or element:getType() ~= "beautify_gridlist" then return false end

    --[[
    local gridlist_startX, gridlist_startY = createdElements[element].gui.x, createdElements[element].gui.y
    local gridlist_width, gridlist_height = createdElements[element].gui.width, createdElements[element].gui.height
    local gridlist_postGUI = createdElements[element].gui.postGUI

    outputChatBox("WEW XD")
    dxDrawRectangle(gridlist_startX, gridlist_startY, gridlist_width, gridlist_height, tocolor(255, 0, 0, 255), gridlist_postGUI, true)
    ]]--
    --[[
    local window_borderSize = availableElements["beautify_window"].__minimumSize/2
    local window_titleBar_paddingX, window_titleBar_height = availableElements["beautify_window"].__titleBar.paddingX, availableElements["beautify_window"].__titleBar.height
    local gridlist_startX, gridlist_startY = createdElements[element].gui.x, createdElements[element].gui.y
    local gridlist_width, gridlist_height = createdElements[element].gui.width, createdElements[element].gui.height
    local window_color, window_titleBar_color = tocolor(unpack(createdElements[element].gui.color)), tocolor(unpack(createdElements[element].gui.titleBar.color))
    local window_titleBar_divider_size, window_titleBar_divider_color = createdElements[element].gui.titleBar.divider.size, tocolor(unpack(createdElements[element].gui.titleBar.divider.color))
    local window_renderTarget_startX, window_renderTarget_startY = gridlist_startX + createdElements[element].gui.contentSection.startX, gridlist_startY + createdElements[element].gui.contentSection.startY
    local window_renderTarget_width, window_renderTarget_height = createdElements[element].gui.contentSection.width, createdElements[element].gui.contentSection.height
    local window_renderTarget = createdElements[element].gui.renderTarget
    local gridlist_postGUI = createdElements[element].gui.postGUI

    dxDrawImage(gridlist_startX, gridlist_startY + gridlist_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, window_color, gridlist_postGUI)
    dxDrawImage(gridlist_startX + gridlist_width - window_borderSize, gridlist_startY + gridlist_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, window_color, gridlist_postGUI)
    if gridlist_width > availableElements["beautify_window"].__minimumSize then
        if window_borderSize > window_titleBar_height then
            dxDrawRectangle(gridlist_startX + window_borderSize, gridlist_startY + window_titleBar_height, gridlist_width - availableElements["beautify_window"].__minimumSize, window_borderSize - window_titleBar_height, window_color, gridlist_postGUI, true)
        end
        dxDrawRectangle(gridlist_startX + window_borderSize, gridlist_startY + gridlist_height - window_borderSize, gridlist_width - availableElements["beautify_window"].__minimumSize, window_borderSize, window_color, gridlist_postGUI, true)
    end
    if gridlist_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(gridlist_startX, gridlist_startY + window_titleBar_height, window_borderSize, gridlist_height - window_borderSize - window_titleBar_height, window_color, gridlist_postGUI, true)
        dxDrawRectangle(gridlist_startX + gridlist_width - window_borderSize, gridlist_startY + window_titleBar_height, window_borderSize, gridlist_height - window_borderSize - window_titleBar_height, window_color, gridlist_postGUI, true)
    end
    if gridlist_width > availableElements["beautify_window"].__minimumSize and gridlist_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(gridlist_startX + window_borderSize, gridlist_startY + window_borderSize, gridlist_width - availableElements["beautify_window"].__minimumSize, gridlist_height - availableElements["beautify_window"].__minimumSize, window_color, gridlist_postGUI, true)
    end
    if (gridlist_width >= window_titleBar_height) and (gridlist_height >= window_titleBar_height) then
        local isCloseButtonHovered = false
        local window_close_button_startX, window_close_button_startY = gridlist_startX + gridlist_width - window_titleBar_height, gridlist_startY
        local isTitleBarClicked = isMouseOnPosition(gridlist_startX, gridlist_startY, gridlist_width - window_titleBar_height, window_titleBar_height) and isLMBClicked
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
            if createdElements[element].gui.titleBar.close_button.hoverStatus ~= "forward" then
                createdElements[element].gui.titleBar.close_button.hoverStatus = "forward"
                createdElements[element].gui.titleBar.close_button.hoverAnimTickCounter = getTickCount()
            end
        else
            if createdElements[element].gui.titleBar.close_button.hoverStatus ~= "backward" then
                createdElements[element].gui.titleBar.close_button.hoverStatus = "backward"
                createdElements[element].gui.titleBar.close_button.hoverAnimTickCounter = getTickCount()
            end
        end
        if not createdElements[element].gui.titleBar.close_button.animAlphaPercent then createdElements[element].gui.titleBar.close_button.animAlphaPercent = 0 end
        if createdElements[element].gui.titleBar.close_button.hoverStatus == "forward" then
            createdElements[element].gui.titleBar.close_button.animAlphaPercent = interpolateBetween(createdElements[element].gui.titleBar.close_button.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(createdElements[element].gui.titleBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].__titleBar.close_button.hoverAnimDuration), "InQuad")
        else
            createdElements[element].gui.titleBar.close_button.animAlphaPercent = interpolateBetween(createdElements[element].gui.titleBar.close_button.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(createdElements[element].gui.titleBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].__titleBar.close_button.hoverAnimDuration), "InQuad")
        end
        dxDrawImage(gridlist_startX, gridlist_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, window_titleBar_color, gridlist_postGUI)
        dxDrawRectangle(gridlist_startX + window_titleBar_height, gridlist_startY, gridlist_width - (window_titleBar_height*2), window_titleBar_height, window_titleBar_color, gridlist_postGUI, true)
        dxDrawImage(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, window_titleBar_color, gridlist_postGUI)
        dxDrawImage(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(createdElements[element].gui.titleBar.close_button.hoverColor[1], createdElements[element].gui.titleBar.close_button.hoverColor[2], createdElements[element].gui.titleBar.close_button.hoverColor[3], createdElements[element].gui.titleBar.close_button.hoverColor[4]*createdElements[element].gui.titleBar.close_button.animAlphaPercent), gridlist_postGUI)
        dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + window_titleBar_height, gridlist_startY + window_titleBar_height, tocolor(unpack(createdElements[element].gui.titleBar.close_button.fontColor)), 1, createdElements[element].gui.titleBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
        dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + window_titleBar_height, gridlist_startY + window_titleBar_height, tocolor(createdElements[element].gui.titleBar.close_button.hoverFontColor[1], createdElements[element].gui.titleBar.close_button.hoverFontColor[2], createdElements[element].gui.titleBar.close_button.hoverFontColor[3], createdElements[element].gui.titleBar.close_button.hoverFontColor[4]*createdElements[element].gui.titleBar.close_button.animAlphaPercent), 1, createdElements[element].gui.titleBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
        dxDrawText(createdElements[element].gui.title, gridlist_startX + window_titleBar_paddingX, gridlist_startY, gridlist_startX + gridlist_width - window_titleBar_height - window_titleBar_paddingX, gridlist_startY + window_titleBar_height, tocolor(unpack(createdElements[element].gui.titleBar.fontColor)), 1, createdElements[element].gui.titleBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
    	dxDrawLine(window_close_button_startX, window_close_button_startY, window_close_button_startX, window_close_button_startY + window_titleBar_height, window_titleBar_divider_color, window_titleBar_divider_size, gridlist_postGUI)
        dxDrawLine(gridlist_startX, gridlist_startY + window_titleBar_height, gridlist_startX + gridlist_width, gridlist_startY + window_titleBar_height, window_titleBar_divider_color, window_titleBar_divider_size, gridlist_postGUI)
        --TODO: ADD NIGHT/DAY MODE TOGGLER..
    end
    if window_renderTarget and isElement(window_renderTarget) then
        dxSetRenderTarget(window_renderTarget, true)
        dxSetBlendMode("modulate_add")
        --TODO: ADD ELEMENTS HERE FOR WINDOW    
        dxSetBlendMode("blend")
        dxSetRenderTarget()
        dxSetBlendMode("add")
        dxDrawImage(window_renderTarget_startX, window_renderTarget_startY, window_renderTarget_width, window_renderTarget_height, window_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), gridlist_postGUI)
        dxSetBlendMode("blend")
    end
    ]]--
    return true

end