----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: manager.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Manager ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    pairs = pairs,
    ipairs = ipairs,
    isElement = isElement,
    getElementType = getElementType,
    createElement = createElement,
    destroyElement = destroyElement,
    collectgarbage = collectgarbage,
    table = {
        insert = table.insert,
        remove = table.remove
    }
}


-------------------
--[[ Variables ]]--
-------------------

local createdResourceElements = {}
createdElements = {}
createdRenderingPriority = {}
local createdNonParentElements = {}


-------------------------------------------------
--[[ Function: Clears Resource's UI Elements ]]--
-------------------------------------------------

function __clearResourceUIElements(sourceResource)

    if not sourceResource or not createdResourceElements[sourceResource] then return false end

    for i, j in imports.ipairs(createdResourceElements[sourceResource]) do
        if j and imports.isElement(j) then
            imports.destroyElement(j)
        end
    end
    createdResourceElements[sourceResource] = nil
    imports.collectgarbage()
    return true

end


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function __getUIParent(element)

    if element and imports.isElement(element) and not createdNonParentElements[element] and createdElements[element] then
        if createdElements[element].parentElement and imports.isElement(createdElements[element].parentElement) then
            return createdElements[element].parentElement, createdElements[element].parentReference
        end
    end
    return false

end


--------------------------------------------
--[[ Function: Creates/Destroys Element ]]--
--------------------------------------------

function createElement(elementType, parentElement, sourceResource)

    if not elementType or not availableElements[elementType] or not sourceResource or (sourceResource == resource) then return false end

    local createdElement = imports.createElement(elementType)
    if createdElement and imports.isElement(createdElement) then 
        local isChildElement = false
        if parentElement and imports.isElement(parentElement) then
            local parentType = imports.getElementType(parentElement)
            if availableElements[parentType] and availableElements[parentType].allowedChildren and availableElements[parentType].allowedChildren[elementType] and (createdElements[parentElement].sourceResource == sourceResource) then
                isChildElement = true
            else
                imports.destroyElement(createdElement)
                return false
            end
        end
        local renderIndexReference = false
        if isChildElement then
            renderIndexReference = createdElements[parentElement].renderIndexReference[(createdElements[parentElement].renderIndex)].children
            createdElements[createdElement] = {
                parentElement = parentElement
            }
            createdElements[parentElement].children[createdElement] = true
        else
            parentElement = nil
            renderIndexReference = createdRenderingPriority
            createdElements[createdElement] = {}
            createdNonParentElements[createdElement] = true
        end
        imports.table.insert(renderIndexReference, {
            element = createdElement,
            children = {}
        })
        if not createdResourceElements[sourceResource] then
            createdResourceElements[sourceResource] = {}
        end
        createdElements[createdElement].sourceResource = sourceResource
        imports.table.insert(createdResourceElements[sourceResource], createdElement)
        createdElements[createdElement].renderIndex = #renderIndexReference
        createdElements[createdElement].renderIndexReference = renderIndexReference
        createdElements[createdElement].isValid = false
        createdElements[createdElement].isVisible = false
        createdElements[createdElement].isDraggable = false
        createdElements[createdElement].isDisabled = false
        createdElements[createdElement].children = {}
        return createdElement, parentElement
    end
    return false

end

function destroyElement(element)

    if not element or not imports.isElement(element) or not createdElements[element] then return false end

    local parentElement = createdElements[element].parentElement
    createdElements[element].isValid = false
    for i, j in imports.pairs(createdElements[element].children) do
        imports.destroyElement(i)
    end
    if createdElements[element].gui then
        for i, j in imports.pairs(createdElements[element].gui) do
            if i and imports.isElement(i) then
                imports.destroyElement(i)
            end
        end
    end
    imports.table.remove(createdElements[element].renderIndexReference, createdElements[element].renderIndex)
    createdNonParentElements[element] = nil
    if parentElement and createdElements[parentElement] then
        createdElements[parentElement].renderIndexReference[(createdElements[parentElement].renderIndex)].children[element] = nil
        createdElements[parentElement].children[element] = nil
    end
    createdElements[element] = nil
    imports.destroyElement(element)
    imports.collectgarbage()
    return true

end
