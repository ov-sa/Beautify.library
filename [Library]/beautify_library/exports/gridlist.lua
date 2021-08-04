----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Grid List's Exports ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_gridlist"


-------------------------------------
--[[ Function: Creates Grid List ]]--
-------------------------------------

function createGridlist(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType) then return false end
    local createdElement, elementParent = createElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end
    local uiTemplate = __getUITemplate(elementType, createdElement)
    if not uiTemplate then return false end

    local elementReference = createdElements[createdElement]
    elementReference.gui = cloneUIOutline(elementType)
    elementReference.gridData = {
        columns = {},
        rows = {},
        selection = false
    }
    elementReference.gui["__UI_CACHE__"]["Column"] = {
        areColumnsModified = false,
        offsets = {}
    }
    for i, j in ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = math.max(0, math.max(availableElements[elementType].minimumSize, parameters[i]))
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (not elementParent and (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true)) or false
    elementReference.gui.contentSection = {
        startX = 0,
        startY = availableElements["beautify_gridlist"].columnBar.height,
        width = elementReference.gui.width,
        height = elementReference.gui.height - availableElements["beautify_gridlist"].columnBar.height
    }
    if elementReference.gui.contentSection.width > 0 and elementReference.gui.contentSection.height > 0 then
        elementReference.gui.renderTarget = DxRenderTarget(elementReference.gui.contentSection.width, elementReference.gui.contentSection.height, true)
    end
    elementReference.isValid = true
    return createdElement

end


----------------------------------------------------------
--[[ Functions: Counts/Adds/Removes Grid List Columns ]]--
----------------------------------------------------------

function countGridlistColumns(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "countGridlistColumns") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return #elementReference.gridData.columns

end

function addGridlistColumn(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "addGridlistColumn") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    table.insert(elementReference.gridData.columns, {name = parameters[2], width = parameters[3]})
    elementReference.gui["__UI_CACHE__"]["Column"].areColumnsModified = true
    triggerEvent("onClientUIAltered", element)
    return #elementReference.gridData.columns

end

function removeGridlistColumn(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "removeGridlistColumn") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] then return false end
    table.remove(elementReference.gridData.columns, parameters[2])
    for i, j in ipairs(elementReference.gridData.rows) do
        j[(parameters[2])] = nil
    end
    if #elementReference.gridData.columns <= 0 then
        elementReference.gridData.selection = false
    end
    elementReference.gui["__UI_CACHE__"]["Column"].areColumnsModified = true
    triggerEvent("onClientUIAltered", element)
    return true

end


------------------------------------------------------
--[[ Functions: Sets/Gets Grid List Column's Name ]]--
------------------------------------------------------

function setGridlistColumnName(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setGridlistColumnName") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] or (elementReference.gridData.columns[(parameters[2])].name == parameters[3]) then return false end
    elementReference.gridData.columns[(parameters[2])].name = parameters[3]
    return true

end

function getGridlistColumnName(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getGridlistColumnName") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] then return false end
    return elementReference.gridData.columns[(parameters[2])].name

end


-------------------------------------------------------
--[[ Functions: Counts/Adds/Removes Grid List Rows ]]--
-------------------------------------------------------

function countGridlistRows(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "countGridlistRows") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return #elementReference.gridData.rows

end

function addGridlistRow(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "addGridlistRow") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    table.insert(elementReference.gridData.rows, {})
    triggerEvent("onClientUIAltered", element)
    return #elementReference.gridData.rows

end

function removeGridlistRow(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "removeGridlistRow") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] then return false end
    table.remove(elementReference.gridData.rows, parameters[2])
    if elementReference.gridData.selection and elementReference.gridData.selection == parameters[2] then
        elementReference.gridData.selection = false
    end
    triggerEvent("onClientUIAltered", element)
    return true

end


---------------------------------------------------
--[[ Functions: Sets/Gets Grid List Row's Data ]]--
---------------------------------------------------

function setGridlistRowData(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setGridlistRowData") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or not elementReference.gridData.columns[(parameters[3])] or (elementReference.gridData.rows[(parameters[2])][(parameters[3])] == parameters[4]) then return false end
    elementReference.gridData.rows[(parameters[2])][(parameters[3])] = parameters[4]
    return true

end

function getGridlistRowData(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getGridlistRowData") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or not elementReference.gridData.columns[(parameters[3])] then return false end
    return elementReference.gridData.rows[(parameters[2])][(parameters[3])]

end


----------------------------------------------------
--[[ Functions: Sets/Gets Grid List's Selection ]]--
----------------------------------------------------

function setGridlistSelection(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "setGridlistSelection") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or (elementReference.gridData.selection and elementReference.gridData.selection == parameters[2]) then return false end
    elementReference.gridData.selection = parameters[2]
    return true

end

function getGridlistSelection(...)

    local parameters = {...}
    if not areUIParametersValid(parameters, elementType, "getGridlistSelection") then return false end
    local element = parameters[1]
    if not isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.selection or not elementReference.gridData.rows[(elementReference.gridData.selection)] then return false end
    return elementReference.gridData.selection

end