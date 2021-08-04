----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Slider's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_slider"


----------------------------------
--[[ Function: Renders Label ]]--
----------------------------------

function renderSlider(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementParent = getUIParent(element)
    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local slider_startX, slider_startY = elementReference.gui.x, elementReference.gui.y
        local slider_width, slider_height = elementReference.gui.width, elementReference.gui.height
        local label_thumb_color = tocolor(unpackColor(elementTemplate.thumb.color))
        local slider_postGUI = elementReference.gui.postGUI

        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX = slider_startX
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY = slider_startY
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width = slider_width
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height = slider_height

        if not elementParent then dxSetRenderTarget() end
        if not elementReference.gui["__UI_CACHE__"]["Content Section"] or not elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture or elementReference.gui["__UI_CACHE__"]["Content Section"].updateTexture then
            if not elementReference.gui["__UI_CACHE__"]["Content Section"] then
                elementReference.gui["__UI_CACHE__"]["Content Section"] = {}
            end
            if not elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget then
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget = DxRenderTarget(slider_width, slider_height, true)
            end
            if elementReference.gui["__UI_CACHE__"]["Content Section"].updateTexture then
                if elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture and isElement(elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture) then
                    elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture:destroy()
                    elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture = nil
                end
            end
            dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget, true)
            dxSetBlendMode("modulate_add")
            local slider_borderSize = availableElements[elementType].minimumSize*0.5
            local slider_color = tocolor(unpackColor(elementTemplate.color))
            dxDrawImage(0, 0, slider_borderSize, slider_borderSize, createdAssets["images"]["curved_square/semi_thick/top_left.png"], 0, 0, 0, slider_color, false)
            dxDrawImage(slider_width - slider_borderSize, 0, slider_borderSize, slider_borderSize, createdAssets["images"]["curved_square/semi_thick/top_right.png"], 0, 0, 0, slider_color, false)
            dxDrawImage(0, slider_height - slider_borderSize, slider_borderSize, slider_borderSize, createdAssets["images"]["curved_square/semi_thick/bottom_left.png"], 0, 0, 0, slider_color, false)
            dxDrawImage(slider_width - slider_borderSize, slider_height - slider_borderSize, slider_borderSize, slider_borderSize, createdAssets["images"]["curved_square/semi_thick/bottom_right.png"], 0, 0, 0, slider_color, false)
            if slider_width > availableElements[elementType].minimumSize then
                dxDrawRectangle(slider_borderSize, 0, slider_width - availableElements[elementType].minimumSize, slider_height, slider_color, false)
            end
            if slider_height > availableElements[elementType].minimumSize then
                dxDrawRectangle(0, slider_borderSize, slider_borderSize, slider_height - availableElements[elementType].minimumSize, slider_color, false)
                dxDrawRectangle(slider_width - slider_borderSize, slider_borderSize, slider_borderSize, slider_height - availableElements[elementType].minimumSize, slider_color, false)
            end
            dxSetBlendMode("blend")
            if not elementParent then
                dxSetRenderTarget()
            else
                dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
            local renderPixels = dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget)
            if renderPixels then
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture = DxTexture(renderPixels, "argb", false, "clamp")
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget:destroy()
                elementReference.gui["__UI_CACHE__"]["Content Section"].renderTarget = nil
                elementReference.gui["__UI_CACHE__"]["Content Section"].updateTexture = nil
            end
        end

        if not elementReference.gui.animAlphaPercent then
            elementReference.gui.animAlphaPercent = 0.25
            elementReference.gui.hoverStatus = "backward"
            elementReference.gui.hoverAnimTickCounter = getTickCount()
        end
        if elementReference.gui.hoverStatus == "forward" then
            elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
        else
            elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.25, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
        end
        renderElementChildren(element)
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        local slider_fontColor = tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
        if elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture then
            dxDrawImage(slider_startX, slider_startY, slider_width, slider_height, elementReference.gui["__UI_CACHE__"]["Content Section"].renderTexture, 0, 0, 0, tocolor(255, 255, 255, 255), slider_postGUI)
        end
        --dxDrawText(elementReference.gui.text, slider_startX, slider_startY + (elementTemplate.fontPaddingY or 0), slider_startX + slider_width, slider_startY + slider_height, tocolor(unpackColor(elementReference.gui.fontColor or elementTemplate.fontColor)), elementTemplate.fontScale or 1, elementTemplate.font, elementReference.gui.alignment.horizontal, elementReference.gui.alignment.vertical, true, false, slider_postGUI, false)
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        renderElementChildren(element, true, mouseReference)
        if elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width and elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height then
            local isElementHovered = CLIENT_HOVERED_ELEMENT == element
            local isSliderHovered = false
            if isElementHovered then
                if not elementReference.isDisabled then
                    isSliderHovered = isElementHovered
                    --isSliderHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height)
                end
            end
            if isSliderHovered then
                if elementReference.gui.hoverStatus ~= "forward" then
                    elementReference.gui.hoverStatus = "forward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = getTickCount()
                end
            end
        end
    end
    return true

end