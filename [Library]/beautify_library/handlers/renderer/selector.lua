----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: selector.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Selector's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_selector"


------------------------------------
--[[ Function: Renders Selector ]]--
------------------------------------

function renderSelector(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end
    
    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = __getUIParent(element)
        if not elementParent then dxSetRenderTarget() end
        local isElementToBeReloaded = elementReference.gui["__UI_CACHE__"].reloadElement
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local selector_postGUI = elementReference.gui.postGUI

        dxDrawRectangle(elementReference.gui.x, elementReference.gui.y, elementReference.gui.width, elementReference.gui.height, tocolor(255, 0, 0, 200), false)
        --[[
        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Selector"] then
                elementReference.gui["__UI_CACHE__"]["Selector"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
            end
            local selector_startX, selector_startY = elementReference.gui.x, elementReference.gui.y
            local selector_width, selector_height = elementReference.gui.width, elementReference.gui.height
            elementReference.gui["__UI_CACHE__"]["Selector"].offsets.startX = selector_startX
            elementReference.gui["__UI_CACHE__"]["Selector"].offsets.startY = selector_startY
            elementReference.gui["__UI_CACHE__"]["Selector"].offsets.width = selector_width
            elementReference.gui["__UI_CACHE__"]["Selector"].offsets.height = selector_height
            elementReference.gui["__UI_CACHE__"]["Selector"].text.text = elementReference.gui.text
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Selector"].text.fontColor = tocolor(unpackColor(elementReference.gui.fontColor or elementTemplate.fontColor))
            end
            elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Selector"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Selector"].offsets.startY + (elementTemplate.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Selector"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Selector"].offsets.width
            elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Selector"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Selector"].offsets.height
            elementReference.gui["__UI_CACHE__"].reloadElement = nil
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end
        ]]
        
        --dxDrawText(elementReference.gui["__UI_CACHE__"]["Selector"].text.text, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Selector"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Selector"].text.fontColor, elementTemplate.fontScale or 1, elementTemplate.font, elementReference.gui.alignment.horizontal, elementReference.gui.alignment.vertical, true, false, selector_postGUI, false)
        renderElementChildren(element)
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
    else
        --if elementReference.gui["__UI_CACHE__"]["Selector"].offsets.width and elementReference.gui["__UI_CACHE__"]["Selector"].offsets.height then
            renderElementChildren(element, true, mouseReference)
        --end
    end
    return true

end