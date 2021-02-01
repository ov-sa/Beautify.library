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
inputDelayDuration = 500 --(In milliseconds)
availableElements = {

    ["ov_panel"] = {
        __clearCache = __destroyWindow
    }

}


--------------------------------------------
--[[ Function: Creates/Destroys Element ]]--
--------------------------------------------

function createElement(elementType)

    if not elementType or not availableElements[elementType] then return false end

    local createdElement = Element(elementType)
    createdElements[createdElement] = {}
    return createdElement

end

function destroyElement(element, skipSelf)

    if element and createdElements[element] then
        createdElements[element] = nil
        if not skipSelf then
            element:destroy()
        end
        return true
    end
    return false

end
