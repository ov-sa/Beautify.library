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
createdParentElements = {}
local createdChildElements = {}


-----------------------------------------------
--[[ Function: Verifies Element's Validity ]]--
-----------------------------------------------

function isElementValid(element)

    if element and isElement(element) then
        if createdElements[element] then
            if createdElements[element].isValid then
                return true
            end
        else
            local elementParent = createdChildElements[element]
            if elementParent and isElement(elementParent) and createdParentElements[elementParent] and createdParentElements[elementParent][element] and createdElements[elementParent] then
                if createdElements[elementParent].isValid then
                    return true
                end
            end
        end
    end
    return false

end


--------------------------------------------
--[[ Function: Creates/Destroys Element ]]--
--------------------------------------------

function createElement(elementType, parentElement)

    if not elementType or not availableElements[elementType] then return false end

    local createdElement = Element(elementType)
    if not createdElement or not isElement(createdElement) then 
        return false
    else
        local isChildElement = false
        if parentElement and isElement(parentElement) then
            local parentType = parentElement:getType()
            if createdElements[parentElement] and createdParentElements[parentElement] and availableElements[parentType] and availableElements[parentType].__allowedChildren and availableElements[parentType].__allowedChildren[elementType] then
                isChildElement = true
            else
                return false
            end
        end
        if isChildElement then
            createdParentElements[parentElement][createdElement] = {}
        else
            if availableElements[elementType].__allowedChildren then
                createdParentElements[createdElement] = {}
            end
            createdElements[createdElement] = {}
        end
        return createdElement        
    end

end

function destroyElement(element)

    if element then
        if createdElements[element] then
            createdElements[element].isValid = nil
            if createdParentElements[element] then
                for i, j in pairs(createdParentElements[element]) do
                    if i and isElement(i) then
                        i:destroy()
                    end
                end
                createdParentElements[element] = nil
            end
            createdElements[element] = nil
            return true
        else
            for i, j in pairs(createdParentElements) do
                if j[element] then
                    j[element] = nil
                    return true
                end
            end
        end
    end
    return false

end
