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
    local gridlist_rowBar_color, gridlist_rowBar_fontColor = tocolor(unpack(elementReference.gui.rowBar.color)), tocolor(unpack(elementReference.gui.rowBar.fontColor))
    local gridlist_columnBar_padding, gridlist_columnBar_height = availableElements["beautify_gridlist"].__columnBar.padding, availableElements["beautify_gridlist"].__columnBar.height
    local gridlist_rowBar_padding, gridlist_rowBar_height = availableElements["beautify_gridlist"].__rowBar.padding, availableElements["beautify_gridlist"].__rowBar.height
    local gridlist_columnBar_divider_size, gridlist_columnBar_divider_color = elementReference.gui.columnBar.divider.size, tocolor(unpack(elementReference.gui.columnBar.divider.color))
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
    dxDrawRectangle(false, gridlist_startX, gridlist_startY, gridlist_width, gridlist_height, gridlist_color, gridlist_postGUI, true)
    if gridlist_renderTarget and isElement(gridlist_renderTarget) then
        dxSetRenderTarget(gridlist_renderTarget, true)
        dxSetBlendMode("modulate_add")
        for i, j in ipairs(elementReference.gridData.rows) do
            if not j.animAlphaPercent then
                j.animAlphaPercent = 0
                j.hoverStatus = "backward"
                j.hoverAnimTickCounter = getTickCount()
            end
            local row_offsetX, row_offsetY = 0, (gridlist_rowBar_height + gridlist_rowBar_padding)*(i - 1) + gridlist_rowBar_padding
            local isRowHovered = false
            if not elementParent then
                isRowHovered = isMouseOnPosition(gridlist_startX, gridlist_startY, gridlist_width, gridlist_height) and isMouseOnPosition(gridlist_renderTarget_startX, gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height) and isMouseOnPosition(gridlist_renderTarget_startX + row_offsetX, gridlist_renderTarget_startY + row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height)
            else
                local isParentContentHovered = isMouseOnPosition(createdElements[elementParent].gui.x, createdElements[elementParent].gui.y, createdElements[elementParent].gui.width, createdElements[elementParent].gui.height) and isMouseOnPosition(createdElements[elementParent].gui.x + elementReference.gui.contentSection.startX, createdElements[elementParent].gui.y + elementReference.gui.contentSection.startY, elementReference.gui.contentSection.width, elementReference.gui.contentSection.height)
                if isParentContentHovered then
                    isRowHovered = isMouseOnPosition(createdElements[elementParent].gui.x + gridlist_startX, createdElements[elementParent].gui.y + gridlist_startY, gridlist_width, gridlist_height) and isMouseOnPosition(createdElements[elementParent].gui.x + gridlist_renderTarget_startX, createdElements[elementParent].gui.y + gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height) and isMouseOnPosition(createdElements[elementParent].gui.x + gridlist_renderTarget_startX + row_offsetX, createdElements[elementParent].gui.y + gridlist_renderTarget_startY + row_offsetY + gridlist_columnBar_height + gridlist_columnBar_padding, gridlist_renderTarget_width, gridlist_rowBar_height)
                end
            end
            if isRowHovered or elementReference.gridData.selectedRow == i then
                if isLMBClicked and elementReference.gridData.selectedRow ~= i then
                    Timer(function(element, selectedRow)
                        --TODO: UPDATE
                        --elementReference.gridData.selectedRow = i
                    end, 1, 1, element, selectedRow)
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
                j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, availableElements["beautify_gridlist"].__rowBar.hoverAnimDuration), "Linear")
            else
                j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, availableElements["beautify_gridlist"].__rowBar.hoverAnimDuration), "Linear")
            end
            dxDrawRectangle(false, row_offsetX, row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height, gridlist_rowBar_color, false, true)
            dxDrawRectangle(true, row_offsetX, row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height, tocolor(elementReference.gui.rowBar.hoverColor[1], elementReference.gui.rowBar.hoverColor[2], elementReference.gui.rowBar.hoverColor[3], elementReference.gui.rowBar.hoverColor[4]*j.animAlphaPercent), false, true)
            for k, v in ipairs(elementReference.gridData.columns) do
                dxDrawText(true, j[v.name] or "-", row_offsetX + column_offsets[k].startX + gridlist_columnBar_padding, row_offsetY, row_offsetX + column_offsets[k].endX - gridlist_columnBar_padding, row_offsetY + gridlist_rowBar_height, gridlist_rowBar_fontColor, 1, elementReference.gui.rowBar.font, "center", "center", true, false, false, false, true)
                dxDrawText(false, j[v.name] or "-", row_offsetX + column_offsets[k].startX + gridlist_columnBar_padding, row_offsetY, row_offsetX + column_offsets[k].endX - gridlist_columnBar_padding, row_offsetY + gridlist_rowBar_height, tocolor(elementReference.gui.rowBar.hoverFontColor[1], elementReference.gui.rowBar.hoverFontColor[2], elementReference.gui.rowBar.hoverFontColor[3], elementReference.gui.rowBar.hoverFontColor[4]*j.animAlphaPercent), 1, elementReference.gui.rowBar.font, "center", "center", true, false, false, false, true)
            end
        end
        dxSetBlendMode("blend")
        if not elementParent then
            dxSetRenderTarget()
        else
            dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
        end
        dxDrawImage(false, gridlist_renderTarget_startX, gridlist_renderTarget_startY, gridlist_renderTarget_width, gridlist_renderTarget_height, gridlist_renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255), gridlist_postGUI)
    end
    dxDrawRectangle(true, gridlist_startX, gridlist_startY, gridlist_width, gridlist_columnBar_height, gridlist_columnBar_color, gridlist_postGUI, true)
    for i, j in ipairs(elementReference.gridData.columns) do
        if i ~= #elementReference.gridData.columns then
            dxDrawRectangle(false, gridlist_startX + column_offsets[i].startX + j.width + gridlist_columnBar_divider_size, gridlist_startY + gridlist_columnBar_height + gridlist_columnBar_padding, gridlist_columnBar_divider_size, gridlist_height - gridlist_columnBar_height - (gridlist_columnBar_padding*2), gridlist_columnBar_divider_color, gridlist_postGUI, true)
        end
        dxDrawText(false, j.name, gridlist_startX + column_offsets[i].startX + gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_padding, gridlist_startX + column_offsets[i].endX - gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_height, gridlist_columnBar_fontColor, 1, elementReference.gui.columnBar.font, "center", "center", true, false, gridlist_postGUI, false, true)
    end
    return true

end