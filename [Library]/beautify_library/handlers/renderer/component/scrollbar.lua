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

function renderScrollbar(elementParent, renderData, referenceData)

    if not isUIValid(elementParent) or not renderData or not referenceData then return false end

    local componentTemplate = getUITemplate(componentType)
    local scrollbar_startX, scrollbar_startY = renderData.startX, renderData.startY
    local scrollbar_width, scrollbar_height, scrollbar_overflownHeight, scrollbar_thumb_height = availableTemplates[componentType].width, renderData.height, renderData.overflownHeight, 0
    scrollbar_startX = scrollbar_startX - scrollbar_width
    scrollbar_thumb_height = math.max(math.min(scrollbar_height/2, availableTemplates[componentType].thumb.minHeight), (scrollbar_height/(scrollbar_height + scrollbar_overflownHeight))*scrollbar_height)
    local scrollbar_thumb_shadowSize = availableTemplates[componentType].thumb.shadowSize
    local scrollbar_track_color, scrollbar_thumb_color, scrollbar_thumb_shadow_color = tocolor(unpackColor(componentTemplate.track.color)), tocolor(unpackColor(componentTemplate.thumb.color)), tocolor(unpackColor(componentTemplate.thumb.shadowColor))
    local scrollbar_isHorizontal = referenceData.isHorizontal
    local scrollbar_postGUI = renderData.postGUI

    referenceData.finalThumbHeight = scrollbar_thumb_height
    referenceData.currentThumbSize = interpolateBetween(referenceData.currentThumbSize, 0, 0, referenceData.finalThumbHeight, 0, 0, 0.25, "InQuad")
    referenceData.currentPercent = interpolateBetween(referenceData.currentPercent, 0, 0, referenceData.finalPercent, 0, 0, 0.25, "InQuad")
    scrollbar_thumb_height = referenceData.currentThumbSize
    local scrollbar_thumb_offsetY = (scrollbar_height - scrollbar_thumb_height)*(referenceData.currentPercent*0.01)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY, scrollbar_width, scrollbar_height, scrollbar_track_color, scrollbar_postGUI)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offsetY, scrollbar_width, scrollbar_thumb_height, scrollbar_thumb_color, scrollbar_postGUI)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offsetY, scrollbar_thumb_shadowSize, scrollbar_thumb_height, scrollbar_thumb_shadow_color, scrollbar_postGUI)
    if not renderData.isDisabled then
        local scrollbar_scrollSpeed = (renderData.multiplier/scrollbar_overflownHeight)*100
        local currentScrollState = {isMouseScrolled()}
        if currentScrollState[1] then
            if currentScrollState[1] == "up" then
                if referenceData.finalPercent > 0 then
                    if scrollbar_overflownHeight < scrollbar_height then scrollbar_scrollSpeed = scrollbar_scrollSpeed*25 end
                    referenceData.finalPercent = referenceData.finalPercent - (scrollbar_scrollSpeed*currentScrollState[2])
                end
            elseif currentScrollState[1] == "down" then
                if referenceData.finalPercent < 100 then
                    if scrollbar_overflownHeight < scrollbar_height then scrollbar_scrollSpeed = scrollbar_scrollSpeed*25 end
                    referenceData.finalPercent = referenceData.finalPercent + (scrollbar_scrollSpeed*currentScrollState[2])
                end
            end
            referenceData.finalPercent = math.max(0, math.min(100, referenceData.finalPercent))
            resetScrollCache()
            triggerEvent("onClientUIScroll", elementParent, (scrollbar_isHorizontal and ((currentScrollState[1] == "up" and "left") or "right")) or currentScrollState[1])
        end
    end
    return true

end