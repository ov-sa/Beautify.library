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

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = __getUIParent(element)
        if not elementParent then dxSetRenderTarget() end
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (reloadResourceTemplates[(elementReference.sourceResource)] and reloadResourceTemplates[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = __getUITemplate(elementType, elementReference.sourceResource)
        local gridlist_postGUI = elementReference.gui.postGUI

        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"] = {}
        if isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Gridlist"] then
                elementReference.gui["__UI_CACHE__"]["Gridlist"] = {
                    offsets = {},
                    view = {
                        offsets = {}
                    }
                }
                elementReference.gui["__UI_CACHE__"]["Grid Columns"] = {
                    offsets = {},
                    divider = {}
                }
                elementReference.gui["__UI_CACHE__"]["Grid Rows"] = {
                    offsets = {}
                }
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid View"] = {}
            end
            local gridlist_startX, gridlist_startY = elementReference.gui.x, elementReference.gui.y
            local gridlist_width, gridlist_height = elementReference.gui.width, elementReference.gui.height
            elementReference.gui["__UI_CACHE__"]["Gridlist"].startX = gridlist_startX
            elementReference.gui["__UI_CACHE__"]["Gridlist"].startY = gridlist_startY
            elementReference.gui["__UI_CACHE__"]["Gridlist"].width = gridlist_width
            elementReference.gui["__UI_CACHE__"]["Gridlist"].height = gridlist_height
            local gridlist_renderTarget_startX, gridlist_renderTarget_startY = elementReference.gui["__UI_CACHE__"]["Gridlist"].startX + elementReference.gui.contentSection.startX, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY + elementReference.gui.contentSection.startY
            local gridlist_renderTarget_width, gridlist_renderTarget_height = elementReference.gui.contentSection.width, elementReference.gui.contentSection.height
            elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.startX = gridlist_renderTarget_startX
            elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.startY = gridlist_renderTarget_startY
            elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.width = gridlist_renderTarget_width
            elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.height = gridlist_renderTarget_height
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid View"].width = elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.width 
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid View"].height = elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.height
            local gridlist_columnBar_height, gridlist_columnBar_padding = availableElements[elementType].columnBar.height, availableElements[elementType].columnBar.padding
            elementReference.gui["__UI_CACHE__"]["Grid Columns"].height = gridlist_columnBar_height
            elementReference.gui["__UI_CACHE__"]["Grid Columns"].padding = gridlist_columnBar_padding
            local gridlist_rowBar_height, gridlist_rowBar_padding = availableElements[elementType].rowBar.height, availableElements[elementType].rowBar.padding
            elementReference.gui["__UI_CACHE__"]["Grid Rows"].height = gridlist_rowBar_height
            elementReference.gui["__UI_CACHE__"]["Grid Rows"].padding = gridlist_rowBar_padding
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Gridlist"].color = tocolor(unpackColor(elementTemplate.color))
                elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.size = elementTemplate.columnBar.divider.size
                elementReference.gui["__UI_CACHE__"]["Grid Columns"].color = tocolor(unpackColor(elementTemplate.columnBar.color))
                elementReference.gui["__UI_CACHE__"]["Grid Columns"].fontColor = tocolor(unpackColor(elementTemplate.columnBar.fontColor))
                elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.color = tocolor(unpackColor(elementTemplate.columnBar.divider.color))
                elementReference.gui["__UI_CACHE__"]["Grid Rows"].color = tocolor(unpackColor(elementTemplate.rowBar.color))
                elementReference.gui["__UI_CACHE__"]["Grid Rows"].fontColor = tocolor(unpackColor(elementTemplate.rowBar.fontColor))
                elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets = {}
                for i, j in ipairs(elementReference.gridData.columns) do
                    local gridlist_column_offsetX = ((elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i - 1] and elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i - 1].endX) or 0) + elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.size
                    elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i] = {
                        startX = gridlist_column_offsetX,
                        endX = gridlist_column_offsetX + j.width + elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.size,
                        text = {
                            offsets = {}
                        }
                    }
                    elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].startX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].padding
                    elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].endX - elementReference.gui["__UI_CACHE__"]["Grid Columns"].padding            
                end
            end
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"] = {}
        dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Gridlist"].startX, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY, elementReference.gui["__UI_CACHE__"]["Gridlist"].width, elementReference.gui["__UI_CACHE__"]["Gridlist"].height, elementReference.gui["__UI_CACHE__"]["Gridlist"].color, gridlist_postGUI)
        local gridlist_renderTarget = elementReference.gui.renderTarget
        local gridlist_row_count, gridlist_column_count = #elementReference.gridData.rows, #elementReference.gridData.columns
        if gridlist_renderTarget and isElement(gridlist_renderTarget) then
            dxSetRenderTarget(gridlist_renderTarget, true)
            dxSetBlendMode("modulate_add")
            if gridlist_row_count > 0 then
                local gridlist_scrolled_offsetY = 0
                local gridlist_row_occupiedSpace = elementReference.gui["__UI_CACHE__"]["Grid Rows"].height + elementReference.gui["__UI_CACHE__"]["Grid Rows"].padding
                local gridlist_row_maxRenderered = math.ceil(elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.height/gridlist_row_occupiedSpace)
                local gridlist_data_height = (gridlist_row_occupiedSpace)*(gridlist_row_count) + elementReference.gui["__UI_CACHE__"]["Grid Rows"].padding
                local gridlist_exceeded_height = gridlist_data_height - elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.height
                if gridlist_exceeded_height > 0 then gridlist_scrolled_offsetY = gridlist_exceeded_height*elementReference.gui.scrollBar_Vertical.currentPercent*0.01 end      
                local gridlist_row_startIndex = math.floor(gridlist_scrolled_offsetY/gridlist_row_occupiedSpace) + 1
                local gridlist_row_endIndex = math.min(gridlist_row_count, gridlist_row_startIndex + gridlist_row_maxRenderered)
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"].startIndex = gridlist_row_startIndex
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"].endIndex = gridlist_row_endIndex
                for i = gridlist_row_startIndex, gridlist_row_endIndex, 1 do
                    local j = elementReference.gridData.rows[i]
                    local row_offsetX, row_offsetY = 0, gridlist_row_occupiedSpace*(i - 1) + elementReference.gui["__UI_CACHE__"]["Grid Rows"].padding - gridlist_scrolled_offsetY
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"][i] = {}
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"][i].startX = elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.startX + row_offsetX
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"][i].startY = elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.startY + row_offsetY
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
                    dxDrawRectangle(row_offsetX, row_offsetY, elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Grid Rows"].height, elementReference.gui["__UI_CACHE__"]["Grid Rows"].color, false)
                    if j.animAlphaPercent > 0  then
                        dxDrawRectangle(row_offsetX, row_offsetY, elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Grid Rows"].height, tocolor(elementTemplate.rowBar.hoverColor[1], elementTemplate.rowBar.hoverColor[2], elementTemplate.rowBar.hoverColor[3], elementTemplate.rowBar.hoverColor[4]*j.animAlphaPercent), false)
                    end
                    for k = 1, gridlist_column_count, 1 do
                        local v = elementReference.gridData.columns[k]
                        local gridlist_column_text = j[k] or "-"
                        local gridlist_column_startX, gridlist_column_startY = row_offsetX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[k].text.offsets.startX, row_offsetY + (elementTemplate.rowBar.fontPaddingY or 0)
                        local gridlist_column_endX, gridlist_column_endY = row_offsetX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[k].text.offsets.endX, row_offsetY + elementReference.gui["__UI_CACHE__"]["Grid Rows"].height
                        dxDrawText(gridlist_column_text, gridlist_column_startX, gridlist_column_startY, gridlist_column_endX, gridlist_column_endY, elementReference.gui["__UI_CACHE__"]["Grid Rows"].fontColor, elementTemplate.rowBar.fontScale or 1, elementTemplate.rowBar.font, "center", "center", true, false, false, false)
                        if j.animAlphaPercent > 0 then
                            dxDrawText(gridlist_column_text, gridlist_column_startX, gridlist_column_startY, gridlist_column_endX, gridlist_column_endY, tocolor(elementTemplate.rowBar.hoverFontColor[1], elementTemplate.rowBar.hoverFontColor[2], elementTemplate.rowBar.hoverFontColor[3], elementTemplate.rowBar.hoverFontColor[4]*j.animAlphaPercent), elementTemplate.rowBar.fontScale or 1, elementTemplate.rowBar.font, "center", "center", true, false, false, false)
                        end
                    end
                end
                if gridlist_exceeded_height > 0 then
                    elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"] = {
                        {
                            isDisabled = elementReference.isDisabled,
                            elementReference = elementReference,
                            startX = elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.width,
                            startY = 0,
                            height = elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.height,
                            overflownSize = gridlist_exceeded_height,
                            multiplier = gridlist_row_occupiedSpace,
                            postGUI = false
                        },
                        elementReference.gui.scrollBar_Vertical
                    }
                    renderScrollbar(element, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][2])
                end
            end
            renderElementChildren(element)
            dxSetBlendMode("blend")
            if not elementParent then
                dxSetRenderTarget()
            else
                dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
            end
            dxDrawImage(elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Gridlist"].view.offsets.height, gridlist_renderTarget, 0, 0, 0, -1, gridlist_postGUI)    
        end
        dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Gridlist"].startX, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY, elementReference.gui["__UI_CACHE__"]["Gridlist"].width, elementReference.gui["__UI_CACHE__"]["Grid Columns"].height, elementReference.gui["__UI_CACHE__"]["Grid Columns"].color, gridlist_postGUI)
        dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Gridlist"].startX, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY + elementReference.gui["__UI_CACHE__"]["Grid Columns"].height, elementReference.gui["__UI_CACHE__"]["Gridlist"].width, elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.size, elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.color, gridlist_postGUI)
        for i = 1, gridlist_column_count, 1 do
            local j = elementReference.gridData.columns[i]
            if i ~= gridlist_column_count then
                dxDrawRectangle(elementReference.gui["__UI_CACHE__"]["Gridlist"].startX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].startX + j.width + elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.size, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY + elementReference.gui["__UI_CACHE__"]["Grid Columns"].height, elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.size, elementReference.gui["__UI_CACHE__"]["Gridlist"].height - elementReference.gui["__UI_CACHE__"]["Grid Columns"].height, elementReference.gui["__UI_CACHE__"]["Grid Columns"].divider.color, gridlist_postGUI)
            end
            dxDrawText(j.name, elementReference.gui["__UI_CACHE__"]["Gridlist"].startX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].startX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].padding, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY + elementReference.gui["__UI_CACHE__"]["Grid Columns"].padding + (elementTemplate.columnBar.fontPaddingY or 0), elementReference.gui["__UI_CACHE__"]["Gridlist"].startX + elementReference.gui["__UI_CACHE__"]["Grid Columns"].offsets[i].endX - elementReference.gui["__UI_CACHE__"]["Grid Columns"].padding, elementReference.gui["__UI_CACHE__"]["Gridlist"].startY + elementReference.gui["__UI_CACHE__"]["Grid Columns"].height, elementReference.gui["__UI_CACHE__"]["Grid Columns"].fontColor, elementTemplate.columnBar.fontScale or 1, elementTemplate.columnBar.font, "center", "center", true, false, gridlist_postGUI, false)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        renderElementChildren(element, true, mouseReference)
        local gridlist_row_count = #elementReference.gridData.rows
        if gridlist_row_count > 0 then
            local isElementHovered = CLIENT_HOVERED_ELEMENT == element
            local isGridListHovered = false
            if isElementHovered then
                local isGridViewAnimating = math.round(elementReference.gui.scrollBar_Vertical.currentPercent, 0) ~= math.round(elementReference.gui.scrollBar_Vertical.finalPercent or 0, 0)
                if not elementReference.isDisabled and not isGridViewAnimating then
                    isGridListHovered = true
                end
            end
            for i = elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"].startIndex, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"].endIndex, 1 do
                local j = elementReference.gridData.rows[i]
                local isRowHovered = false
                if isGridListHovered then
                    isRowHovered = isMouseOnPosition(__mouseReference.x + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"][i].startX, __mouseReference.y + elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid Rows"][i].startY, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Grid View"].width, elementReference.gui["__UI_CACHE__"]["Grid Rows"].height)
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
            if elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"] then
                elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1].isDisabled = elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1].isDisabled or not isGridListHovered
                renderScrollbar(element, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][2], true)
            end
        end
    end
    return true

end