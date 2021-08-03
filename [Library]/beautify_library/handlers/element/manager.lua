----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: manager.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Manager ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

createdElements = {}
createdRenderingPriority = {}
local createdNonParentElements = {}


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function __getUIParent(element)

    if element and isElement(element) and not createdNonParentElements[element] and createdElements[element] then
        if createdElements[element].parentElement and isElement(createdElements[element].parentElement) then
            return createdElements[element].parentElement, createdElements[element].parentReference
        end
    end
    return false

end


--------------------------------------------
--[[ Function: Creates/Destroys Element ]]--
--------------------------------------------

function createElement(elementType, parentElement, sourceResource)

    if not elementType or not availableElements[elementType] then return false end

    local createdElement = Element(elementType)
    if createdElement and isElement(createdElement) then 
        local isChildElement = false
        if parentElement and isElement(parentElement) then
            local parentType = parentElement:getType()
            if availableElements[parentType] and availableElements[parentType].allowedChildren and availableElements[parentType].allowedChildren[elementType] and (createdElements[parentElement].sourceResource == sourceResource) then
                isChildElement = true
            else
                createdElement:destroy()
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
        table.insert(renderIndexReference, {
            element = createdElement,
            children = {}
        })
        createdElements[createdElement].sourceResource = sourceResource
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

    if not element or not isElement(element) or not createdElements[element] then return false end

    local parentElement = createdElements[element].parentElement
    createdElements[element].isValid = false
    for i, j in pairs(createdElements[element].children) do
        destroyElement(i)
    end
    if createdElements[element].gui then
        for i, j in pairs(createdElements[element].gui) do
            if i and isElement(i) then
                i:destroy()
            end
        end
    end
    table.remove(createdElements[element].renderIndexReference, createdElements[element].renderIndex)
    createdNonParentElements[element] = nil
    if parentElement and createdElements[parentElement] then
        createdElements[parentElement].renderIndexReference[(createdElements[parentElement].renderIndex)].children[element] = nil
        createdElements[parentElement].children[element] = nil
    end
    createdElements[element] = nil
    element:destroy()
    collectgarbage()
    return true

end
