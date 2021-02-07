----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: essential.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Essential Exports ]]--
----------------------------------------------------------------


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function getUIParent(element)

    return _____getUIParent(element)

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


---------------------------------------------
--[[ Function: Retrieves UI's Visibility ]]--
---------------------------------------------

function isUIVisible(element)

    if element and isElement(element) and isUIValid(element) then
        if createdElements[element] then
            return createdElements[element].isVisible
        else
            local elementParent = getUIParent(element)
            if elementParent then
                return createdElements[elementParent].isVisible
            end
        end
    end
    return false

end


----------------------------------------
--[[ Function: Sets UI's Visibility ]]--
----------------------------------------

function setUIVisible(element, state)

    if element and isElement(element) and isUIValid(element) and (state == true or state == false) then
        if createdElements[element] then
            if createdElements[element].isVisible ~= state then
                createdElements[element].isVisible = state
                return true
            end
        else
            local elementParent = getUIParent(element)
            if elementParent then
                if createdElements[elementParent].isVisible ~= state then
                    createdElements[elementParent].isVisible = state
                    return true
                end
            end
        end
    end
    return false

end