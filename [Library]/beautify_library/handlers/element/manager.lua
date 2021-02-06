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
local ____createdChildElements = {}


--------------------------------------------
--[[ Function: Retrieves Child Elements ]]--
--------------------------------------------

function _____getChildElements()

    return ____createdChildElements

end


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function _____getUIParent(element)

    if element and isElement(element) and not createdElements[element] then
        local elementParent = ____createdChildElements[element]
        if elementParent and isElement(elementParent) and createdParentElements[elementParent] and createdParentElements[elementParent][element] and createdElements[elementParent] then
            return elementParent
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
            ____createdChildElements[createdElement] = parentElement
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
                        ____createdChildElements[i] = nil
                        i:destroy()
                    end
                end
                createdParentElements[element] = nil
            end
            createdElements[element] = nil
            return true
        else
            local elementParent = ____createdChildElements[element]
            if elementParent and createdParentElements[elementParent] then
                createdParentElements[elementParent][element] = nil
                ____createdChildElements[element] = nil
                return true
            end
        end
    end
    return false

end
