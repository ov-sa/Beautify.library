----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: essential.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Essential Exports ]]--
----------------------------------------------------------------


--------------------------------------------------
--[[ Function: Clears Resource's UI Templates ]]--
--------------------------------------------------

function clearResourceUITemplates(...)

    return __clearResourceUITemplates(unpack{...})

end


-------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Template ]]--
-------------------------------------------------

function getUITemplate(...)

    return __getUITemplate(unpack{...})

end

function setUITemplate(...)

    return __setUITemplate(unpack{...})

end


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function getUIParent(element)

    return __getUIParent(element)

end


------------------------------------------
--[[ Function: Verifies UI's Validity ]]--
------------------------------------------

function isUIValid(element)

    if element and isElement(element) then
        if createdElements[element] then
            return createdElements[element].isValid
        else
            local elementParent = getUIParent(element)
            if elementParent then
                return createdElements[elementParent].isValid
            end
        end
    end
    return false

end


---------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Visibility ]]--
---------------------------------------------------

function isUIVisible(element)

    if element and isElement(element) and isUIValid(element) then
        if createdElements[element] then
            return createdElements[element].isVisible
        else
            local elementParent = getUIParent(element)
            if elementParent and createdParentElements[elementParent][element] and createdElements[elementParent].isVisible then
                return createdParentElements[elementParent][element].isVisible
            end
        end
    end
    return false

end

function setUIVisible(element, state)

    if element and isElement(element) and isUIValid(element) and (state == true or state == false) then
        if createdElements[element] then
            if createdElements[element].isVisible ~= state then
                createdElements[element].isVisible = state
                return true
            end
        else
            local elementParent = getUIParent(element)
            if elementParent and createdParentElements[elementParent][element] then
                if createdParentElements[elementParent][element].isVisible ~= state then
                    createdParentElements[elementParent][element].isVisible = state
                    return true
                end
            end
        end
    end
    return false

end


-----------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Draggability ]]--
-----------------------------------------------------

function isUIDraggable(element)

    if element and isElement(element) and isUIValid(element) then
        if createdElements[element] then
            return createdElements[element].isDraggable
        end
    end
    return false

end

function setUIDraggable(element, state)

    if element and isElement(element) and isUIValid(element) and availableElements[element:getType()].isDraggable and (state == true or state == false) then
        if createdElements[element] then
            if createdElements[element].isDraggable ~= state then
                createdElements[element].isDraggable = state
                return true
            end
        end
    end
    return false

end


-------------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Disabled State ]]--
-------------------------------------------------------

function isUIDisabled(element)

    if element and isElement(element) and isUIValid(element) then
        if createdElements[element] then
            return createdElements[element].isDisabled
        else
            local elementParent = getUIParent(element)
            if elementParent and createdParentElements[elementParent][element] then
                return createdParentElements[elementParent][element].isDisabled
            end
        end
    end
    return false

end

function setUIDisabled(element, state)

    if element and isElement(element) and isUIValid(element) and (state == true or state == false) then
        if createdElements[element] then
            if createdElements[element].isDisabled ~= state then
                createdElements[element].isDisabled = state
                return true
            end
        else
            local elementParent = getUIParent(element)
            if elementParent and createdParentElements[elementParent][element] then
                if createdParentElements[elementParent][element].isDisabled ~= state then
                    createdParentElements[elementParent][element].isDisabled = state
                    return true
                end
            end
        end
    end
    return false

end