----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Exports ]]--
----------------------------------------------------------------


----------------------------------
--[[ Function: Creates Window ]]--
----------------------------------

function createWindow(...)

    local parameters = {...}
    local elementType = "ov_window"
    if not isUIParametersValid(parameters, elementType) then return false end
    local createdElement = createElement(elementType)
    if not createdElement then return false end

    createdElements[createdElement] = {
        gui = {},
        scroller = {}
    }
    windowReferences[createdElement] = {}
    for i, j in ipairs(availableElements[elementType].__syntax.parameters) do
        createdElements[createdElement].gui[j.name] = parameters[i]
    end
    createdElements[createdElement].isValid = true
    return createdElement

end