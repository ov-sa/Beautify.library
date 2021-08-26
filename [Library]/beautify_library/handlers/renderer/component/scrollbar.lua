----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: component: scrollbar.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Scroll Bar's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    triggerEvent = triggerEvent,
    isKeyOnHold = isKeyOnHold,
    __getUITemplate = __getUITemplate,
    resetScrollCache = resetScrollCache,
    unpackColor = unpackColor,
    interpolateBetween = interpolateBetween,
    dxDrawRectangle = dxDrawRectangle,
    math = {
        min = math.min,
        max = math.max
    }
}


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
    local scrollbar_isHorizontal = referenceData.isHorizontal
    local scrollbar_overflownSize = renderData.overflownSize
    if not isFetchingInput then
        local componentTemplate = imports.__getUITemplate(componentType, elementReference.sourceResource)
        local scrollbar_startX, scrollbar_startY = renderData.startX, renderData.startY
        local scrollbar_width, scrollbar_height, scrollbar_thumb_size = nil, nil, nil
        local scrollbar_thumb_shadowSize = availableTemplates[componentType].thumb.shadowSize
        local scrollbar_track_color, scrollbar_thumb_color, scrollbar_thumb_shadow_color = imports.tocolor(imports.unpackColor(componentTemplate.track.color)), imports.tocolor(imports.unpackColor(componentTemplate.thumb.color)), imports.tocolor(imports.unpackColor(componentTemplate.thumb.shadowColor))
        --TODO: CACHE COLOR SOMEHOW ...
        local scrollbar_postGUI = renderData.postGUI
        if scrollbar_isHorizontal then
            scrollbar_width = renderData.width
            scrollbar_height = availableTemplates[componentType].size
            scrollbar_startY = scrollbar_startY - scrollbar_height
            scrollbar_thumb_size = imports.math.max(imports.math.min(scrollbar_width*0.5, availableTemplates[componentType].thumb.minSize), (scrollbar_width/(scrollbar_width + scrollbar_overflownSize))*scrollbar_width)
            if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Horizontal"].track then
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Horizontal"].track = {}
            end
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Horizontal"].track.width = scrollbar_width
        else
            scrollbar_width = availableTemplates[componentType].size
            scrollbar_height = renderData.height
            scrollbar_startX = scrollbar_startX - scrollbar_width
            scrollbar_thumb_size = imports.math.max(imports.math.min(scrollbar_height*0.5, availableTemplates[componentType].thumb.minSize), (scrollbar_height/(scrollbar_height + scrollbar_overflownSize))*scrollbar_height)
            if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"].track then
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"].track = {}
            end
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"].track.height = scrollbar_height
        end

        referenceData.finalThumbSize = scrollbar_thumb_size
        if referenceData.currentThumbSize ~= referenceData.finalThumbSize then
            referenceData.currentThumbSize = imports.interpolateBetween(referenceData.currentThumbSize, 0, 0, referenceData.finalThumbSize, 0, 0, 0.25, "InQuad")
        end
        if referenceData.currentPercent ~= referenceData.finalPercent then
            referenceData.currentPercent = imports.interpolateBetween(referenceData.currentPercent, 0, 0, referenceData.finalPercent, 0, 0, 0.25, "InQuad")
        end
        scrollbar_thumb_size = referenceData.currentThumbSize
        imports.dxDrawRectangle(scrollbar_startX, scrollbar_startY, scrollbar_width, scrollbar_height, scrollbar_track_color, scrollbar_postGUI)
        if scrollbar_isHorizontal then
            local scrollbar_thumb_startX, scrollbar_thumb_startY = imports.math.max(scrollbar_startX, scrollbar_startX + (scrollbar_width - scrollbar_thumb_size)*(referenceData.currentPercent*0.01)), scrollbar_startY
            imports.dxDrawRectangle(scrollbar_thumb_startX, scrollbar_thumb_startY, scrollbar_thumb_size, scrollbar_height, scrollbar_thumb_color, scrollbar_postGUI)
            imports.dxDrawRectangle(scrollbar_thumb_startX, scrollbar_thumb_startY, scrollbar_thumb_size, scrollbar_thumb_shadowSize, scrollbar_thumb_shadow_color, scrollbar_postGUI)
        else
            local scrollbar_thumb_startX, scrollbar_thumb_startY = scrollbar_startX, imports.math.max(scrollbar_startY, scrollbar_startY + (scrollbar_height - scrollbar_thumb_size)*(referenceData.currentPercent*0.01))
            imports.dxDrawRectangle(scrollbar_thumb_startX, scrollbar_thumb_startY, scrollbar_width, scrollbar_thumb_size, scrollbar_thumb_color, scrollbar_postGUI)
            imports.dxDrawRectangle(scrollbar_thumb_startX, scrollbar_thumb_startY, scrollbar_thumb_shadowSize, scrollbar_thumb_size, scrollbar_thumb_shadow_color, scrollbar_postGUI)
        end
    else
        if not renderData.isDisabled then
            local currentScrollState = {isMouseScrolled()}
            if scrollbar_isHorizontal then
                if not imports.isKeyOnHold("lshift") then
                    currentScrollState[1] = false
                end
            end
            if currentScrollState[1] then
                local scrollbar_scrollSpeed = (renderData.multiplier/scrollbar_overflownSize)*100
                if scrollbar_isHorizontal then
                    if scrollbar_overflownSize < elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Horizontal"].track.width then
                        scrollbar_scrollSpeed = scrollbar_scrollSpeed*25
                    end
                else
                    if scrollbar_overflownSize < elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"].track.height then
                        scrollbar_scrollSpeed = scrollbar_scrollSpeed*25
                    end
                end
                if currentScrollState[1] == "up" then
                    if referenceData.finalPercent > 0 then
                        referenceData.finalPercent = referenceData.finalPercent - (scrollbar_scrollSpeed*currentScrollState[2])
                    end
                elseif currentScrollState[1] == "down" then
                    if referenceData.finalPercent < 100 then
                        referenceData.finalPercent = referenceData.finalPercent + (scrollbar_scrollSpeed*currentScrollState[2])
                    end
                end
                referenceData.finalPercent = imports.math.max(0, imports.math.min(100, referenceData.finalPercent))
                imports.resetScrollCache()
                imports.triggerEvent("onClientUIScroll", elementParent, (scrollbar_isHorizontal and ((currentScrollState[1] == "up" and "left") or "right")) or currentScrollState[1])
            end
        end
    end
    return true

end