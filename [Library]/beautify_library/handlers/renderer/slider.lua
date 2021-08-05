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
        local slider_type = elementReference.gui.type
        local slider_startX, slider_startY = elementReference.gui.x, elementReference.gui.y
        local slider_width, slider_height, slider_track_size, slider_thumb_size, slider_thumb_shadow_size = elementReference.gui.width, elementReference.gui.height, elementTemplate.track.size, elementTemplate.thumb.size, elementTemplate.thumb.shadowSize
        local slider_thumb_container_size = slider_thumb_size + (slider_thumb_shadow_size*2)
        local slider_content_padding = availableElements["beautify_window"].contentSection.padding
        local slider_postGUI = elementReference.gui.postGUI

        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startX = slider_startX
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].startY = slider_startY
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].width = slider_width
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"].height = slider_height

        if not elementParent then dxSetRenderTarget() end
        if not elementReference.gui["__UI_CACHE__"]["Thumb"] or not elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture or elementReference.gui["__UI_CACHE__"]["Thumb"].updateTexture then
            if not elementReference.gui["__UI_CACHE__"]["Thumb"] then
                elementReference.gui["__UI_CACHE__"]["Thumb"] = {}
            end
            if not elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget then
                elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget = DxRenderTarget(slider_thumb_container_size, slider_thumb_container_size, true)
            end
            if elementReference.gui["__UI_CACHE__"]["Thumb"].updateTexture then
                if elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture and isElement(elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture) then
                    elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture:destroy()
                    elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture = nil
                end
            end
            dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget, true)
            dxSetBlendMode("modulate_add")
            dxDrawRectangle(0, 0, slider_thumb_container_size, slider_thumb_container_size, tocolor(unpackColor(elementTemplate.thumb.shadowColor)), false)
            dxDrawRectangle(slider_thumb_shadow_size, slider_thumb_shadow_size, slider_thumb_size, slider_thumb_size, tocolor(unpackColor(elementTemplate.thumb.color)), false)
            dxSetBlendMode("blend")
            if not elementParent then
                dxSetRenderTarget()
            else
                dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
            local renderPixels = dxGetTexturePixels(elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget)
            if renderPixels then
                elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture = DxTexture(renderPixels, "argb", false, "clamp")
                elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget:destroy()
                elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget = nil
                elementReference.gui["__UI_CACHE__"]["Thumb"].updateTexture = nil
            end
        end

        if not elementReference.gui.animAlphaPercent then
            elementReference.gui.animAlphaPercent = 0.8
            elementReference.gui.hoverStatus = "backward"
            elementReference.gui.hoverAnimTickCounter = getTickCount()
        end
        if elementReference.gui.hoverStatus == "forward" then
            elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
        else
            elementReference.gui.animAlphaPercent = interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.8, 0, 0, getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration), "InQuad")
        end
        renderElementChildren(element)
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        local slider_percent = 0
        if slider_type == "horizontal" then
            slider_percent = elementReference.gui.slideBar_Horizontal.currentPercent
        else
            slider_percent = elementReference.gui.sliderBar_Vertical.currentPercent
        end
        local slider_track_color, slider_fontColor = tocolor(elementTemplate.track.color[1], elementTemplate.track.color[2], elementTemplate.track.color[3], elementTemplate.track.color[4]*elementReference.gui.animAlphaPercent), tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
        local slider_track_startX, slider_track_startY = slider_startX + slider_content_padding, slider_startY + (slider_height + (slider_track_size + slider_thumb_size + slider_thumb_shadow_size))*0.5
        local slider_thumb_startX, slider_thumb_startY = slider_track_startX - slider_thumb_shadow_size, slider_track_startY - slider_thumb_shadow_size + ((slider_track_size - slider_thumb_size)*0.5)
        dxDrawRectangle(slider_track_startX, slider_track_startY, slider_width - (slider_content_padding*2), slider_track_size, slider_track_color, slider_postGUI)
        dxDrawText("PROGRESS: "..slider_percent.."%", slider_startX + slider_content_padding, slider_startY + (elementTemplate.fontPaddingY or 0), slider_startX + slider_width - (slider_content_padding*2), slider_track_startY, slider_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "right", "bottom", true, false, slider_postGUI, false)
        if elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture then
            dxDrawImage(slider_track_startX, slider_thumb_startY, slider_thumb_container_size, slider_thumb_container_size, elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture, 0, 0, 0, tocolor(255, 255, 255, 255), slider_postGUI)
        end
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