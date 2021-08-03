----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: label.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Label's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_label"


----------------------------------
--[[ Function: Renders Label ]]--
----------------------------------

function renderLabel(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementParent = getUIParent(element)
    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementTemplate = getUITemplate(elementType)
        local label_startX, label_startY = elementReference.gui.x, elementReference.gui.y
        local label_width, label_height = elementReference.gui.width, elementReference.gui.height
        local label_postGUI = elementReference.gui.postGUI
    
        if not elementParent then dxSetRenderTarget() end
        dxDrawText(elementReference.gui.text, label_startX, label_startY + (elementTemplate.fontPaddingY or 0), label_startX + label_width, label_startY + label_height, tocolor(unpackColor(elementTemplate.fontColor)), elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, label_postGUI, false)
        renderElementChildren(element)
    else
        renderElementChildren(element, true, mouseReference)
    end
    return true

end