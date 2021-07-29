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
    local scrollbar_width, scrollbar_height, scrollbar_thumb_height = availableTemplates[componentType].width, renderData.height, availableTemplates[componentType].thumb.minHeight
    scrollbar_startX = scrollbar_startX - scrollbar_width
    local scrollbar_thumb_shadowSize = availableTemplates[componentType].thumb.shadowSize
    local scrollbar_track_color, scrollbar_thumb_color, scrollbar_thumb_shadow_color = tocolor(unpack(componentTemplate.track.color)), tocolor(unpack(componentTemplate.thumb.color)), tocolor(unpack(componentTemplate.thumb.shadowColor))
    local scrollbar_postGUI = renderData.postGUI
    local scrollbar_thumb_offsetY = (scrollbar_height - scrollbar_thumb_height)*(referenceData.percent*0.01)

    dxDrawRectangle(scrollbar_startX, scrollbar_startY, scrollbar_width, scrollbar_height, scrollbar_track_color, scrollbar_postGUI)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offsetY, scrollbar_width, scrollbar_thumb_height, scrollbar_thumb_color, scrollbar_postGUI)
    dxDrawRectangle(scrollbar_startX, scrollbar_startY + scrollbar_thumb_offsetY, scrollbar_thumb_shadowSize, scrollbar_thumb_height, scrollbar_thumb_shadow_color, scrollbar_postGUI)
    --TODO: CHECK IF ELEMENT IS SCROLLABLE OR NOT & ADD SCROLL HANDLER..
    return true

end