----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: button.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Button's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    isElement = isElement,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    manageElementForceRender = manageElementForceRender,
    renderElementChildren = renderElementChildren,
    destroyElement = destroyElement,
    isMouseOnPosition = isMouseOnPosition,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxCreateRenderTarget = dxCreateRenderTarget,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxCreateTexture = dxCreateTexture,
    dxDrawImage = dxDrawImage,
    dxDrawRectangle = dxDrawRectangle,
    dxDrawText = dxDrawText,
    dxGetTexturePixels = dxGetTexturePixels,
    math = {
        max = math.max
    }
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_button"


----------------------------------
--[[ Function: Renders Button ]]--
----------------------------------

function renderButton(element, isActiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementToBeRendered, isElementToBeForceRendered = true, false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local button_width, button_height = elementReference.gui.size or elementReference.gui.width, elementReference.gui.size or elementReference.gui.height
        local button_type = elementReference.gui.type
        local button_postGUI = elementReference.gui.postGUI
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
        elementTemplate = elementTemplate[button_type]
    
        if not isElementToBeRendered then return false end
        if (isActiveMode or isElementToBeReloaded) and isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Button"] then
                elementReference.gui["__UI_CACHE__"]["Button"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
            end
            local button_startX, button_startY = elementReference.gui.x, elementReference.gui.y
            local button_content_padding = availableElements[elementType].contentSection.paddingX
            elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX = button_startX
            elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY = button_startY
            elementReference.gui["__UI_CACHE__"]["Button"].offsets.width = button_width
            elementReference.gui["__UI_CACHE__"]["Button"].offsets.height = button_height
            elementReference.gui["__UI_CACHE__"]["Button"].text.text = elementReference.gui.text
            elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX + button_content_padding
            elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY + (elementTemplate.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Button"].offsets.width - button_content_padding
            elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Button"].offsets.height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY = elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width = elementReference.gui["__UI_CACHE__"]["Button"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height = elementReference.gui["__UI_CACHE__"]["Button"].offsets.height
            if not elementReference.gui["__UI_CACHE__"]["Button"].renderTexture then
                if not elementReference.gui["__UI_CACHE__"]["Button"].renderTarget then
                    elementReference.gui["__UI_CACHE__"]["Button"].renderTarget = imports.dxCreateRenderTarget(button_width, button_height, true)
                end
                if elementReference.gui["__UI_CACHE__"]["Button"].renderTexture and imports.isElement(elementReference.gui["__UI_CACHE__"]["Button"].renderTexture) then
                    imports.destroyElement(elementReference.gui["__UI_CACHE__"]["Button"].renderTexture)
                    elementReference.gui["__UI_CACHE__"]["Button"].renderTexture = nil
                end
                imports.dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Button"].renderTarget, true)
                imports.dxSetBlendMode("modulate_add")
                if button_type == "default" then
                    local button_borderSize = availableElements[elementType].minimumSize*0.5
                    imports.dxDrawImage(0, 0, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/top_left.png"], 0, 0, 0, -1, false)
                    imports.dxDrawImage(button_width - button_borderSize, 0, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/top_right.png"], 0, 0, 0, -1, false)
                    imports.dxDrawImage(0, button_height - button_borderSize, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/bottom_left.png"], 0, 0, 0, -1, false)
                    imports.dxDrawImage(button_width - button_borderSize, button_height - button_borderSize, button_borderSize, button_borderSize, createdAssets["images"]["curved_square/semi_thick/bottom_right.png"], 0, 0, 0, -1, false)
                    if button_width > availableElements[elementType].minimumSize then
                        imports.dxDrawRectangle(button_borderSize, 0, button_width - availableElements[elementType].minimumSize, button_height, -1, false)
                    end
                    if button_height > availableElements[elementType].minimumSize then
                        imports.dxDrawRectangle(0, button_borderSize, button_borderSize, button_height - availableElements[elementType].minimumSize, -1, false)
                        imports.dxDrawRectangle(button_width - button_borderSize, button_borderSize, button_borderSize, button_height - availableElements[elementType].minimumSize, -1, false)
                    end
                end
                imports.dxSetBlendMode("blend")
                if not elementParent then
                    imports.dxSetRenderTarget()
                else
                    imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
                end
                local renderPixels = imports.dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Button"].renderTarget)
                if renderPixels then
                    elementReference.gui["__UI_CACHE__"]["Button"].renderTexture = imports.dxCreateTexture(renderPixels, "argb", false, "clamp")
                    imports.destroyElement(elementReference.gui["__UI_CACHE__"]["Button"].renderTarget)
                    elementReference.gui["__UI_CACHE__"]["Button"].renderTarget = nil
                end
            end
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if isActiveMode or isElementToBeReloaded then
            if isActiveMode then
                if not elementReference.gui.animAlphaPercent then
                    elementReference.gui.animAlphaPercent = 0
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
                elementReference.gui.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration)
            end
            local isButtonHoverInterpolationRendering = (elementReference.gui.interpolationProgress < 1) or (elementReference.gui.hoverStatus ~= "backward")
            if isElementToBeReloaded or isElementInterpolationToBeRefreshed or isButtonHoverInterpolationRendering then
                if isActiveMode then
                    isElementToBeForceRendered = isButtonHoverInterpolationRendering
                    if elementReference.gui.hoverStatus == "forward" then
                        elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, elementReference.gui.interpolationProgress, "InQuad")
                    else
                        elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0, 0, 0, elementReference.gui.interpolationProgress, "InQuad")
                    end
                end
                elementReference.gui["__UI_CACHE__"]["Button"].color = imports.tocolor(elementTemplate.color[1], elementTemplate.color[2], elementTemplate.color[3], elementTemplate.color[4]*(1 - elementReference.gui.animAlphaPercent))
                elementReference.gui["__UI_CACHE__"]["Button"].hoverColor = imports.tocolor(elementTemplate.hoverColor[1], elementTemplate.hoverColor[2], elementTemplate.hoverColor[3], elementTemplate.hoverColor[4]*elementReference.gui.animAlphaPercent)
                elementReference.gui["__UI_CACHE__"]["Button"].fontColor = imports.tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*(1 - elementReference.gui.animAlphaPercent))
                elementReference.gui["__UI_CACHE__"]["Button"].hoverFontColor = imports.tocolor(elementTemplate.hoverFontColor[1], elementTemplate.hoverFontColor[2], elementTemplate.hoverFontColor[3], elementTemplate.hoverFontColor[4]*elementReference.gui.animAlphaPercent)
            end
        end
        local isButtonHoverToBeRendered = elementReference.gui.animAlphaPercent > 0
        if elementReference.gui["__UI_CACHE__"]["Button"].renderTexture then
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Button"].offsets.width, elementReference.gui["__UI_CACHE__"]["Button"].offsets.height, elementReference.gui["__UI_CACHE__"]["Button"].renderTexture, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Button"].color, button_postGUI)
            if isButtonHoverToBeRendered then
                imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Button"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Button"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Button"].offsets.width, elementReference.gui["__UI_CACHE__"]["Button"].offsets.height, elementReference.gui["__UI_CACHE__"]["Button"].renderTexture, 0, 0, 0, elementReference.gui["__UI_CACHE__"]["Button"].hoverColor, button_postGUI)
            end
        end
        imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Button"].text.text, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Button"].fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, button_postGUI, false)
        if isButtonHoverToBeRendered then
            imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Button"].text.text, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Button"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Button"].hoverFontColor, elementTemplate.fontScale or 1, elementTemplate.font, "center", "center", true, false, button_postGUI, false)
        end
        if isActiveMode then
            imports.manageElementForceRender(element, isElementToBeForceRendered)
            imports.renderElementChildren(element, isActiveMode)
            imports.dxSetBlendMode("blend")
            if not elementParent then
                imports.dxSetRenderTarget()
            else
                imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
        end
    else
        if not isActiveMode then return false end
        if elementReference.gui["__UI_CACHE__"]["Button"].offsets.width and elementReference.gui["__UI_CACHE__"]["Button"].offsets.height then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            imports.renderElementChildren(element, isActiveMode, true, mouseReference)
            local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
            local isButtonHovered = false
            if isElementHovered then
                if not elementReference.isDisabled then
                    isButtonHovered = imports.isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height)
                end
            end
            if isButtonHovered then
                if elementReference.gui.hoverStatus ~= "forward" then
                    elementReference.gui.hoverStatus = "forward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            end
        end
    end
    return true

end