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
    isMouseScrolled = isMouseScrolled,
    __getUITemplate = __getUITemplate,
    resetScrollCache = resetScrollCache,
    unpackColor = unpackColor,
    interpolateBetween = interpolateBetween,
    dxDrawRectangle = dxDrawRectangle,
    math = {
        min = math.min,
        max = math.max,
        round = math.round
    }
}


-------------------
--[[ Variables ]]--
-------------------

local componentType = "beautify_scrollbar"


--------------------------------------
--[[ Function: Renders Scroll Bar ]]--
--------------------------------------

function renderScrollbar(elementParent, isComponentInterpolationToBeRefreshed, isComponentToBeReloaded, isComonentToBeUpdated, renderData, referenceData, isFetchingInput)

    local elementReference = renderData.elementReference
    local scrollbar_isHorizontal = referenceData.isHorizontal
    local scrollbar_overflownSize = renderData.overflownSize
    if not isFetchingInput then
        local isComponentRootToBeForceRendered = false
        local isComponentInterpolationToBeRefreshed = isComponentInterpolationToBeRefreshed or CLIENT_MTA_RESTORED
        local isComponentToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (isComponentToBeReloaded or referenceData.reloadComponent or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][componentType]))
        local isComonentToBeUpdated = isComponentToBeReloaded or isComonentToBeUpdated or referenceData.updateComponent or CLIENT_MTA_RESTORED
        local scrollbar_postGUI = renderData.postGUI

        if isComonentToBeUpdated then
            local componentTemplate = imports.__getUITemplate(componentType, elementReference.sourceResource)
            if not referenceData["__UI_CACHE__"] then
                referenceData["__UI_CACHE__"] = {
                    ["Track"] = {
                        offsets = {}
                    },
                    ["Thumb"] = {
                        offsets = {}
                    }
                }
                referenceData["__UI_INPUT_FETCH_CACHE__"] = {
                    ["Track"] = {}
                }
            end
            local scrollbar_startX, scrollbar_startY = renderData.startX, renderData.startY
            if scrollbar_isHorizontal then
                referenceData["__UI_CACHE__"]["Track"].offsets.width = renderData.width
                referenceData["__UI_CACHE__"]["Track"].offsets.height = componentTemplate.size
                referenceData["__UI_CACHE__"]["Track"].offsets.startX = scrollbar_startX
                referenceData["__UI_CACHE__"]["Track"].offsets.startY = scrollbar_startY - referenceData["__UI_CACHE__"]["Track"].offsets.height
                referenceData["__UI_CACHE__"]["Thumb"].offsets.width = imports.math.max(imports.math.min(referenceData["__UI_CACHE__"]["Track"].offsets.width*0.5, componentTemplate.thumb.minSize), (referenceData["__UI_CACHE__"]["Track"].offsets.width/(referenceData["__UI_CACHE__"]["Track"].offsets.width + scrollbar_overflownSize))*referenceData["__UI_CACHE__"]["Track"].offsets.width)
                referenceData["__UI_CACHE__"]["Thumb"].offsets.height = referenceData["__UI_CACHE__"]["Track"].offsets.height                
                referenceData["__UI_CACHE__"]["Thumb"].offsets.startX = 0
                referenceData["__UI_CACHE__"]["Thumb"].offsets.startY = referenceData["__UI_CACHE__"]["Track"].offsets.startY
                referenceData["__UI_INPUT_FETCH_CACHE__"]["Track"].width = referenceData["__UI_CACHE__"]["Track"].offsets.width
                referenceData.finalThumbSize = referenceData["__UI_CACHE__"]["Thumb"].offsets.width
            else
                referenceData["__UI_CACHE__"]["Track"].offsets.width = componentTemplate.size
                referenceData["__UI_CACHE__"]["Track"].offsets.height = renderData.height
                referenceData["__UI_CACHE__"]["Track"].offsets.startX = scrollbar_startX - referenceData["__UI_CACHE__"]["Track"].offsets.width
                referenceData["__UI_CACHE__"]["Track"].offsets.startY = scrollbar_startY
                referenceData["__UI_CACHE__"]["Thumb"].offsets.width = referenceData["__UI_CACHE__"]["Track"].offsets.width
                referenceData["__UI_CACHE__"]["Thumb"].offsets.height = imports.math.max(imports.math.min(referenceData["__UI_CACHE__"]["Track"].offsets.height*0.5, componentTemplate.thumb.minSize), (referenceData["__UI_CACHE__"]["Track"].offsets.height/(referenceData["__UI_CACHE__"]["Track"].offsets.height + scrollbar_overflownSize))*referenceData["__UI_CACHE__"]["Track"].offsets.height)
                referenceData["__UI_CACHE__"]["Thumb"].offsets.startX = referenceData["__UI_CACHE__"]["Track"].offsets.startX
                referenceData["__UI_CACHE__"]["Thumb"].offsets.startY = 0
                referenceData["__UI_INPUT_FETCH_CACHE__"]["Track"].height = referenceData["__UI_CACHE__"]["Track"].offsets.height
                referenceData.finalThumbSize = referenceData["__UI_CACHE__"]["Thumb"].offsets.height
            end
            referenceData["__UI_CACHE__"]["Thumb"].shadowSize = componentTemplate.thumb.shadowSize
            if isComponentToBeReloaded then
                referenceData["__UI_CACHE__"]["Track"].color = imports.tocolor(imports.unpackColor(componentTemplate.track.color))
                referenceData["__UI_CACHE__"]["Thumb"].color = imports.tocolor(imports.unpackColor(componentTemplate.thumb.color))
                referenceData["__UI_CACHE__"]["Thumb"].shadowColor = imports.tocolor(imports.unpackColor(componentTemplate.thumb.shadowColor))
            end
            if not CLIENT_MTA_MINIMIZED then
                referenceData.reloadComponent = nil
            end
            referenceData.updateComponent = nil
        end

        local isScrollThumbInterpolationRendering = imports.math.round(referenceData.currentThumbSize, 0) ~= imports.math.round(referenceData.finalThumbSize, 0)
        if isComponentInterpolationToBeRefreshed or isScrollThumbInterpolationRendering then
            isComponentRootToBeForceRendered = isScrollThumbInterpolationRendering
            referenceData.currentThumbSize = imports.interpolateBetween(referenceData.currentThumbSize, 0, 0, referenceData.finalThumbSize, 0, 0, 0.25, "InQuad")
        end
        local isScrollInterpolationDone = imports.math.round(referenceData.currentPercent, 2) == imports.math.round(referenceData.finalPercent, 2)
        if isComponentInterpolationToBeRefreshed or (not isScrollInterpolationDone) then
            isComponentRootToBeForceRendered = isComponentRootToBeForceRendered or not isScrollInterpolationDone
            referenceData.currentPercent = imports.interpolateBetween(referenceData.currentPercent, 0, 0, referenceData.finalPercent, 0, 0, 0.25, "InQuad")
            if scrollbar_isHorizontal then
                referenceData["__UI_CACHE__"]["Thumb"].offsets.startX = imports.math.max(referenceData["__UI_CACHE__"]["Track"].offsets.startX, referenceData["__UI_CACHE__"]["Track"].offsets.startX + (referenceData["__UI_CACHE__"]["Track"].offsets.width - referenceData["__UI_CACHE__"]["Thumb"].offsets.width)*(referenceData.currentPercent*0.01))
            else
                referenceData["__UI_CACHE__"]["Thumb"].offsets.startY = imports.math.max(referenceData["__UI_CACHE__"]["Track"].offsets.startY, referenceData["__UI_CACHE__"]["Track"].offsets.startY + (referenceData["__UI_CACHE__"]["Track"].offsets.height - referenceData["__UI_CACHE__"]["Thumb"].offsets.height)*(referenceData.currentPercent*0.01))
            end
        end
        local scrollbar_thumb_size = referenceData.currentThumbSize
        imports.dxDrawRectangle(referenceData["__UI_CACHE__"]["Track"].offsets.startX, referenceData["__UI_CACHE__"]["Track"].offsets.startY, referenceData["__UI_CACHE__"]["Track"].offsets.width, referenceData["__UI_CACHE__"]["Track"].offsets.height, referenceData["__UI_CACHE__"]["Track"].color, scrollbar_postGUI)
        if scrollbar_isHorizontal then
            imports.dxDrawRectangle(referenceData["__UI_CACHE__"]["Thumb"].offsets.startX, referenceData["__UI_CACHE__"]["Thumb"].offsets.startY, scrollbar_thumb_size, referenceData["__UI_CACHE__"]["Track"].offsets.height, referenceData["__UI_CACHE__"]["Thumb"].color, scrollbar_postGUI)
            imports.dxDrawRectangle(referenceData["__UI_CACHE__"]["Thumb"].offsets.startX, referenceData["__UI_CACHE__"]["Thumb"].offsets.startY, scrollbar_thumb_size, referenceData["__UI_CACHE__"]["Thumb"].shadowSize, referenceData["__UI_CACHE__"]["Thumb"].shadowColor, scrollbar_postGUI)
        else
            imports.dxDrawRectangle(referenceData["__UI_CACHE__"]["Thumb"].offsets.startX, referenceData["__UI_CACHE__"]["Thumb"].offsets.startY, referenceData["__UI_CACHE__"]["Track"].offsets.width, referenceData.currentThumbSize, referenceData["__UI_CACHE__"]["Thumb"].color, scrollbar_postGUI)
            imports.dxDrawRectangle(referenceData["__UI_CACHE__"]["Thumb"].offsets.startX, referenceData["__UI_CACHE__"]["Thumb"].offsets.startY, referenceData["__UI_CACHE__"]["Thumb"].shadowSize, scrollbar_thumb_size, referenceData["__UI_CACHE__"]["Thumb"].shadowColor, scrollbar_postGUI)
        end
        return true, isComponentRootToBeForceRendered
    else
        if not renderData.isDisabled then
            local scroll_state, scroll_streak = imports.isMouseScrolled()
            if scrollbar_isHorizontal then
                if not imports.isKeyOnHold("lshift") then
                    scroll_state = false
                end
            end
            if scroll_state then
                local scrollbar_scrollSpeed = (renderData.multiplier/scrollbar_overflownSize)*100
                if scrollbar_isHorizontal then
                    if scrollbar_overflownSize < referenceData["__UI_INPUT_FETCH_CACHE__"]["Track"].width then
                        scrollbar_scrollSpeed = scrollbar_scrollSpeed*25
                    end
                else
                    if scrollbar_overflownSize < referenceData["__UI_INPUT_FETCH_CACHE__"]["Track"].height then
                        scrollbar_scrollSpeed = scrollbar_scrollSpeed*25
                    end
                end
                if scroll_state == "up" then
                    if referenceData.finalPercent > 0 then
                        referenceData.finalPercent = referenceData.finalPercent - (scrollbar_scrollSpeed*scroll_streak)
                    end
                elseif scroll_state == "down" then
                    if referenceData.finalPercent < 100 then
                        referenceData.finalPercent = referenceData.finalPercent + (scrollbar_scrollSpeed*scroll_streak)
                    end
                end
                referenceData.finalPercent = imports.math.max(0, imports.math.min(100, referenceData.finalPercent))
                imports.resetScrollCache()
                imports.triggerEvent("onClientUIScroll", elementParent, (scrollbar_isHorizontal and ((scroll_state == "up" and "left") or "right")) or scroll_state)
            end
        end
    end
    return true

end