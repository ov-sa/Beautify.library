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
    local window_titleBarHeight = availableElements["beautify_window"].__titleBar.height
    local window_startX, window_startY = createdElements[element].gui.x, createdElements[element].gui.y
    local window_width, window_height = createdElements[element].gui.width, createdElements[element].gui.height
    local window_color = createdElements[element].gui.color
    local window_renderTarget = createdElements[element].gui.renderTarget
    local window_postGUI = createdElements[element].gui.postGUI
    local titlebarColor = tocolor(175, 175, 175, 250)
    local renderWindowTarget = false

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
        renderWindowTarget = true
    end
    if (window_width >= window_titleBarHeight) and (window_height >= window_titleBarHeight) then
        dxDrawImage(window_startX, window_startY, window_titleBarHeight, window_titleBarHeight, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, titlebarColor, window_postGUI)
        dxDrawImage(window_startX + window_width - window_titleBarHeight, window_startY, window_titleBarHeight, window_titleBarHeight, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, titlebarColor, window_postGUI)
        dxDrawRectangle(window_startX + window_titleBarHeight, window_startY, window_width - (window_titleBarHeight*2), window_titleBarHeight, titlebarColor, window_postGUI)
    end
    if renderWindowTarget and window_renderTarget and isElement(window_renderTarget) then
        --TODO: DRAW TARGET HERE :)
    end
    return true

end