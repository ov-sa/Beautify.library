----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Slider's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    isKeyClicked = isKeyClicked,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    manageElementForceRender = manageElementForceRender,
    renderElementChildren = renderElementChildren,
    attachUIElement = attachUIElement,
    unpackColor = unpackColor,
    getAbsoluteCursorPosition = getAbsoluteCursorPosition,
    isMouseOnPosition = isMouseOnPosition,
    getInterpolationProgress = getInterpolationProgress,
    interpolateBetween = interpolateBetween,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxDrawRectangle = dxDrawRectangle,
    dxDrawText = dxDrawText,
    math = {
        min = math.min,
        max = math.max,
        ceil = math.ceil,
        round = math.round
    }
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_slider"


----------------------------------
--[[ Function: Renders Slider ]]--
----------------------------------

function renderSlider(element, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementRootToBeForceRendered = false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
        local slider_type = elementReference.gui.type
        local slider_postGUI = elementReference.gui.postGUI

        if slider_type == "horizontal" then
            local isSlideInterpolationDone = imports.math.round(elementReference.gui.slideBar_Horizontal.currentPercent, 2) == imports.math.round(elementReference.gui.slideBar_Horizontal.finalPercent, 2)
            if not isSlideInterpolationDone then
                isElementRootToBeForceRendered = true
                elementReference.gui.slideBar_Horizontal.currentPercent = imports.interpolateBetween(elementReference.gui.slideBar_Horizontal.currentPercent, 0, 0, elementReference.gui.slideBar_Horizontal.finalPercent, 0, 0, 0.25, "InQuad")
            end
            isElementToBeUpdated = isElementToBeUpdated or (not isSlideInterpolationDone)
        elseif slider_type == "vertical" then
            local isSlideInterpolationDone = imports.math.round(elementReference.gui.slideBar_Vertical.currentPercent, 2) == imports.math.round(elementReference.gui.slideBar_Vertical.finalPercent, 2)
            if not isSlideInterpolationDone then
                isElementRootToBeForceRendered = true
                elementReference.gui.slideBar_Vertical.currentPercent = imports.interpolateBetween(elementReference.gui.slideBar_Vertical.currentPercent, 0, 0, elementReference.gui.slideBar_Vertical.finalPercent, 0, 0, 0.25, "InQuad")
            end
            isElementToBeUpdated = isElementToBeUpdated or (not isSlideInterpolationDone)
        end
        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Slider"] then
                elementReference.gui["__UI_CACHE__"]["Slider"] = {
                    text = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Track"] = {
                    offsets = {}
                }
                elementReference.gui["__UI_CACHE__"]["Thumb"] = {
                    offsets = {}
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"] = {}
            end
            local slider_startX, slider_startY = elementReference.gui.x, elementReference.gui.y
            local slider_content_padding = availableElements[elementType].contentSection.padding
            local slider_width, slider_height, slider_track_size, slider_thumb_size = elementReference.gui.width, elementReference.gui.height, elementTemplate.track.size, elementTemplate.thumb.size
            if slider_type == "horizontal" then
                local slider_track_width = slider_width - (slider_content_padding*2)
                if (slider_track_width > 0) and (slider_height > slider_track_size) then
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX = slider_startX + slider_content_padding
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.width = slider_track_width
                    local slider_thumb_startX = imports.math.max(slider_startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + (slider_track_width - slider_thumb_size)*(elementReference.gui.slideBar_Horizontal.currentPercent*0.01))
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.height = imports.math.min(slider_track_size, slider_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width = imports.math.min(slider_thumb_size, slider_width)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height = imports.math.min(slider_thumb_size, slider_height)
                    local slider_track_startY = slider_startY + ((slider_height + (slider_track_size + slider_thumb_size))*0.5)
                    local slider_thumb_startY = slider_track_startY + ((slider_track_size - slider_thumb_size)*0.5)
                    local slider_exceeded_height = imports.math.max(slider_track_startY + elementReference.gui["__UI_CACHE__"]["Track"].offsets.height, slider_thumb_startY + elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height) - (slider_startY + slider_height)
                    slider_exceeded_height = imports.math.max(0, slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY = imports.math.max(slider_startY, slider_track_startY - slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY = imports.math.max(slider_startY, slider_thumb_startY - slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX = slider_thumb_startX
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.text = (elementReference.gui.text and elementReference.gui.text..": "..imports.math.round(elementReference.gui.slideBar_Horizontal.currentPercent, 0).."%") or nil
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startY = slider_startY + (elementTemplate.fontPaddingY or 0)
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Track"].offsets.width
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endY = imports.math.min(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY)
                    local slider_track_progressed_length = imports.math.max(0, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX - elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + slider_thumb_size)
                    local slider_track_unprogressed_length = elementReference.gui["__UI_CACHE__"]["Track"].offsets.width - slider_track_progressed_length
                    elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth = slider_track_progressed_length
                    elementReference.gui["__UI_CACHE__"]["Track"].unprogressedWidth = slider_track_unprogressed_length
                end
            elseif slider_type == "vertical" then
                local slider_track_height = slider_height - (slider_content_padding*2)
                if (slider_track_height > 0) and (slider_width > slider_track_size) then
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY = slider_startY + slider_content_padding
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.height = slider_track_height
                    local slider_thumb_startY = imports.math.max(slider_startY, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY + (slider_track_height - slider_thumb_size)*(elementReference.gui.slideBar_Vertical.currentPercent*0.01))
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.width = imports.math.min(slider_track_size, slider_width)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width = imports.math.min(slider_thumb_size, slider_width)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height = imports.math.min(slider_thumb_size, slider_height)
                    local slider_track_startX = slider_startX + (slider_width - ((slider_width + (slider_track_size + slider_thumb_size))*0.5)) - (slider_thumb_size*0.5)
                    local slider_thumb_startX = slider_track_startX + ((slider_track_size - slider_thumb_size)*0.5)
                    local slider_exceeded_height = imports.math.max(slider_track_startX + elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, slider_thumb_startX + elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width) - (slider_startX + slider_width)
                    slider_exceeded_height = imports.math.max(0, slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX = imports.math.max(slider_startX, slider_track_startX - slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX = imports.math.max(slider_startX, slider_thumb_startX - slider_exceeded_height)
                    elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY = slider_thumb_startY
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotValue = slider_width*0.5
                    local slider_text_offsetY = slider_width - (imports.math.max(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX + (elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width*0.5)) - slider_startX) - 2
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.text = (elementReference.gui.text and elementReference.gui.text..": "..imports.math.round(elementReference.gui.slideBar_Vertical.currentPercent, 0).."%") or nil
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startX = slider_startX + slider_content_padding
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startY = slider_startY + (elementTemplate.fontPaddingY or 0)
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endX = slider_startX + slider_height - slider_content_padding
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endY = slider_startY + slider_text_offsetY
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotX = slider_startX + elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotValue
                    elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotY = slider_startY + elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotValue
                    local slider_track_progressed_length = imports.math.max(0, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY - elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY + slider_thumb_size)
                    local slider_track_unprogressed_length = elementReference.gui["__UI_CACHE__"]["Track"].offsets.height - slider_track_progressed_length
                    elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth = slider_track_progressed_length
                    elementReference.gui["__UI_CACHE__"]["Track"].unprogressedWidth = slider_track_unprogressed_length
                end
            end
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Thumb"].color = imports.tocolor(imports.unpackColor(elementTemplate.thumb.color))
            end
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].startX = elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].startY = elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].width = elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].height = elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY then
            if not elementReference.gui.animAlphaPercent then
                elementReference.gui.animAlphaPercent = 0.8
                elementReference.gui.hoverStatus = "backward"
                elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
            end
            elementReference.gui.interpolationProgress = imports.getInterpolationProgress(elementReference.gui.hoverAnimTickCounter, availableElements[elementType].contentSection.hoverAnimDuration)
            local isTextHoverInterpolationRendering = elementReference.gui.interpolationProgress < 1
            if isElementInterpolationToBeRefreshed or isTextHoverInterpolationRendering then
                isElementRootToBeForceRendered = isElementRootToBeForceRendered or isTextHoverInterpolationRendering
                if elementReference.gui.hoverStatus == "forward" then
                    elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 1, 0, 0, elementReference.gui.interpolationProgress, "InQuad")
                else
                    elementReference.gui.animAlphaPercent = imports.interpolateBetween(elementReference.gui.animAlphaPercent, 0, 0, 0.8, 0, 0, elementReference.gui.interpolationProgress, "InQuad")
                end
            end
            local slider_track_progressed_color, slider_track_unprogressed_color, slider_fontColor = imports.tocolor(elementTemplate.track.progressedColor[1], elementTemplate.track.progressedColor[2], elementTemplate.track.progressedColor[3], elementTemplate.track.progressedColor[4]*elementReference.gui.animAlphaPercent), imports.tocolor(elementTemplate.track.unprogressedColor[1], elementTemplate.track.unprogressedColor[2], elementTemplate.track.unprogressedColor[3], elementTemplate.track.unprogressedColor[4]*elementReference.gui.animAlphaPercent), (elementReference.gui.fontColor and imports.tocolor(elementReference.gui.fontColor[1], elementReference.gui.fontColor[2], elementReference.gui.fontColor[3], elementReference.gui.fontColor[4]*elementReference.gui.animAlphaPercent)) or imports.tocolor(elementTemplate.fontColor[1], elementTemplate.fontColor[2], elementTemplate.fontColor[3], elementTemplate.fontColor[4]*elementReference.gui.animAlphaPercent)
            if slider_type == "horizontal" then
                if elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth > 0 then
                    imports.dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth, elementReference.gui["__UI_CACHE__"]["Track"].offsets.height, slider_track_progressed_color, slider_postGUI)
                end
                if elementReference.gui["__UI_CACHE__"]["Track"].unprogressedWidth > 0 then
                    imports.dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Track"].unprogressedWidth, elementReference.gui["__UI_CACHE__"]["Track"].offsets.height, slider_track_unprogressed_color, slider_postGUI)
                end
                if elementReference.gui["__UI_CACHE__"]["Slider"].text.text then
                    imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Slider"].text.text, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endY, slider_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "right", "bottom", true, false, slider_postGUI, false)
                end
            else
                if elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth > 0 then
                    imports.dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth, slider_track_progressed_color, slider_postGUI)
                end
                if elementReference.gui["__UI_CACHE__"]["Track"].unprogressedWidth > 0 then
                    imports.dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Track"].progressedWidth, elementReference.gui["__UI_CACHE__"]["Track"].offsets.width, elementReference.gui["__UI_CACHE__"]["Track"].unprogressedWidth, slider_track_unprogressed_color, slider_postGUI)
                end
                if elementReference.gui["__UI_CACHE__"]["Slider"].text.text then
                    imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Slider"].text.text, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.endY, slider_fontColor, elementTemplate.fontScale or 1, elementTemplate.font, "right", "bottom", true, false, slider_postGUI, false, false, 90, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotX, elementReference.gui["__UI_CACHE__"]["Slider"].text.offsets.rotY)
                end
            end
            imports.dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.width, elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.height, elementReference.gui["__UI_CACHE__"]["Thumb"].color, slider_postGUI)
            imports.manageElementForceRender(element, isElementRootToBeForceRendered)
            imports.renderElementChildren(element)
            imports.dxSetBlendMode("blend")
            if not elementParent then
                imports.dxSetRenderTarget()
            else
                imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
        end
    else
        if elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startX and elementReference.gui["__UI_CACHE__"]["Thumb"].offsets.startY then
            local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
            imports.renderElementChildren(element, true, mouseReference)
            local isElementHovered = CLIENT_HOVERED_ELEMENT.element == element
            local isSliderHovered, isSliderThumbHovered = false, false
            if isElementHovered then
                if not elementReference.isDisabled then
                    isSliderHovered = isElementHovered
                end
            end
            if isSliderHovered then
                if elementReference.gui.hoverStatus ~= "forward" then
                    elementReference.gui.hoverStatus = "forward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
                isSliderThumbHovered = imports.isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Thumb"].height)
            else
                if elementReference.gui.hoverStatus ~= "backward" then
                    elementReference.gui.hoverStatus = "backward"
                    elementReference.gui.hoverAnimTickCounter = CLIENT_CURRENT_TICK
                end
            end
            if CLIENT_ATTACHED_ELEMENT and (CLIENT_ATTACHED_ELEMENT.element == element) and CLIENT_ATTACHED_ELEMENT.isInternal then
                local cursor_offsetX, cursor_offsetY = imports.getAbsoluteCursorPosition()
                if cursor_offsetX and cursor_offsetY then
                    local slider_type = elementReference.gui.type
                    if slider_type == "horizontal" then
                        elementReference.gui.slideBar_Horizontal.finalPercent = imports.math.max(0, imports.math.min(100, (cursor_offsetX - (__mouseReference.x + elementReference.gui["__UI_CACHE__"]["Track"].offsets.startX))/elementReference.gui["__UI_CACHE__"]["Track"].offsets.width*100))
                    elseif slider_type == "vertical" then
                        elementReference.gui.slideBar_Vertical.finalPercent = imports.math.max(0, imports.math.min(100, (cursor_offsetY - (__mouseReference.y + elementReference.gui["__UI_CACHE__"]["Track"].offsets.startY))/elementReference.gui["__UI_CACHE__"]["Track"].offsets.height*100))
                    end
                end
            else
                if isSliderThumbHovered and imports.isKeyClicked("mouse1") and not elementReference.isDisabled then
                    imports.attachUIElement(element, true)
                end
            end
        end
    end
    return true

end