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
            if elementType == "ov_window" then
                if createdElements[i].gui.width < availableElements["ov_window"].minimumSize then createdElements[i].gui.width = availableElements["ov_window"].minimumSize end
                if createdElements[i].gui.height < availableElements["ov_window"].minimumSize then createdElements[i].gui.height = availableElements["ov_window"].minimumSize end
                --outputChatBox(toJSON(createdElements[i]))
                --TODO: ALSO AND COLOR SHIT AND WIDTH AND COORD LENGTH CHECK
                color = tocolor(0, 0, 0, 255)
                dxDrawImage(createdElements[i].gui.x, createdElements[i].gui.y, availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, color, false)
                dxDrawImage(createdElements[i].gui.x + createdElements[i].gui.width - availableElements["ov_window"].minimumSize/2, createdElements[i].gui.y, availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, color, false)
                dxDrawImage(createdElements[i].gui.x, createdElements[i].gui.y + createdElements[i].gui.height - availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, color, false)
                dxDrawImage(createdElements[i].gui.x + createdElements[i].gui.width - availableElements["ov_window"].minimumSize/2, createdElements[i].gui.y + createdElements[i].gui.height - availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, color, false)
                if createdElements[i].gui.width > availableElements["ov_window"].minimumSize then
                    dxDrawRectangle(createdElements[i].gui.x + availableElements["ov_window"].minimumSize/2, createdElements[i].gui.y, createdElements[i].gui.width - availableElements["ov_window"].minimumSize, availableElements["ov_window"].minimumSize/2, color, false)
                    dxDrawRectangle(createdElements[i].gui.x + availableElements["ov_window"].minimumSize/2, createdElements[i].gui.y + createdElements[i].gui.height - availableElements["ov_window"].minimumSize/2, createdElements[i].gui.width - availableElements["ov_window"].minimumSize, availableElements["ov_window"].minimumSize/2, color, false)
                end
                if createdElements[i].gui.height > availableElements["ov_window"].minimumSize then
                    dxDrawRectangle(createdElements[i].gui.x, createdElements[i].gui.y + availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, createdElements[i].gui.height - availableElements["ov_window"].minimumSize, color, false)
                    dxDrawRectangle(createdElements[i].gui.x + createdElements[i].gui.width - availableElements["ov_window"].minimumSize/2, createdElements[i].gui.y + availableElements["ov_window"].minimumSize/2, availableElements["ov_window"].minimumSize/2, createdElements[i].gui.height - availableElements["ov_window"].minimumSize, color, false)
                end
                if createdElements[i].gui.width > availableElements["ov_window"].minimumSize and createdElements[i].gui.height > availableElements["ov_window"].minimumSize then
                    dxDrawRectangle(createdElements[i].gui.x + availableElements["ov_window"].minimumSize/2, createdElements[i].gui.y + availableElements["ov_window"].minimumSize/2, createdElements[i].gui.width - availableElements["ov_window"].minimumSize, createdElements[i].gui.height - availableElements["ov_window"].minimumSize, color, false)
                end
            end
        end
    end

end)