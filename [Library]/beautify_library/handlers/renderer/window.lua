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

    local windowBorderSize = availableElements["beautify_window"].__minimumSize/2
    dxDrawImage(createdElements[element].gui.x, createdElements[element].gui.y, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, createdElements[element].gui.color, false)
    dxDrawImage(createdElements[element].gui.x + createdElements[element].gui.width - windowBorderSize, createdElements[element].gui.y, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, createdElements[element].gui.color, false)
    dxDrawImage(createdElements[element].gui.x, createdElements[element].gui.y + createdElements[element].gui.height - windowBorderSize, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, createdElements[element].gui.color, false)
    dxDrawImage(createdElements[element].gui.x + createdElements[element].gui.width - windowBorderSize, createdElements[element].gui.y + createdElements[element].gui.height - windowBorderSize, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, createdElements[element].gui.color, false)
    if createdElements[element].gui.width > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(createdElements[element].gui.x + windowBorderSize, createdElements[element].gui.y, createdElements[element].gui.width - availableElements["beautify_window"].__minimumSize, windowBorderSize, createdElements[element].gui.color, false)
        dxDrawRectangle(createdElements[element].gui.x + windowBorderSize, createdElements[element].gui.y + createdElements[element].gui.height - windowBorderSize, createdElements[element].gui.width - availableElements["beautify_window"].__minimumSize, windowBorderSize, createdElements[element].gui.color, false)
    end
    if createdElements[element].gui.height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(createdElements[element].gui.x, createdElements[element].gui.y + windowBorderSize, windowBorderSize, createdElements[element].gui.height - availableElements["beautify_window"].__minimumSize, createdElements[element].gui.color, false)
        dxDrawRectangle(createdElements[element].gui.x + createdElements[element].gui.width - windowBorderSize, createdElements[element].gui.y + windowBorderSize, windowBorderSize, createdElements[element].gui.height - availableElements["beautify_window"].__minimumSize, createdElements[element].gui.color, false)
    end
    if createdElements[element].gui.width > availableElements["beautify_window"].__minimumSize and createdElements[element].gui.height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(createdElements[element].gui.x + windowBorderSize, createdElements[element].gui.y + windowBorderSize, createdElements[element].gui.width - availableElements["beautify_window"].__minimumSize, createdElements[element].gui.height - availableElements["beautify_window"].__minimumSize, createdElements[element].gui.color, false)
    end
    return true

end