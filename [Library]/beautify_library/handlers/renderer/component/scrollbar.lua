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
    local scrollbar_track_color, scrollbar_thumb_color, scrollbar_thumb_shadow_color = tocolor(unpack(componentTemplate.track.color)), tocolor(unpack(componentTemplate.thumb.color)), tocolor(unpack(componentTemplate.thumb.shadowColor))
    local scrollbar_postGUI = renderData.postGUI

    if not referenceData.finalPercent then referenceData.finalPercent = 0 end
    referenceData.currentPercent = interpolateBetween(referenceData.currentPercent, 0, 0, referenceData.finalPercent, 0, 0, 0.08, "InQuad")
    local scrollbar_thumb_offsetY = (scrollbar_height - scrollbar_thumb_height)*(referenceData.currentPercent*0.01)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY, scrollbar_width, scrollbar_height, scrollbar_track_color, scrollbar_postGUI)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offsetY, scrollbar_width, scrollbar_thumb_height, scrollbar_thumb_color, scrollbar_postGUI)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offsetY, scrollbar_thumb_shadowSize, scrollbar_thumb_height, scrollbar_thumb_shadow_color, scrollbar_postGUI)
    if not renderData.isDisabled then
        local currentScrollState = {isMouseScrolled()}
        if currentScrollState[1] then
            if currentScrollState[1] == "up" then
                if referenceData.finalPercent > 0 then
                    if scrollbar_overflownHeight < scrollbar_height then
                        referenceData.finalPercent = referenceData.finalPercent - (10*currentScrollState[2])
                    else
                        referenceData.finalPercent = referenceData.finalPercent - (1*currentScrollState[2])
                    end
                end
            elseif currentScrollState[1] == "down" then
                if referenceData.finalPercent < 100 then
                    if scrollbar_overflownHeight < scrollbar_height then
                        referenceData.finalPercent = referenceData.finalPercent + (10*currentScrollState[2])
                    else
                        referenceData.finalPercent = referenceData.finalPercent + (1*currentScrollState[2])
                    end
                end
            end
            referenceData.finalPercent = math.max(0, math.min(100, referenceData.finalPercent))
            resetScrollCache()
        end
    end
    return true

end