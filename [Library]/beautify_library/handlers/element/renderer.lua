----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: renderer.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Renderer ]]--
----------------------------------------------------------------


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

addEventHandler("onClientRender", root, function()

    --TODO: DRAW NON PARENT ELEMENTS FIRSTS.

    for i, j in pairs(createdParentElements) do
        if isUIValid(i) then
            local elementType = i:getType()
            if elementType == "beautify_window" then
                local windowBorderSize = availableElements["beautify_window"].__minimumSize/2
                dxDrawImage(createdElements[i].gui.x, createdElements[i].gui.y, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, createdElements[i].gui.color, false)
                dxDrawImage(createdElements[i].gui.x + createdElements[i].gui.width - windowBorderSize, createdElements[i].gui.y, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, createdElements[i].gui.color, false)
                dxDrawImage(createdElements[i].gui.x, createdElements[i].gui.y + createdElements[i].gui.height - windowBorderSize, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, createdElements[i].gui.color, false)
                dxDrawImage(createdElements[i].gui.x + createdElements[i].gui.width - windowBorderSize, createdElements[i].gui.y + createdElements[i].gui.height - windowBorderSize, windowBorderSize, windowBorderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, createdElements[i].gui.color, false)
                if createdElements[i].gui.width > availableElements["beautify_window"].__minimumSize then
                    dxDrawRectangle(createdElements[i].gui.x + windowBorderSize, createdElements[i].gui.y, createdElements[i].gui.width - availableElements["beautify_window"].__minimumSize, windowBorderSize, createdElements[i].gui.color, false)
                    dxDrawRectangle(createdElements[i].gui.x + windowBorderSize, createdElements[i].gui.y + createdElements[i].gui.height - windowBorderSize, createdElements[i].gui.width - availableElements["beautify_window"].__minimumSize, windowBorderSize, createdElements[i].gui.color, false)
                end
                if createdElements[i].gui.height > availableElements["beautify_window"].__minimumSize then
                    dxDrawRectangle(createdElements[i].gui.x, createdElements[i].gui.y + windowBorderSize, windowBorderSize, createdElements[i].gui.height - availableElements["beautify_window"].__minimumSize, createdElements[i].gui.color, false)
                    dxDrawRectangle(createdElements[i].gui.x + createdElements[i].gui.width - windowBorderSize, createdElements[i].gui.y + windowBorderSize, windowBorderSize, createdElements[i].gui.height - availableElements["beautify_window"].__minimumSize, createdElements[i].gui.color, false)
                end
                if createdElements[i].gui.width > availableElements["beautify_window"].__minimumSize and createdElements[i].gui.height > availableElements["beautify_window"].__minimumSize then
                    dxDrawRectangle(createdElements[i].gui.x + windowBorderSize, createdElements[i].gui.y + windowBorderSize, createdElements[i].gui.width - availableElements["beautify_window"].__minimumSize, createdElements[i].gui.height - availableElements["beautify_window"].__minimumSize, createdElements[i].gui.color, false)
                end
            end
        end
    end

end)