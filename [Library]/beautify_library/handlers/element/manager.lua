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
local __createdChildElements = {}


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function getUIParent(element)

    if element and isElement(element) and not createdElements[element] then
        local elementParent = __createdChildElements[element]
        if elementParent and isElement(elementParent) and createdParentElements[elementParent] and createdParentElements[elementParent][element] and createdElements[elementParent] then
            return elementParent
        end
    end
    return false

end


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
            local elementParent = getUIParent(element)
            if elementParent and createdElements[elementParent].isValid then
                return true
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
            __createdChildElements[createdElement] = parentElement
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
                        __createdChildElements[i] = nil
                        i:destroy()
                    end
                end
                createdParentElements[element] = nil
            end
            createdElements[element] = nil
            return true
        else
            local elementParent = __createdChildElements[element]
            if elementParent and createdParentElements[elementParent] then
                createdParentElements[elementParent][element] = nil
                __createdChildElements[element] = nil
                return true
            end
        end
    end
    return false

end
