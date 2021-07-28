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

local customTemplates = {}


--------------------------------------------------
--[[ Functions: Retrieves/Set's UI's Template ]]--
--------------------------------------------------

function __getUITemplate(elementType)

    if not elementType or not availableElements[elementType] or not availableTemplates[elementType] then return false end
    
    if customTemplates[elementType] and customTemplates[elementType][sourceResource or resource] then
        return customTemplates[elementType][sourceResource or resource]
    end
    return availableTemplates[elementType]

end

function __setUITemplate(elementType, elementTemplate)

    if not elementType or not elementTemplate or not availableElements[elementType] or not availableTemplates[elementType] then return false end

    if not customTemplates[elementType] then customTemplates[elementType] = {} end
    customTemplates[elementType][sourceResource or resource] = elementTemplate
    return true

end