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

    if not isUIValid(element) then return false end
    local elementType = element:getType()
    if elementType ~= "beautify_gridlist" then return false end

    local elementTemplate = getUITemplate(elementType)
    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    local gridlist_startX, gridlist_startY = elementReference.gui.x, elementReference.gui.y
    local gridlist_width, gridlist_height = elementReference.gui.width, elementReference.gui.height
    local gridlist_color, gridlist_columnBar_color, gridlist_columnBar_fontColor = tocolor(unpack(elementTemplate.color)), tocolor(unpack(elementTemplate.columnBar.color)), tocolor(unpack(elementTemplate.columnBar.fontColor))
    local gridlist_rowBar_color, gridlist_rowBar_fontColor = tocolor(unpack(elementTemplate.rowBar.color)), tocolor(unpack(elementTemplate.rowBar.fontColor))
    local gridlist_columnBar_padding, gridlist_columnBar_height = availableElements[elementType].columnBar.padding, availableElements[elementType].columnBar.height
    local gridlist_rowBar_padding, gridlist_rowBar_height = availableElements[elementType].rowBar.padding, availableElements[elementType].rowBar.height
    local gridlist_columnBar_divider_size, gridlist_columnBar_divider_color = elementTemplate.columnBar.divider.size, tocolor(unpack(elementTemplate.columnBar.divider.color))
    local gridlist_renderTarget_startX, gridlist_renderTarget_startY = gridlist_startX + elementReference.gui.contentSection.startX, gridlist_startY + elementReference.gui.contentSection.startY
    local gridlist_renderTarget_width, gridlist_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
    local gridlist_renderTarget = elementReference.gui.renderTarget
    local gridlist_postGUI = elementReference.gui.postGUI

    if not elementParent then dxSetRenderTarget() end
    local column_offsets = {}
    for i, j in ipairs(elementReference.gridData.columns) do
        local _column_offsetX = (tonumber(column_offsets[i - 1] and column_offsets[i - 1].endX) or 0) + gridlist_columnBar_divider_size
        column_offsets[i] = {
            startX = _column_offsetX,
            endX = _column_offsetX + j.width + gridlist_columnBar_divider_size
        }
    end
    dxDrawRectangle(gridlist_startX, gridlist_startY, gridlist_width, gridlist_height, gridlist_color, gridlist_postGUI)
    if gridlist_renderTarget and isElement(gridlist_renderTarget) then
        dxSetRenderTarget(gridlist_renderTarget, true)
        dxSetBlendMode("modulate_add")
        local gridlist_scrolledY_offset = 0
        local gridlist_data_height = (gridlist_rowBar_height + gridlist_rowBar_padding)*(#elementReference.gridData.rows) + gridlist_rowBar_padding
        local gridlist_exceeded_height = gridlist_data_height - gridlist_renderTarget_height
        if not elementReference.gui.scrollBar.percent then elementReference.gui.scrollBar.percent = 0 end
        if gridlist_exceeded_height > 0 then gridlist_scrolledY_offset = gridlist_exceeded_height*elementReference.gui.scrollBar.percent*0.01 end      
        for i, j in ipairs(elementReference.gridData.rows) do
            if not j.animAlphaPercent then
                j.animAlphaPercent = 0
                j.hoverStatus = "backward"
                j.hoverAnimTickCounter = getTickCount()
            end
            local row_offsetX, row_offsetY = 0, (gridlist_rowBar_height + gridlist_rowBar_padding)*(i - 1) + gridlist_rowBar_padding - gridlist_scrolledY_offset
            local isRowHovered = false
            if not elementParent then
                isRowHovered = isMouseOnPosition(gridlist_startX, gridlist_startY, gridlist_width, gridlist_height) and isMouseOnPosition(gridlist_renderTarget_startX, gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height) and isMouseOnPosition(gridlist_renderTarget_startX + row_offsetX, gridlist_renderTarget_startY + row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height)
            else
                local isParentContentHovered = isMouseOnPosition(createdElements[elementParent].gui.x, createdElements[elementParent].gui.y, createdElements[elementParent].gui.width, createdElements[elementParent].gui.height) and isMouseOnPosition(createdElements[elementParent].gui.x + createdElements[elementParent].gui.contentSection.startX, createdElements[elementParent].gui.y + createdElements[elementParent].gui.contentSection.startY, elementReference.gui.contentSection.width, elementReference.gui.contentSection.height)
                if isParentContentHovered then
                    isRowHovered = isMouseOnPosition(createdElements[elementParent].gui.x + createdElements[elementParent].gui.contentSection.startX + gridlist_startX, createdElements[elementParent].gui.y + createdElements[elementParent].gui.contentSection.startY + gridlist_startY, gridlist_width, gridlist_height) and isMouseOnPosition(createdElements[elementParent].gui.x + createdElements[elementParent].gui.contentSection.startX + gridlist_renderTarget_startX, createdElements[elementParent].gui.y + createdElements[elementParent].gui.contentSection.startY + gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height) and isMouseOnPosition(createdElements[elementParent].gui.x + createdElements[elementParent].gui.contentSection.startX + gridlist_renderTarget_startX + row_offsetX, createdElements[elementParent].gui.y + createdElements[elementParent].gui.contentSection.startY + gridlist_renderTarget_startY + row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height)
                end
            end
            if isRowHovered or (elementReference.gridData.selection == i) then
                if isLMBClicked and (elementReference.gridData.selection ~= i) then
                    Timer(function(gridlist, selection)
                        setGridlistSelection(gridlist, selection)
                    end, 1, 1, element, i)
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
                j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, availableElements[elementType].rowBar.hoverAnimDuration), "Linear")
            else
                j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, availableElements[elementType].rowBar.hoverAnimDuration), "Linear")
            end
            dxDrawRectangle(row_offsetX, row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height, gridlist_rowBar_color, false)
            dxDrawRectangle(row_offsetX, row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height, tocolor(elementTemplate.rowBar.hoverColor[1], elementTemplate.rowBar.hoverColor[2], elementTemplate.rowBar.hoverColor[3], elementTemplate.rowBar.hoverColor[4]*j.animAlphaPercent), false)
            for k, v in ipairs(elementReference.gridData.columns) do
                dxDrawText(j[k] or "-", row_offsetX + column_offsets[k].startX + gridlist_columnBar_padding, row_offsetY, row_offsetX + column_offsets[k].endX - gridlist_columnBar_padding, row_offsetY + gridlist_rowBar_height, gridlist_rowBar_fontColor, 1, elementTemplate.rowBar.font, "center", "center", true, false, false, false)
                dxDrawText(j[k] or "-", row_offsetX + column_offsets[k].startX + gridlist_columnBar_padding, row_offsetY, row_offsetX + column_offsets[k].endX - gridlist_columnBar_padding, row_offsetY + gridlist_rowBar_height, tocolor(elementTemplate.rowBar.hoverFontColor[1], elementTemplate.rowBar.hoverFontColor[2], elementTemplate.rowBar.hoverFontColor[3], elementTemplate.rowBar.hoverFontColor[4]*j.animAlphaPercent), 1, elementTemplate.rowBar.font, "center", "center", true, false, false, false)
            end
            local gridlist_scrollBarY_width, gridlist_scrollBarY_height, gridlist_scrollBarY_bar_height = elementTemplate.scrollBar.overlay.width, gridlist_renderTarget_height, elementTemplate.scrollBar.bar.height
            local gridlist_scrollBarY_startX, gridlist_scrollBarY_startY = gridlist_renderTarget_width - gridlist_scrollBarY_width, 0
            local gridlist_scrollBar_overlay_color, gridlist_scrollBar_bar_color = tocolor(unpack(elementTemplate.scrollBar.overlay.color)), tocolor(unpack(elementTemplate.scrollBar.bar.color))
            dxDrawRectangle(gridlist_scrollBarY_startX, gridlist_scrollBarY_startY, gridlist_scrollBarY_width, gridlist_scrollBarY_height, gridlist_scrollBar_overlay_color, gridlist_postGUI)
            dxDrawRectangle(gridlist_scrollBarY_startX, gridlist_scrollBarY_startY + ((gridlist_scrollBarY_height - gridlist_scrollBarY_bar_height)*(elementReference.gui.scrollBar.percent*0.01)), gridlist_scrollBarY_width, gridlist_scrollBarY_bar_height, gridlist_scrollBar_bar_color, gridlist_postGUI)
            if prevScrollState --[[and (isMouseWithinRangeOf(contentrender_offsetX, contentrender_offsetY, contentrender_width, contentrender_height, true) and (isMouseWithinRangeOf(contentrender_offsetX + optionData.rulesBox.startX + scroller_overlay_startX, contentrender_offsetY + optionData.rulesBox.startY + scroller_overlay_startY, scroller_overlay_width, gridlist_scrollBarY_height, true) or isMouseWithinRangeOf(contentrender_offsetX + optionData.rulesBox.startX + optionData.rulesBox.rtPadding, contentrender_offsetY + optionData.rulesBox.startY + optionData.rulesBox.rtPadding, optionData.rulesBox.width - (optionData.rulesBox.rtPadding*2), optionData.rulesBox.height - (optionData.rulesBox.rtPadding*2), true))) and isViewAnimationDone]] then
                if prevScrollState == "up" then
                    if elementReference.gui.scrollBar.percent > 0 then
                        if gridlist_exceeded_height < gridlist_scrollBarY_height then
                            elementReference.gui.scrollBar.percent = elementReference.gui.scrollBar.percent - (10*prevScrollStreak.streak)
                        else
                            elementReference.gui.scrollBar.percent = elementReference.gui.scrollBar.percent - (1*prevScrollStreak.streak)
                        end
                    end
                elseif prevScrollState == "down" then
                    if elementReference.gui.scrollBar.percent < 100 then
                        if gridlist_exceeded_height < gridlist_scrollBarY_height then
                            elementReference.gui.scrollBar.percent = elementReference.gui.scrollBar.percent + (10*prevScrollStreak.streak)
                        else
                            elementReference.gui.scrollBar.percent = elementReference.gui.scrollBar.percent + (1*prevScrollStreak.streak)
                        end
                    end
                end
                elementReference.gui.scrollBar.percent = math.max(0, math.min(100, elementReference.gui.scrollBar.percent))
                prevScrollState = false
            end
        end
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        dxDrawImage(gridlist_renderTarget_startX, gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height, gridlist_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), gridlist_postGUI)
    end
    dxDrawRectangle(gridlist_startX, gridlist_startY, gridlist_width, gridlist_columnBar_height, gridlist_columnBar_color, gridlist_postGUI)
    dxDrawRectangle(gridlist_startX, gridlist_startY + gridlist_columnBar_height, gridlist_width, gridlist_columnBar_divider_size, gridlist_columnBar_divider_color, gridlist_postGUI)
    for i, j in ipairs(elementReference.gridData.columns) do
        if i ~= #elementReference.gridData.columns then
            dxDrawRectangle(gridlist_startX + column_offsets[i].startX + j.width + gridlist_columnBar_divider_size, gridlist_startY + gridlist_columnBar_height + gridlist_columnBar_padding, gridlist_columnBar_divider_size, gridlist_height - gridlist_columnBar_height - (gridlist_columnBar_padding*2), gridlist_columnBar_divider_color, gridlist_postGUI)
        end
        dxDrawText(j.name, gridlist_startX + column_offsets[i].startX + gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_padding, gridlist_startX + column_offsets[i].endX - gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_height, gridlist_columnBar_fontColor, 1, elementTemplate.columnBar.font, "center", "center", true, false, gridlist_postGUI, false)
    end
    return true

end