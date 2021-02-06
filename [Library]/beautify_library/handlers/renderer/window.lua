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

    local window_borderSize = availableElements["beautify_window"].__minimumSize/2
    local window_titleBar_paddingX, window_titleBar_height = availableElements["beautify_window"].__titleBar.paddingX, availableElements["beautify_window"].__titleBar.height
    local window_startX, window_startY = createdElements[element].gui.x, createdElements[element].gui.y
    local window_width, window_height = createdElements[element].gui.width, createdElements[element].gui.height
    local window_color, window_titleBar_color = createdElements[element].gui.color, createdElements[element].gui.titleBar.color
    local window_renderTarget = createdElements[element].gui.renderTarget
    local window_postGUI = createdElements[element].gui.postGUI
    local isRenderTargetToBeRendered = false

    dxDrawImage(window_startX, window_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, window_color, window_postGUI)
    dxDrawImage(window_startX + window_width - window_borderSize, window_startY, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, window_color, window_postGUI)
    dxDrawImage(window_startX, window_startY + window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, window_color, window_postGUI)
    dxDrawImage(window_startX + window_width - window_borderSize, window_startY + window_height - window_borderSize, window_borderSize, window_borderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, window_color, window_postGUI)
    if window_width > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(window_startX + window_borderSize, window_startY, window_width - availableElements["beautify_window"].__minimumSize, window_borderSize, window_color, window_postGUI)
        dxDrawRectangle(window_startX + window_borderSize, window_startY + window_height - window_borderSize, window_width - availableElements["beautify_window"].__minimumSize, window_borderSize, window_color, window_postGUI)
    end
    if window_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(window_startX, window_startY + window_borderSize, window_borderSize, window_height - availableElements["beautify_window"].__minimumSize, window_color, window_postGUI)
        dxDrawRectangle(window_startX + window_width - window_borderSize, window_startY + window_borderSize, window_borderSize, window_height - availableElements["beautify_window"].__minimumSize, window_color, window_postGUI)
    end
    if window_width > availableElements["beautify_window"].__minimumSize and window_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(window_startX + window_borderSize, window_startY + window_borderSize, window_width - availableElements["beautify_window"].__minimumSize, window_height - availableElements["beautify_window"].__minimumSize, window_color, window_postGUI)
        isRenderTargetToBeRendered = true
    end
    if (window_width >= window_titleBar_height) and (window_height >= window_titleBar_height) then
        dxDrawImage(window_startX, window_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, tocolor(unpack(window_titleBar_color)), window_postGUI)
        dxDrawRectangle(window_startX + window_titleBar_height, window_startY, window_width - (window_titleBar_height*2), window_titleBar_height, tocolor(unpack(window_titleBar_color)), window_postGUI)
        local window_close_button_startX, window_close_button_startY = window_startX + window_width - window_titleBar_height, window_startY
        dxDrawImage(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(window_titleBar_color[1]/1.5, window_titleBar_color[2]/1.5, window_titleBar_color[3]/1.5, window_titleBar_color[4]/1.5), window_postGUI)
    
        --TODO: ADD NIGHT/DAY MODE TOGGLER..
        dxDrawText(createdElements[element].gui.title, window_startX + window_titleBar_paddingX, window_startY, window_startX + window_width - window_titleBar_height - window_titleBar_paddingX, window_startY + window_titleBar_height, tocolor(unpack(createdElements[element].gui.titleBar.fontColor)), 1, createdElements[element].gui.titleBar.font, "center", "center", true, false, window_postGUI, false, true)

        --TODO: ANIMATE ON HVOER :)
        --dxDrawImage(window_close_button_startX, window_close_button_startY, window_titleBar_height, window_titleBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(window_titleBar_color[1]/1.5, window_titleBar_color[2]/1.5, window_titleBar_color[3]/1.5, window_titleBar_color[4]/1.5), window_postGUI)
    	dxDrawLine(window_close_button_startX, window_close_button_startY, window_close_button_startX, window_close_button_startY + window_titleBar_height, tocolor(0, 0, 0, 150), 2, window_postGUI)
    end
    if isRenderTargetToBeRendered and window_renderTarget and isElement(window_renderTarget) then
        dxSetRenderTarget(window_renderTarget, true)
        dxSetBlendMode("modulate_add")
        --TODO: ADD ELEMENTS HERE FOR WINDOW    
        dxSetBlendMode("blend")
        dxSetRenderTarget()
        dxSetBlendMode("add")
        --dxDrawImage(0, 0, 500, 500, window_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), window_postGUI)
        dxSetBlendMode("blend")
    end
    return true

end