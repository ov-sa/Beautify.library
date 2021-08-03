----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Grid List's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_gridlist"


-------------------------------------
--[[ Function: Renders Grid List ]]--
-------------------------------------

function renderGridlist(element, isFetchingInput, mouseReference)

    if not isFetchingInput then
        if not isUIValid(element) or (element:getType() ~= elementType) then return false end
    else
        if not mouseReference then return false end
    end

    local elementParent = getUIParent(element)
    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementTemplate = getUITemplate(elementType)
        local gridlist_startX, gridlist_startY = elementReference.gui.x, elementReference.gui.y
        local gridlist_width, gridlist_height = elementReference.gui.width, elementReference.gui.height
        local gridlist_color, gridlist_columnBar_color, gridlist_columnBar_fontColor = tocolor(unpackColor(elementTemplate.color)), tocolor(unpackColor(elementTemplate.columnBar.color)), tocolor(unpackColor(elementTemplate.columnBar.fontColor))
        local gridlist_rowBar_color, gridlist_rowBar_fontColor = tocolor(unpackColor(elementTemplate.rowBar.color)), tocolor(unpackColor(elementTemplate.rowBar.fontColor))
        local gridlist_columnBar_padding, gridlist_columnBar_height = availableElements[elementType].columnBar.padding, availableElements[elementType].columnBar.height
        local gridlist_rowBar_padding, gridlist_rowBar_height = availableElements[elementType].rowBar.padding, availableElements[elementType].rowBar.height
        local gridlist_columnBar_divider_size, gridlist_columnBar_divider_color = elementTemplate.columnBar.divider.size, tocolor(unpackColor(elementTemplate.columnBar.divider.color))
        local gridlist_renderTarget_startX, gridlist_renderTarget_startY = gridlist_startX + elementReference.gui.contentSection.startX, gridlist_startY + elementReference.gui.contentSection.startY
        local gridlist_renderTarget_width, gridlist_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
        local gridlist_renderTarget = elementReference.gui.renderTarget
        local gridlist_postGUI = elementReference.gui.postGUI

        if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Content Section"] then
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Content Section"] = {}
        end
        if not elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"] then
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"] = {}
        end
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Content Section"].width = gridlist_renderTarget_width
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"].height = gridlist_rowBar_height
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Rows"] = {}
        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"] = {}

        if not elementParent then dxSetRenderTarget() end
        if elementReference.gui["__UI_CACHE__"]["Column"].areColumnsModified then
            elementReference.gui["__UI_CACHE__"]["Column"].offsets = {}
            for i, j in ipairs(elementReference.gridData.columns) do
                local gridlist_column_offsetX = ((elementReference.gui["__UI_CACHE__"]["Column"].offsets[i - 1] and elementReference.gui["__UI_CACHE__"]["Column"].offsets[i - 1].endX) or 0) + gridlist_columnBar_divider_size
                elementReference.gui["__UI_CACHE__"]["Column"].offsets[i] = {
                    startX = gridlist_column_offsetX,
                    endX = gridlist_column_offsetX + j.width + gridlist_columnBar_divider_size
                }
            end
            elementReference.gui["__UI_CACHE__"]["Column"].areColumnsModified = false
        end
        dxDrawRectangle(gridlist_startX, gridlist_startY, gridlist_width, gridlist_height, gridlist_color, gridlist_postGUI)

        if gridlist_renderTarget and isElement(gridlist_renderTarget) then
            dxSetRenderTarget(gridlist_renderTarget, true)
            dxSetBlendMode("modulate_add")
            if #elementReference.gridData.rows > 0 then
                local gridlist_scrolled_offsetY = 0
                local gridlist_row_occupiedSpace = gridlist_rowBar_height + gridlist_rowBar_padding
                local gridlist_row_maxRenderered = math.ceil(gridlist_renderTarget_height/gridlist_row_occupiedSpace)
                local gridlist_data_height = (gridlist_row_occupiedSpace)*(#elementReference.gridData.rows) + gridlist_rowBar_padding
                local gridlist_exceeded_height = gridlist_data_height - gridlist_renderTarget_height
                if gridlist_exceeded_height > 0 then gridlist_scrolled_offsetY = gridlist_exceeded_height*elementReference.gui.scrollBar_Vertical.currentPercent*0.01 end      
                local gridlist_row_startIndex = math.floor(gridlist_scrolled_offsetY/gridlist_row_occupiedSpace) + 1
                local gridlist_row_endIndex = math.min(#elementReference.gridData.rows, gridlist_row_startIndex + gridlist_row_maxRenderered)
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"]["Start Index"] = gridlist_row_startIndex
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"]["End Index"] = gridlist_row_endIndex
                for i = gridlist_row_startIndex, gridlist_row_endIndex, 1 do
                    local j = elementReference.gridData.rows[i]
                    local row_offsetX, row_offsetY = 0, gridlist_row_occupiedSpace*(i - 1) + gridlist_rowBar_padding - gridlist_scrolled_offsetY
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Rows"][i] = {}
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Rows"][i].startX = gridlist_renderTarget_startX + row_offsetX
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Rows"][i].startY = gridlist_renderTarget_startY + row_offsetY
                    if not j.animAlphaPercent then
                        j.animAlphaPercent = 0
                        j.hoverStatus = "backward"
                        j.hoverAnimTickCounter = getTickCount()
                    end
                    if j.hoverStatus == "forward" then
                        j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 1, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, availableElements[elementType].rowBar.hoverAnimDuration), "OutBounce")
                    else
                        j.animAlphaPercent = interpolateBetween(j.animAlphaPercent, 0, 0, 0, 0, 0, getInterpolationProgress(j.hoverAnimTickCounter, availableElements[elementType].rowBar.hoverAnimDuration), "OutBounce")
                    end
                    dxDrawRectangle(row_offsetX, row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height, gridlist_rowBar_color, false)
                    if j.animAlphaPercent > 0  then
                        dxDrawRectangle(row_offsetX, row_offsetY, gridlist_renderTarget_width, gridlist_rowBar_height, tocolor(elementTemplate.rowBar.hoverColor[1], elementTemplate.rowBar.hoverColor[2], elementTemplate.rowBar.hoverColor[3], elementTemplate.rowBar.hoverColor[4]*j.animAlphaPercent), false)
                    end
                    for k = 1, #elementReference.gridData.columns, 1 do
                        local v = elementReference.gridData.columns[k]
                        dxDrawText(j[k] or "-", row_offsetX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[k].startX + gridlist_columnBar_padding, row_offsetY + (elementTemplate.rowBar.fontPaddingY or 0), row_offsetX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[k].endX - gridlist_columnBar_padding, row_offsetY + gridlist_rowBar_height, gridlist_rowBar_fontColor, elementTemplate.rowBar.fontScale or 1, elementTemplate.rowBar.font, "center", "center", true, false, false, false)
                        if j.animAlphaPercent > 0 then
                            dxDrawText(j[k] or "-", row_offsetX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[k].startX + gridlist_columnBar_padding, row_offsetY + (elementTemplate.rowBar.fontPaddingY or 0), row_offsetX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[k].endX - gridlist_columnBar_padding, row_offsetY + gridlist_rowBar_height, tocolor(elementTemplate.rowBar.hoverFontColor[1], elementTemplate.rowBar.hoverFontColor[2], elementTemplate.rowBar.hoverFontColor[3], elementTemplate.rowBar.hoverFontColor[4]*j.animAlphaPercent), elementTemplate.rowBar.fontScale or 1, elementTemplate.rowBar.font, "center", "center", true, false, false, false)
                        end
                    end
                end
                if gridlist_exceeded_height > 0 then
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"] = {
                        {
                            isDisabled = elementReference.isDisabled,
                            elementReference = elementReference,
                            startX = gridlist_renderTarget_width,
                            startY = 0,
                            height = gridlist_renderTarget_height,
                            overflownSize = gridlist_exceeded_height,
                            multiplier = gridlist_row_occupiedSpace,
                            postGUI = false
                        },
                        elementReference.gui.scrollBar_Vertical
                    }
                    renderScrollbar(element, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"][2])
                end
            end
            renderElementChildren(element)
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
        for i = 1, #elementReference.gridData.columns, 1 do
            local j = elementReference.gridData.columns[i]
            if i ~= #elementReference.gridData.columns then
                dxDrawRectangle(gridlist_startX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[i].startX + j.width + gridlist_columnBar_divider_size, gridlist_startY + gridlist_columnBar_height, gridlist_columnBar_divider_size, gridlist_height - gridlist_columnBar_height, gridlist_columnBar_divider_color, gridlist_postGUI)
            end
            dxDrawText(j.name, gridlist_startX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[i].startX + gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_padding + (elementTemplate.columnBar.fontPaddingY or 0), gridlist_startX + elementReference.gui["__UI_CACHE__"]["Column"].offsets[i].endX - gridlist_columnBar_padding, gridlist_startY + gridlist_columnBar_height, gridlist_columnBar_fontColor, elementTemplate.columnBar.fontScale or 1, elementTemplate.columnBar.font, "center", "center", true, false, gridlist_postGUI, false)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        renderElementChildren(element, true, mouseReference)
        if #elementReference.gridData.rows > 0 then
            local isElementHovered = CLIENT_HOVERED_ELEMENT == element
            local isGridListHovered = false
            if isElementHovered then
                local isGridViewAnimating = math.round(elementReference.gui.scrollBar_Vertical.currentPercent, 0) ~= math.round(elementReference.gui.scrollBar_Vertical.finalPercent or 0, 0)
                if not elementReference.isDisabled and not isGridViewAnimating then
                    isGridListHovered = true
                end
            end
            for i = elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"]["Start Index"], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"]["End Index"], 1 do
                local j = elementReference.gridData.rows[i]
                local isRowHovered = false
                if isGridListHovered then
                    isRowHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Rows"][i].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Rows"][i].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Content Section"].width, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Row"].height)
                end
                if isRowHovered or (elementReference.gridData.selection == i) then
                    if isKeyClicked("mouse1") and (elementReference.gridData.selection ~= i) then
                        setGridlistSelection(element, i)
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
            end
            if elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"] then
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"][1].isDisabled = elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"][1].isDisabled or not isGridListHovered
                renderScrollbar(element, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bar"]["Vertical"][2], true)
            end
        end
    end
    return true

end