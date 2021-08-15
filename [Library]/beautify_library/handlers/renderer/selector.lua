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
        local selector_type = elementReference.gui.type
        local selector_postGUI = elementReference.gui.postGUI

        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Selector"] then
                elementReference.gui["__UI_CACHE__"]["Selector"] = {
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"] = {
                    offsets = {}
                }
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"] = {
                    offsets = {}
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Previous"] = {}
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Arrow_Next"] = {}
            end
            local selector_startX, selector_startY = elementReference.gui.x, elementReference.gui.y
            --local selector_content_padding = availableElements[elementType].contentSection.padding
            local selector_width, selector_height = elementReference.gui.width, elementReference.gui.height
            local selector_arrow_size = availableElements[elementType].minimumSize
            if selector_type == "horizontal" then
                local selector_arrow_offsetY = selector_startY + (selector_height - selector_arrow_size)/2
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX = selector_startX
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY = selector_arrow_offsetY
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX = selector_startX + selector_width - elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY = selector_arrow_offsetY
            elseif selector_type == "vertical" then
                local selector_arrow_offsetX = selector_startX + (selector_width - selector_arrow_size)/2
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY = selector_startY
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height = selector_arrow_size
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX = selector_arrow_offsetX
                elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY = selector_startY + selector_height - elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height
            end
        end
        if selector_type == "horizontal" then
            dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height, tocolor(255, 0, 0, 200), false)
            dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height, tocolor(0, 0, 255, 200), false)
        elseif selector_type == "vertical" then
            dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Previous"].offsets.height, tocolor(255, 0, 0, 200), false)
            dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.width, elementReference.gui["__UI_CACHE__"]["Arrow_Next"].offsets.height, tocolor(0, 0, 255, 200), false)
        end
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