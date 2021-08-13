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


---------------------------------
--[[ Function: Renders Label ]]--
---------------------------------

function renderLabel(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = __getUIParent(element)
        if not elementParent then dxSetRenderTarget() end
        local isElementToBeUpdated = elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local label_width, label_height = elementReference.gui.width, elementReference.gui.height
        local label_postGUI = elementReference.gui.postGUI

        if (label_width > 0) and (label_height > 0) then
            if isElementToBeUpdated then
                if not elementReference.gui["__UI_CACHE__"]["Label"] then
                    elementReference.gui["__UI_CACHE__"]["Label"] = {
                        offsets = {},
                        text = {
                            offsets = {}
                        }
                    }
                end
                local label_startX, label_startY = elementReference.gui.x, elementReference.gui.y
                elementReference.gui["__UI_CACHE__"]["Label"].offsets.startX = label_startX
                elementReference.gui["__UI_CACHE__"]["Label"].offsets.startY = label_startY
                elementReference.gui["__UI_CACHE__"]["Label"].offsets.width = label_width
                elementReference.gui["__UI_CACHE__"]["Label"].offsets.height = label_height
                elementReference.gui["__UI_CACHE__"]["Label"].text.text = elementReference.gui.text
                --TODO: ON ELEMENT UPDATE..
                elementReference.gui["__UI_CACHE__"]["Label"].text.fontColor = tocolor(unpackColor(elementReference.gui.fontColor or elementTemplate.fontColor))
                ----
                elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startX
                elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startY + (elementTemplate.fontPaddingY or 0)
                elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Label"].offsets.width
                elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Label"].offsets.height
                --
                elementReference.gui["__UI_CACHE__"].updateElement = nil
            end
            dxDrawText(elementReference.gui["__UI_CACHE__"]["Label"].text.text, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Label"].text.fontColor, elementTemplate.fontScale or 1, elementTemplate.font, elementReference.gui.alignment.horizontal, elementReference.gui.alignment.vertical, true, false, label_postGUI, false)
            renderElementChildren(element)
            dxSetBlendMode("blend")
            if not elementParent then
                dxSetRenderTarget()
            else
                dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Label"].offsets.width and elementReference.gui["__UI_CACHE__"]["Label"].offsets.height then
            renderElementChildren(element, true, mouseReference)
        end
    end
    return true

end