----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Grid List's Exports ]]--
----------------------------------------------------------------


-------------------------------------
--[[ Function: Creates Grid List ]]--
-------------------------------------

function createGridlist(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType) then return false end
    local createdElement, elementParent = createElement(elementType, parameters[5], sourceResource)
    if not createdElement then return false end
    local uiTemplate = getUITemplate(elementType)
    if not uiTemplate then return false end

    local elementReference = (elementParent and createdParentElements[elementParent][createdElement]) or createdElements[createdElement]
    elementReference.gui = {}
    elementReference.gridData = {
        columns = {},
        rows = {},
        selectedRow = false
    }
    elementReference.scroller = {}
    for i, j in ipairs(availableElements[elementType].__syntax.parameters) do
        if j.name == "x" or j.name == "y" then
            elementReference.gui[j.name] = math.max(0, parameters[i])
        elseif j.name == "width" or j.name == "height" then
            elementReference.gui[j.name] = math.max(availableElements[elementType].__minimumSize, parameters[i])
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (not elementParent and (parameters[6] and true)) or false
    for i, j in pairs(uiTemplate) do
        elementReference.gui[i] = table.copy(j, true)
    end
    elementReference.gui.contentSection = {
        startX = 0,
        startY = availableElements["beautify_gridlist"].__columnBar.height,
        width = elementReference.gui.width,
        height = elementReference.gui.height - availableElements["beautify_gridlist"].__columnBar.height
    }
    if elementReference.gui.contentSection.width > 0 and elementReference.gui.contentSection.height > 0 then
        elementReference.gui.renderTarget = DxRenderTarget(elementReference.gui.contentSection.width, elementReference.gui.contentSection.height, true)
    end
    elementReference.isValid = true
    return createdElement

end


--------------------------------------------------
--[[ Functions: Adds/Removes Grid List Column ]]--
--------------------------------------------------

function addGridlistColumn(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "addGridlistColumn") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    table.insert(elementReference.gridData.columns, {name = parameters[2], width = parameters[3]})
    return #elementReference.gridData.columns

end

function removeGridlistColumn(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "removeGridlistColumn") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] then return false end
    table.remove(elementReference.gridData.columns, parameters[2])
    for i, j in ipairs(elementReference.gridData.rows) do
        j[(parameters[2])] = nil
    end
    if #elementReference.gridData.columns <= 0 then
        elementReference.gridData.selectedRow = false
    end
    return true

end


-----------------------------------------------
--[[ Functions: Adds/Removes Grid List Row ]]--
-----------------------------------------------

function addGridlistRow(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "addGridlistRow") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    table.insert(elementReference.gridData.rows, {})
    return #elementReference.gridData.rows

end

function removeGridlistRow(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "removeGridlistRow") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] then return false end
    table.remove(elementReference.gridData.rows, parameters[2])
    if elementReference.gridData.selectedRow and elementReference.gridData.selectedRow == parameters[2] then
        elementReference.gridData.selectedRow = false
    end
    return true

end


---------------------------------------------------
--[[ Functions: Sets/Gets Grid List Row's Data ]]--
---------------------------------------------------

function setGridlistRowData(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "setGridlistRowData") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or not elementReference.gridData.columns[(parameters[3])] then return false end
    elementReference.gridData.rows[(parameters[2])][(parameters[3])] = parameters[4]
    return true

end

function getGridlistRowData(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "getGridlistRowData") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or not elementReference.gridData.columns[(parameters[3])] then return false end
    return elementReference.gridData.rows[(parameters[2])][(parameters[3])]

end


----------------------------------------------------
--[[ Functions: Sets/Gets Grid List's Selection ]]--
----------------------------------------------------

function getGridlistSelection(...)

    local parameters = {...}
    local elementType = "beautify_gridlist"
    if not isUIParametersValid(parameters, elementType, "getGridlistSelection") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementParent = getUIParent(element)
    local elementReference = (elementParent and createdParentElements[elementParent][element]) or createdElements[element]
    if not elementReference.gridData.selectedRow or not elementReference.gridData.rows[(elementReference.gridData.selectedRow)] then return false end
    return elementReference.gridData.selectedRow

end