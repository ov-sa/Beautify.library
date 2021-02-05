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


-----------------------------------------------
--[[ Function: Verifies Element's Validity ]]--
-----------------------------------------------

function isElementValid(element)

    if not element or not isElement(element) or not createdElements[element] or not createdElements[element].isValid then
        return false
    else
        return true
    end

end


--------------------------------------------
--[[ Function: Creates/Destroys Element ]]--
--------------------------------------------

function createElement(elementType)

    if not elementType or not availableElements[elementType] then return false end

    local createdElement = Element(elementType)
    if not createdElement or not isElement(createdElement) then 
        return false
    else
        createdElements[createdElement] = {}
        return createdElement        
    end

end

function destroyElement(element)

    if element and createdElements[element] then
        local elementType = element:getType()
        createdElements[element].isValid = nil
        if elementType and availableElements[elementType] and availableElements[elementType].__destroyReferences and type(availableElements[elementType].__destroyReferences) == "function" then
            availableElements[elementType].__destroyReferences(element)
        end
        createdElements[element] = nil
        return true
    end
    return false

end
