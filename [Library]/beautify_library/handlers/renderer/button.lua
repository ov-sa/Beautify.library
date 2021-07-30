----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: button.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Button's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_button"


----------------------------------
--[[ Function: Renders Button ]]--
----------------------------------

function renderButton(element)

    if not isUIValid(element) or (element:getType() ~= elementType) then return false end

    local elementTemplate = getUITemplate(elementType)
    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    local button_type = elementReference.gui.type
    elementTemplate = elementTemplate[button_type]
    local button_borderSize = availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize*0.5
    local button_startX, button_startY = elementReference.gui.x, elementReference.gui.y
    local button_width, button_height = false, false
    local button_color, button_fontColor = tocolor(unpack(elementTemplate.color)), tocolor(unpack(elementTemplate.fontColor))
    local button_postGUI = elementReference.gui.postGUI

    if button_type == "default" then
        button_width, button_height = elementReference.gui.width, elementReference.gui.height
    end

    if not elementParent then dxSetRenderTarget() end
    if button_width and button_height then
        dxDrawImage(button_startX, button_startY, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, button_color, button_postGUI)
        dxDrawImage(button_startX + button_width - button_borderSize, button_startY, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, button_color, button_postGUI)
        dxDrawImage(button_startX, button_startY + button_height - button_borderSize, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/bottom_left.png"], 0, 0, 0, button_color, button_postGUI)
        dxDrawImage(button_startX + button_width - button_borderSize, button_startY + button_height - button_borderSize, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/bottom_right.png"], 0, 0, 0, button_color, button_postGUI)
        if (button_width > availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize) and (button_height >= availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize) then
            dxDrawRectangle(button_startX + button_borderSize, button_startY, button_width - availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize, button_height, button_color, button_postGUI)
            if button_height > availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize then
                dxDrawRectangle(button_startX, button_startY + button_borderSize, button_borderSize, button_height - availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize, button_color, button_postGUI)
                dxDrawRectangle(button_startX + button_width - button_borderSize, button_startY + button_borderSize, button_borderSize, button_height - availableElements[elementType]["TEMPLATE_PROPERTIES"][button_type].minimumSize, button_color, button_postGUI)
            end
        end
        dxDrawText(elementReference.gui.text, button_startX, button_startY + (elementTemplate.fontPaddingY or 0), button_startX + button_width, button_startY + button_height, button_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, button_postGUI, false)
    end
    return true

end