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

local createdTemplates = {}


--------------------------------------------------
--[[ Function: Clears Resource's UI Templates ]]--
--------------------------------------------------

function __clearResourceUITemplates(sourceResource)

    if not sourceResource then return false end

    for i, j in pairs(createdTemplates) do
        if j and j[sourceResource] then
            j[sourceResource] = nil
        end
    end
    collectgarbage()
    return true

end


--------------------------------------------------
--[[ Functions: Retrieves/Set's UI's Template ]]--
--------------------------------------------------

function __getUITemplate(elementType)

    if not elementType or not availableTemplates[elementType] then return false end
    
    if createdTemplates[elementType] and createdTemplates[elementType][sourceResource or resource] then
        return createdTemplates[elementType][sourceResource or resource]
    end
    return availableTemplates[elementType]

end

function __setUITemplate(elementType, elementTemplate)

    if not elementType or not elementTemplate or not availableTemplates[elementType] then return false end

    if not createdTemplates[elementType] then createdTemplates[elementType] = {} end
    createdTemplates[elementType][sourceResource or resource] = elementTemplate
    return true

end