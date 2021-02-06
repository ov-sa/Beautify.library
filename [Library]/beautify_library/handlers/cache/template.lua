----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: template.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Cache Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local customTemplate = {}


-------------------------------------------
--[[ Function: Retrieves UI's Template ]]--
-------------------------------------------

function getUITemplate(elementType)

    if not elementType or not availableElements[elementType] or not availableTemplate[elementType] then return false end
    
    if customTemplate[elementType] then
        return customTemplate[elementType]
    end
    return availableTemplate[elementType]

end