----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Grid List's Exports ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    ipairs = ipairs,
    addEventHandler = addEventHandler,
    triggerEvent = triggerEvent,
    isUIValid = isUIValid,
    cloneUIOutline = cloneUIOutline,
    areUIParametersValid = areUIParametersValid,
    dxCreateRenderTarget = dxCreateRenderTarget,
    table = {
        insert = table.insert,
        remove = table.remove
    },
    math = {
        max = math.max
    }
}

imports.addEventHandler("onClientResourceStart", resource, function()
    imports.__getUITemplate = __getUITemplate
    imports.createUIElement = createUIElement
    imports.updateElement = updateElement
    imports.reloadElement = reloadElement
end)


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_gridlist"


-------------------------------------
--[[ Function: Creates Grid List ]]--
-------------------------------------

function createGridlist(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType) then return false end
    local createdElement, elementParent = imports.createUIElement(elementType, parameters[(#availableElements[elementType].syntax.parameters + 1)], sourceResource)
    if not createdElement then return false end

    local elementReference = createdElements[createdElement]
    local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)
    if not elementTemplate then return false end

    elementReference.gui = imports.cloneUIOutline(elementType)
    elementReference.gridData = {
        columns = {},
        rows = {},
        selection = false
    }
    elementReference.gui["__UI_CACHE__"]["Column"] = {
        offsets = {}
    }
    for i, j in imports.ipairs(availableElements[elementType].syntax.parameters) do
        if (j.name == "width") or (j.name == "height") then
            elementReference.gui[j.name] = imports.math.max(0, imports.math.max(availableElements[elementType].minimumSize, parameters[i]))
        else
            elementReference.gui[j.name] = parameters[i]
        end
    end
    elementReference.gui.postGUI = (not elementParent and (parameters[(#availableElements[elementType].syntax.parameters + 2)] and true)) or false
    elementReference.gui.viewSection = {
        startX = 0,
        startY = availableElements[elementType].columnBar.height,
        width = elementReference.gui.width,
        height = elementReference.gui.height - availableElements[elementType].columnBar.height
    }
    if elementReference.gui.viewSection.width > 0 and elementReference.gui.viewSection.height > 0 then
        elementReference.gui.renderTarget = imports.dxCreateRenderTarget(elementReference.gui.viewSection.width, elementReference.gui.viewSection.height, true)
    end
    elementReference.isValid = true
    imports.reloadElement(createdElement)
    return createdElement

end


----------------------------------------------------------
--[[ Functions: Counts/Adds/Removes Grid List Columns ]]--
----------------------------------------------------------

function countGridlistColumns(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "countGridlistColumns") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return #elementReference.gridData.columns

end

function addGridlistColumn(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "addGridlistColumn") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    imports.table.insert(elementReference.gridData.columns, {name = parameters[2], width = parameters[3]})
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return #elementReference.gridData.columns

end

function removeGridlistColumn(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "removeGridlistColumn") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] then return false end
    imports.table.remove(elementReference.gridData.columns, parameters[2])
    for i, j in imports.ipairs(elementReference.gridData.rows) do
        j[(parameters[2])] = nil
    end
    if #elementReference.gridData.columns <= 0 then
        elementReference.gridData.selection = false
        imports.triggerEvent("onClientUISelectionAltered", element, elementReference.gridData.selection)
    end
    imports.reloadElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end


------------------------------------------------------
--[[ Functions: Sets/Gets Grid List Column's Name ]]--
------------------------------------------------------

function setGridlistColumnName(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setGridlistColumnName") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] or (elementReference.gridData.columns[(parameters[2])].name == parameters[3]) then return false end
    elementReference.gridData.columns[(parameters[2])].name = parameters[3]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getGridlistColumnName(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getGridlistColumnName") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.columns[(parameters[2])] then return false end
    return elementReference.gridData.columns[(parameters[2])].name

end


-------------------------------------------------------
--[[ Functions: Counts/Adds/Removes Grid List Rows ]]--
-------------------------------------------------------

function countGridlistRows(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "countGridlistRows") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    return #elementReference.gridData.rows

end

function addGridlistRow(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "addGridlistRow") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    imports.table.insert(elementReference.gridData.rows, {})
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return #elementReference.gridData.rows

end

function removeGridlistRow(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "removeGridlistRow") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] then return false end
    imports.table.remove(elementReference.gridData.rows, parameters[2])
    if elementReference.gridData.selection and elementReference.gridData.selection == parameters[2] then
        elementReference.gridData.selection = false
        imports.triggerEvent("onClientUISelectionAltered", element, elementReference.gridData.selection)
    end
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end


---------------------------------------------------
--[[ Functions: Sets/Gets Grid List Row's Data ]]--
---------------------------------------------------

function setGridlistRowData(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setGridlistRowData") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or not elementReference.gridData.columns[(parameters[3])] or (elementReference.gridData.rows[(parameters[2])][(parameters[3])] == parameters[4]) then return false end
    elementReference.gridData.rows[(parameters[2])][(parameters[3])] = parameters[4]
    imports.updateElement(element)
    imports.triggerEvent("onClientUIAltered", element)
    return true

end

function getGridlistRowData(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getGridlistRowData") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or not elementReference.gridData.columns[(parameters[3])] then return false end
    return elementReference.gridData.rows[(parameters[2])][(parameters[3])]

end


----------------------------------------------------
--[[ Functions: Sets/Gets Grid List's Selection ]]--
----------------------------------------------------

function setGridlistSelection(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "setGridlistSelection") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.rows[(parameters[2])] or (elementReference.gridData.selection and elementReference.gridData.selection == parameters[2]) then return false end
    elementReference.gridData.selection = parameters[2]
    imports.updateElement(element)
    imports.triggerEvent("onClientUISelectionAltered", element, elementReference.gridData.selection)
    return true

end

function getGridlistSelection(...)

    local parameters = {...}
    if not imports.areUIParametersValid(parameters, elementType, "getGridlistSelection") then return false end
    local element = parameters[1]
    if not imports.isUIValid(element) then return false end

    local elementReference = createdElements[element]
    if not elementReference.gridData.selection or not elementReference.gridData.rows[(elementReference.gridData.selection)] then return false end
    return elementReference.gridData.selection

end