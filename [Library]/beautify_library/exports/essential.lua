----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: essential.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Essential Exports ]]--
----------------------------------------------------------------


------------------------------------------
--[[ Function: Verifies UI's Validity ]]--
------------------------------------------

function isUIValid(element)

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


-----------------------------------------
--[[ Function: Retrieves UI's Parent ]]--
-----------------------------------------

function getUIParent(element)

    return _getUIParent(element)

end