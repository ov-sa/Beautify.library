----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: component: scrollbar.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Scroll Bar's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local componentType = "beautify_scrollbar"


--------------------------------------
--[[ Function: Renders Scroll Bar ]]--
--------------------------------------

function renderScrollbar(elementParent, renderData, referenceData, isFetchingInput)

    if not isUIValid(elementParent) or not renderData or not referenceData then return false end

    local elementReference = renderData.elementReference
    local scrollbar_overflownSize = renderData.overflownSize
    if not isFetchingInput then
        local componentTemplate = __getUITemplate(componentType, elementReference.sourceResource)
        local scrollbar_isHorizontal = referenceData.isHorizontal
        local scrollbar_startX, scrollbar_startY = renderData.startX, renderData.startY
        local scrollbar_width, scrollbar_height, scrollbar_thumb_size = nil, nil, nil
        local scrollbar_thumb_shadowSize = availableTemplates[componentType].thumb.shadowSize
        local scrollbar_track_color, scrollbar_thumb_color, scrollbar_thumb_shadow_color = tocolor(unpackColor(componentTemplate.track.color)), tocolor(unpackColor(componentTemplate.thumb.color)), tocolor(unpackColor(componentTemplate.thumb.shadowColor))
        local scrollbar_postGUI = renderData.postGUI
        if scrollbar_isHorizontal then
            scrollbar_width = renderData.width
            scrollbar_height = availableTemplates[componentType].size
            scrollbar_startY = scrollbar_startY - scrollbar_height
            scrollbar_thumb_size = math.max(math.min(scrollbar_width/2, availableTemplates[componentType].thumb.minSize), (scrollbar_width/(scrollbar_width + scrollbar_overflownSize))*scrollbar_width)
        else
            scrollbar_width = availableTemplates[componentType].size
            scrollbar_height = renderData.height
            scrollbar_startX = scrollbar_startX - scrollbar_width
            scrollbar_thumb_size = math.max(math.min(scrollbar_height/2, availableTemplates[componentType].thumb.minSize), (scrollbar_height/(scrollbar_height + scrollbar_overflownSize))*scrollbar_height)
        end

        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"].track = {
            height = scrollbar_height
        } 

        referenceData.finalThumbSize = scrollbar_thumb_size
        referenceData.currentThumbSize = interpolateBetween(referenceData.currentThumbSize, 0, 0, referenceData.finalThumbSize, 0, 0, 0.25, "InQuad")
        referenceData.currentPercent = interpolateBetween(referenceData.currentPercent, 0, 0, referenceData.finalPercent, 0, 0, 0.25, "InQuad")
        scrollbar_thumb_size = referenceData.currentThumbSize
        dxDrawRectangle(scrollbar_startX, scrollbar_startY, scrollbar_width, scrollbar_height, scrollbar_track_color, scrollbar_postGUI)
        if scrollbar_isHorizontal then
            local scrollbar_thumb_offset = (scrollbar_width - scrollbar_thumb_size)*(referenceData.currentPercent*0.01)
            dxDrawRectangle(scrollbar_startX + scrollbar_thumb_offset, scrollbar_startY, scrollbar_thumb_size, scrollbar_height, scrollbar_thumb_color, scrollbar_postGUI)
            dxDrawRectangle(scrollbar_startX + scrollbar_thumb_offset, scrollbar_startY, scrollbar_thumb_size, scrollbar_thumb_shadowSize, scrollbar_thumb_shadow_color, scrollbar_postGUI)
        else
            local scrollbar_thumb_offset = (scrollbar_height - scrollbar_thumb_size)*(referenceData.currentPercent*0.01)
            dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offset, scrollbar_width, scrollbar_thumb_size, scrollbar_thumb_color, scrollbar_postGUI)
            dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offset, scrollbar_thumb_shadowSize, scrollbar_thumb_size, scrollbar_thumb_shadow_color, scrollbar_postGUI)
        end
    else
        if not renderData.isDisabled then
            local scrollbar_scrollSpeed = (renderData.multiplier/scrollbar_overflownSize)*100
            local currentScrollState = {isMouseScrolled()}
            if currentScrollState[1] then
                if currentScrollState[1] == "up" then
                    if referenceData.finalPercent > 0 then
                        if scrollbar_overflownSize < elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"].track.height then scrollbar_scrollSpeed = scrollbar_scrollSpeed*25 end
                        referenceData.finalPercent = referenceData.finalPercent - (scrollbar_scrollSpeed*currentScrollState[2])
                    end
                elseif currentScrollState[1] == "down" then
                    if referenceData.finalPercent < 100 then
                        if scrollbar_overflownSize < elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"].track.height then scrollbar_scrollSpeed = scrollbar_scrollSpeed*25 end
                        referenceData.finalPercent = referenceData.finalPercent + (scrollbar_scrollSpeed*currentScrollState[2])
                    end
                end
                referenceData.finalPercent = math.max(0, math.min(100, referenceData.finalPercent))
                resetScrollCache()
                triggerEvent("onClientUIScroll", elementParent, (scrollbar_isHorizontal and ((currentScrollState[1] == "up" and "left") or "right")) or currentScrollState[1])
            end
        end
    end
    return true

end