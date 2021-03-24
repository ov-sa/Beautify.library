----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Grid List's Renderer ]]--
----------------------------------------------------------------


-------------------------------------
--[[ Function: Renders Grid List ]]--
-------------------------------------

function renderGridlist(element)

    if not isUIValid(element) or element:getType() ~= "beautify_gridlist" then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    local gridlist_startX, gridlist_startY = elementReference.gui.x, elementReference.gui.y
    local gridlist_width, gridlist_height = elementReference.gui.width, elementReference.gui.height
    local gridlist_color, gridlist_columnBar_color, gridlist_columnBar_fontColor = tocolor(unpack(elementReference.gui.color)), tocolor(unpack(elementReference.gui.columnBar.color)), tocolor(unpack(elementReference.gui.columnBar.fontColor))
    local gridlist_columnBar_padding, gridlist_columnBar_height = availableElements["beautify_gridlist"].__columnBar.padding, availableElements["beautify_gridlist"].__columnBar.height
    local gridlist_columnBar_divider_size, gridlist_columnBar_divider_color = elementReference.gui.columnBar.divider.size, tocolor(unpack(elementReference.gui.columnBar.divider.color))
    local gridlist_renderTarget_startX, gridlist_renderTarget_startY = gridlist_startX + elementReference.gui.contentSection.startX, gridlist_startY + elementReference.gui.contentSection.startY
    local gridlist_renderTarget_width, gridlist_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
    local gridlist_renderTarget = elementReference.gui.renderTarget
    local gridlist_postGUI = elementReference.gui.postGUI

    if not elementParent then dxSetRenderTarget() end
    local column_offsets = {}
    dxDrawRectangle(gridlist_startX, gridlist_startY, gridlist_width, gridlist_height, gridlist_color, gridlist_postGUI, true)
    dxDrawRectangle(gridlist_startX, gridlist_startY, gridlist_width, gridlist_columnBar_height, gridlist_columnBar_color, gridlist_postGUI, true)
    for i, j in ipairs(elementReference.gridData.columns) do
        local _column_offsetX = (tonumber(column_offsets[i - 1] and column_offsets[i - 1].endX) or 0) + gridlist_columnBar_divider_size
        column_offsets[i] = {
            startX = _column_offsetX,
            endX = _column_offsetX + j.width + gridlist_columnBar_divider_size
        }
        if i ~= #elementReference.gridData.columns then
            dxDrawRectangle(gridlist_startX + _column_offsetX + j.width + gridlist_columnBar_divider_size, gridlist_startY + gridlist_columnBar_height + gridlist_columnBar_padding, gridlist_columnBar_divider_size, gridlist_height - gridlist_columnBar_height - (gridlist_columnBar_padding*2), gridlist_columnBar_divider_color, gridlist_postGUI, true)
        end
        dxDrawText(j.name, gridlist_startX + column_offsets[i].startX + gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_padding, gridlist_startX + column_offsets[i].endX - gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_height, gridlist_columnBar_fontColor, 1, elementReference.gui.columnBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
    end
    --TODO: DRAW GRIDLIST's ROWS into its RT :)
    if gridlist_renderTarget and isElement(gridlist_renderTarget) then
        --dxSetRenderTarget(gridlist_renderTarget, true)
        dxDrawRectangle(0, 0, 1366, 768, tocolor(255, 0, 0, 255), false, true)
        dxSetBlendMode("modulate_add")
        --TODO: ADD ELEMENTS HERE FOR Gridlist
        for i, j in ipairs(elementReference.gridData.rows) do
            if not j.animAlphaPercent then
                j.animAlphaPercent = 0
                j.hoverStatus = "backward"
                j.hoverAnimTickCounter = getTickCount()
            end
            local row_offsetX, row_offsetY = 0, 0
            --[[
            local isRowHovered = isAnimationDone and isMouseWithinRangeOf(panel_offsetX + cache.generalUI.wrapper.contentRenderer.startX + cache.generalUI.wrapper.tabPane.startX, panel_offsetY + cache.generalUI.wrapper.contentRenderer.startY + cache.generalUI.wrapper.tabPane.startY + cache.generalUI.wrapper.tabPane.tabs[selectedTab].columns.title.height, cache.generalUI.wrapper.tabPane.tabs[selectedTab].width, cache.generalUI.wrapper.tabPane.tabs[selectedTab].height, true) and isMouseWithinRangeOf(panel_offsetX + cache.generalUI.wrapper.contentRenderer.startX + cache.generalUI.wrapper.tabPane.startX, panel_offsetY + cache.generalUI.wrapper.contentRenderer.startY + cache.generalUI.wrapper.tabPane.startY + cache.generalUI.wrapper.tabPane.tabs[selectedTab].columns.title.height + column_offsetY, cache.generalUI.wrapper.tabPane.tabs[selectedTab].width, cache.generalUI.wrapper.tabPane.tabs[selectedTab].columns.data.height, true)
            if isRowHovered or cache.generalUI.wrapper.tabPane.tabs[selectedTab].selectedRow == i then
                if isMouseBtnClicked and cache.generalUI.wrapper.tabPane.tabs[selectedTab].selectedRow ~= i then
                    cache.generalUI.wrapper.tabPane.tabs[selectedTab].selectedRow = i
                    if cache.generalUI.wrapper.tabPane.tabs[selectedTab].tabType == "ranks" then
                        resetClanRankModification()
                        cache.generalUI.wrapper.tabPane.tabs[selectedTab].rankRights.editbox[1].text = gridData[(cache.generalUI.wrapper.tabPane.tabs[selectedTab].selectedRow)].name
                    end
                end
                if j.hoverStatus ~= "forward" then
                    j.hoverStatus = "forward"
                    j.hoverAnimTickCounter = getTickCount()
                end
                if isRowHovered then
                    prevRowHoverState = i
                end
            else
                if j.hoverStatus ~= "backward" then
                    j.hoverStatus = "backward"
                    j.hoverAnimTickCounter = getTickCount()
                end
            end
            if j.hoverStatus == "forward" then
                j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, cache.generalUI.wrapper.tabPane.tabs[selectedTab].columns.data.hoverAnimDuration), "Linear")
            else
                j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, cache.generalUI.wrapper.tabPane.tabs[selectedTab].columns.data.hoverAnimDuration), "Linear")
            end
            ]]--
        end
        dxSetBlendMode("blend")
        --dxSetRenderTarget()
        dxDrawImage(gridlist_renderTarget_startX, gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height, gridlist_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), gridlist_postGUI)
    end
    --[[
    if gridlist_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(gridlist_startX, gridlist_startY + gridlist_columnBar_height, window_borderSize, gridlist_height - window_borderSize - gridlist_columnBar_height, gridlist_color, gridlist_postGUI, true)
        dxDrawRectangle(gridlist_startX + gridlist_width - window_borderSize, gridlist_startY + gridlist_columnBar_height, window_borderSize, gridlist_height - window_borderSize - gridlist_columnBar_height, gridlist_color, gridlist_postGUI, true)
    end
    if gridlist_width > availableElements["beautify_window"].__minimumSize and gridlist_height > availableElements["beautify_window"].__minimumSize then
        dxDrawRectangle(gridlist_startX + window_borderSize, gridlist_startY + window_borderSize, gridlist_width - availableElements["beautify_window"].__minimumSize, gridlist_height - availableElements["beautify_window"].__minimumSize, gridlist_color, gridlist_postGUI, true)
    end
    if (gridlist_width >= gridlist_columnBar_height) and (gridlist_height >= gridlist_columnBar_height) then
        local isCloseButtonHovered = false
        local window_close_button_startX, window_close_button_startY = gridlist_startX + gridlist_width - gridlist_columnBar_height, gridlist_startY
        local isTitleBarClicked = isMouseOnPosition(gridlist_startX, gridlist_startY, gridlist_width - gridlist_columnBar_height, gridlist_columnBar_height) and isLMBClicked
        if isTitleBarClicked then
            Timer(function(element)
                attachElement(element)
            end, 1, 1, element)
        else
            if not getAttachedElement() then
                isCloseButtonHovered = isMouseOnPosition(window_close_button_startX, window_close_button_startY, gridlist_columnBar_height, gridlist_columnBar_height)
            end
        end
        if isCloseButtonHovered then
            if isLMBClicked then
                Timer(function(element)
                    setUIVisible(element, false)
                end, 1, 1, element)
            end
            if elementReference.gui.columnBar.close_button.hoverStatus ~= "forward" then
                elementReference.gui.columnBar.close_button.hoverStatus = "forward"
                elementReference.gui.columnBar.close_button.hoverAnimTickCounter = getTickCount()
            end
        else
            if elementReference.gui.columnBar.close_button.hoverStatus ~= "backward" then
                elementReference.gui.columnBar.close_button.hoverStatus = "backward"
                elementReference.gui.columnBar.close_button.hoverAnimTickCounter = getTickCount()
            end
        end
        if not elementReference.gui.columnBar.close_button.animAlphaPercent then elementReference.gui.columnBar.close_button.animAlphaPercent = 0 end
        if elementReference.gui.columnBar.close_button.hoverStatus == "forward" then
            elementReference.gui.columnBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.columnBar.close_button.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(elementReference.gui.columnBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].__columnBar.close_button.hoverAnimDuration), "InQuad")
        else
            elementReference.gui.columnBar.close_button.animAlphaPercent = interpolateBetween(elementReference.gui.columnBar.close_button.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(elementReference.gui.columnBar.close_button.hoverAnimTickCounter, availableElements["beautify_window"].__columnBar.close_button.hoverAnimDuration), "InQuad")
        end
        dxDrawImage(gridlist_startX, gridlist_startY, gridlist_columnBar_height, gridlist_columnBar_height, createdAssets["images"]["curved_square/top_left.png"], 0, 0, 0, gridlist_columnBar_color, gridlist_postGUI)
        dxDrawRectangle(gridlist_startX + gridlist_columnBar_height, gridlist_startY, gridlist_width - (gridlist_columnBar_height*2), gridlist_columnBar_height, gridlist_columnBar_color, gridlist_postGUI, true)
        dxDrawImage(window_close_button_startX, window_close_button_startY, gridlist_columnBar_height, gridlist_columnBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, gridlist_columnBar_color, gridlist_postGUI)
        dxDrawImage(window_close_button_startX, window_close_button_startY, gridlist_columnBar_height, gridlist_columnBar_height, createdAssets["images"]["curved_square/top_right.png"], 0, 0, 0, tocolor(elementReference.gui.columnBar.close_button.hoverColor[1], elementReference.gui.columnBar.close_button.hoverColor[2], elementReference.gui.columnBar.close_button.hoverColor[3], elementReference.gui.columnBar.close_button.hoverColor[4]*elementReference.gui.columnBar.close_button.animAlphaPercent), gridlist_postGUI)
        dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + gridlist_columnBar_height, gridlist_startY + gridlist_columnBar_height, tocolor(unpack(elementReference.gui.columnBar.close_button.fontColor)), 1, elementReference.gui.columnBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
        dxDrawText("X", window_close_button_startX, window_close_button_startY, window_close_button_startX + gridlist_columnBar_height, gridlist_startY + gridlist_columnBar_height, tocolor(elementReference.gui.columnBar.close_button.hoverFontColor[1], elementReference.gui.columnBar.close_button.hoverFontColor[2], elementReference.gui.columnBar.close_button.hoverFontColor[3], elementReference.gui.columnBar.close_button.hoverFontColor[4]*elementReference.gui.columnBar.close_button.animAlphaPercent), 1, elementReference.gui.columnBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
        dxDrawText(elementReference.gui.title, gridlist_startX + gridlist_columnBar_padding, gridlist_startY, gridlist_startX + gridlist_width - gridlist_columnBar_height - gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_height, tocolor(unpack(elementReference.gui.columnBar.fontColor)), 1, elementReference.gui.columnBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
    	dxDrawLine(window_close_button_startX, window_close_button_startY, window_close_button_startX, window_close_button_startY + gridlist_columnBar_height, window_titleBar_divider_color, window_titleBar_divider_size, gridlist_postGUI)
        dxDrawLine(gridlist_startX, gridlist_startY + gridlist_columnBar_height, gridlist_startX + gridlist_width, gridlist_startY + gridlist_columnBar_height, window_titleBar_divider_color, window_titleBar_divider_size, gridlist_postGUI)
        --TODO: ADD NIGHT/DAY MODE TOGGLER..
    end
    ]]--
    return true

end