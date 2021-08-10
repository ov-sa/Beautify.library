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
        local slider_width, slider_height, slider_track_size, slider_thumb_size = elementReference.gui.width, elementReference.gui.height, elementTemplate.track.size, elementTemplate.thumb.size
        local slider_content_padding = availableElements[elementType].contentSection.padding
        local slider_postGUI = elementReference.gui.postGUI

        if not elementParent then dxSetRenderTarget() end
        if not elementReference.gui["__UI_CACHE__"]["Track"] then
            elementReference.gui["__UI_CACHE__"]["Track"] = {
                offsets = {
                    height = slider_track_size
                }
            }
        end
        if not elementReference.gui["__UI_CACHE__"]["Thumb"] then
            elementReference.gui["__UI_CACHE__"]["Thumb"] = {
                offsets = {}
            }
        end
        if not elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture or elementReference.gui["__UI_CACHE__"]["Thumb"].updateTexture then
            if not elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget then
                elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget = DxRenderTarget(slider_thumb_size, slider_thumb_size, true)
            end
            if elementReference.gui["__UI_CACHE__"]["Thumb"].updateTexture then
                if elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture and isElement(elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture) then
                    elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture:destroy()
                    elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture = nil
                end
            end
            dxSetRenderTarget(elementReference.gui["__UI_CACHE__"]["Thumb"].renderTarget, true)
            dxSetBlendMode("modulate_add")
            dxDrawRectangle(0, 0, slider_thumb_size, slider_thumb_size, tocolor(unpackColor(elementTemplate.thumb.color)), false)
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

        local slider_percent = nil
        if slider_type == "horizontal" then
            local slider_track_width = slider_width - (slider_content_padding*2)
            if (slider_track_width > 0) and (slider_height > slider_track_size) then
                slider_percent = elementReference.gui.slideBar_Horizontal.currentPercent
                elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX = slider_startX + slider_content_padding
                elementReference.gui["__UI_CACHE__"]["Track"].offsets.width = slider_track_width
                local slider_thumb_startX = math.max(slider_startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + (slider_track_width - slider_thumb_size)*(slider_percent*0.01))
                if not elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY or not elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY or not elementReference.gui["__UI_CACHE__"]["Track"].offsets.height or not elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width or not elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height or elementReference.gui["__UI_CACHE__"].updateOffsets then
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.height = math.min(slider_track_size, slider_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width = math.min(slider_thumb_size, slider_width)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height = math.min(slider_thumb_size, slider_height)
                    local slider_track_startY = slider_startY + ((slider_height + (slider_track_size + slider_thumb_size))*0.5)
                    local slider_thumb_startY = slider_track_startY + ((slider_track_size - slider_thumb_size)*0.5)
                    local slider_exceeded_height = math.max(slider_track_startY + elementReference.gui["__UI_CACHE__"]["Track"].offsets.height, slider_thumb_startY + elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height) - (slider_startY + slider_height)
                    slider_exceeded_height = math.max(0, slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY = math.max(slider_startY, slider_track_startY - slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY = math.max(slider_startY, slider_thumb_startY - slider_exceeded_height)
                end
                elementReference.gui["__UI_CACHE__"].updateOffsets = nil
                elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX = slider_thumb_startX
            end
        else
            local slider_track_height = slider_height - (slider_content_padding*2)
            if (slider_track_height > 0) and (slider_width > slider_track_size) then
                slider_percent = elementReference.gui.slideBar_Vertical.currentPercent
                elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY = slider_startY + slider_content_padding
                elementReference.gui["__UI_CACHE__"]["Track"].offsets.height = slider_track_height
                local slider_thumb_startY = math.max(slider_startY, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY + (slider_track_height - slider_thumb_size)*(slider_percent*0.01))
                if not elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX or not elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX or not elementReference.gui["__UI_CACHE__"]["Track"].offsets.width or not elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width or not elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height or elementReference.gui["__UI_CACHE__"].updateOffsets then
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.width = math.min(slider_track_size, slider_width)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width = math.min(slider_thumb_size, slider_width)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height = math.min(slider_thumb_size, slider_height)
                    local slider_track_startX = slider_startX + (slider_width - ((slider_width + (slider_track_size + slider_thumb_size))*0.5)) - (slider_thumb_size*0.5)
                    local slider_thumb_startX = slider_track_startX + ((slider_track_size - slider_thumb_size)*0.5)
                    local slider_exceeded_height = math.max(slider_track_startX + elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, slider_thumb_startX + elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width) - (slider_startX + slider_width)
                    slider_exceeded_height = math.max(0, slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX = math.max(slider_startX, slider_track_startX - slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX = math.max(slider_startX, slider_thumb_startX - slider_exceeded_height)
                end
                elementReference.gui["__UI_CACHE__"].updateOffsets = nil
                elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY = slider_thumb_startY
            end
        end

        if elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY then
            local slider_track_progressed_color, slider_track_unprogressed_color, slider_fontColor = tocolor(elementTemplate.track.progressedColor[1], elementTemplate.track.progressedColor[2], elementTemplate.track.progressedColor[3], elementTemplate.track.progressedColor[4]*elementReference.gui.animAlphaPercent), tocolor(elementTemplate.track.unprogressedColor[1], elementTemplate.track.unprogressedColor[2], elementTemplate.track.unprogressedColor[3], elementTemplate.track.unprogressedColor[4]*elementReference.gui.animAlphaPercent), (elementReference.gui.fontColor and tocolor(elementReference.gui.fontColor[1], elementReference.gui.fontColor[2], elementReference.gui.fontColor[3], elementReference.gui.fontColor[4]*elementReference.gui.animAlphaPercent)) or tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            if slider_type == "horizontal" then
                local slider_track_progressed_length = elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX - elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + slider_thumb_size
                local slider_track_unprogressed_length = elementReference.gui["__UI_CACHE__"]["Track"].offsets.width - slider_track_progressed_length
                if slider_track_progressed_length > 0 then
                    dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, slider_track_progressed_length, elementReference.gui["__UI_CACHE__"]["Track"].offsets.height, slider_track_progressed_color, slider_postGUI)
                end
                if slider_track_unprogressed_length > 0 then
                    dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + slider_track_progressed_length, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, slider_track_unprogressed_length, elementReference.gui["__UI_CACHE__"]["Track"].offsets.height, slider_track_unprogressed_color, slider_postGUI)
                end
                if elementReference.gui.text then
                    dxDrawText(elementReference.gui.text..": "..slider_percent.."%", elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, slider_startY + (elementTemplate.fontPaddingY or 0), elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, math.min(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY), slider_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "right", "bottom", true, false, slider_postGUI, false)
                end
            else
                local slider_track_progressed_length = elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY - elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY + slider_thumb_size
                local slider_track_unprogressed_length = elementReference.gui["__UI_CACHE__"]["Track"].offsets.height - slider_track_progressed_length
                if slider_track_progressed_length > 0 then
                    dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, slider_track_progressed_length, slider_track_progressed_color, slider_postGUI)
                end
                if slider_track_unprogressed_length > 0 then
                    dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY + slider_track_progressed_length, elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, slider_track_unprogressed_length, slider_track_unprogressed_color, slider_postGUI)
                end
                if elementReference.gui.text then
                    local slider_text_rotValue = slider_width*0.5
                    dxDrawText(elementReference.gui.text..": "..slider_percent.."%", slider_startX + slider_content_padding, slider_startY + (elementTemplate.fontPaddingY or 0), slider_startX + slider_height - slider_content_padding, slider_startY + slider_width - math.max(elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width), slider_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "right", "bottom", true, false, slider_postGUI, false, false, 90, slider_startX + slider_text_rotValue, slider_startY + slider_text_rotValue)
                end
            end
            if elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture then
                dxDrawImage(elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height, elementReference.gui["__UI_CACHE__"]["Thumb"].renderTexture, 0, 0, 0, tocolor(255, 255, 255, 255), slider_postGUI)
            end
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        renderElementChildren(element, true, mouseReference)
        local isElementHovered = CLIENT_HOVERED_ELEMENT == element
        local isSliderHovered, isSliderThumbHovered = false, false
        if isElementHovered then
            if not elementReference.isDisabled then
                isSliderHovered = isElementHovered
            end
        end
        if isSliderHovered then
            if elementReference.gui.hoverStatus ~= "forward" then
                elementReference.gui.hoverStatus = "forward"
                elementReference.gui.hoverAnimTickCounter = getTickCount()
            end
            if elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY then
                isSliderThumbHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX, __mouseReference.y + elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height)
            end
        else
            if elementReference.gui.hoverStatus ~= "backward" then
                elementReference.gui.hoverStatus = "backward"
                elementReference.gui.hoverAnimTickCounter = getTickCount()
            end
        end
        if isSliderThumbHovered then
            if isKeyClicked("mouse1") then
                outputChatBox("CLICKED THUMB")
                --TODO: DO QUERIES
            end
        else

        end
    end
    return true

end