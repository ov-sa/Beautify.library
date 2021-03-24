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
        rows = {
            --TODO: TESTING REMOVE LATER :)
            {["S.No"] = 1, ["Name"] = "Tron", ["Country"] = "BH", ["Rank"] = "CEO"},
            {["S.No"] = 2, ["Name"] = "Acen", ["Country"] = "BZ", ["Rank"] = "Member"},
            {["S.No"] = 3, ["Name"] = "Aviril", ["Country"] = "US", ["Rank"] = "Developer"},
        }
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
