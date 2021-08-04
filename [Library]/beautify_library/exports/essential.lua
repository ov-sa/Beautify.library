----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: essential.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Essential Exports ]]--
----------------------------------------------------------------


------------------------------------------------------------
--[[ Functions: Clears Resource's UI Templates/Elements ]]--
------------------------------------------------------------

function clearResourceUITemplates()

    return __clearResourceUITemplates(sourceResource)

end

function clearResourceUIElements()

    return __clearResourceUIElements(sourceResource)

end


-------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Template ]]--
-------------------------------------------------

function getUITemplate(...)

    local parameters = {...}
    return __getUITemplate(parameters[1])

end

function setUITemplate(...)

    return __setUITemplate(...)

end


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function getUIParent(...)

    return __getUIParent(...)

end


------------------------------------------
--[[ Function: Verifies UI's Validity ]]--
------------------------------------------

function isUIValid(element)

    if element and isElement(element) then
        local elementParent = getUIParent(element)
        if elementParent then
            if createdElements[elementParent].isValid then
                return createdElements[element].isValid
            end
        else
            return createdElements[element].isValid
        end
    end
    return false

end


---------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Visibility ]]--
---------------------------------------------------

function isUIVisible(element)

    if isUIValid(element) then
        local elementParent = getUIParent(element)
        if elementParent then
            if createdElements[elementParent].isVisible then
                return createdElements[element].isVisible
            end
        else
            return createdElements[element].isVisible
        end
    end
    return false

end

function setUIVisible(element, state)

    if isUIValid(element) and (state == true or state == false) then
        if createdElements[element].isVisible ~= state then
            createdElements[element].isVisible = state
            return true
        end
    end
    return false

end


-----------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Draggability ]]--
-----------------------------------------------------

function isUIDraggable(element)

    if isUIValid(element) then
        return createdElements[element].isDraggable
    end
    return false

end

function setUIDraggable(element, state)

    if isUIValid(element) and availableElements[element:getType()].isDraggable and (state == true or state == false) then
        if createdElements[element].isDraggable ~= state then
            createdElements[element].isDraggable = state
            return true
        end
    end
    return false

end


-------------------------------------------------------
--[[ Functions: Retrieves/Sets UI's Disabled State ]]--
-------------------------------------------------------

function isUIDisabled(element)

    if isUIValid(element) then
        return createdElements[element].isDisabled
    end
    return false

end

function setUIDisabled(element, state)

    if isUIValid(element) and (state == true or state == false) then
        if createdElements[element].isDisabled ~= state then
            createdElements[element].isDisabled = state
            return true
        end
    end
    return false

end