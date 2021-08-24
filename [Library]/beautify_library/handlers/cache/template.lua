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

__reloadResourceTemplates = {
    __cache = {
        loaded = true,
        loadStatus = false
    }
}
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

function __getUITemplate(elementType, elementSourceResource)

    if not elementType or not availableTemplates[elementType] then return false end
    
    if elementSourceResource then
        if createdTemplates[elementType] and createdTemplates[elementType][elementSourceResource] then
            return createdTemplates[elementType][elementSourceResource]
        end
    else
        if sourceResource and createdTemplates[elementType] and createdTemplates[elementType][sourceResource] then
            return createdTemplates[elementType][sourceResource]
        end
    end
    return availableTemplates[elementType]

end

function __setUITemplate(elementType, elementTemplate)

    if not elementType or not elementTemplate or not availableTemplates[elementType] or not sourceResource then return false end

    if not __reloadResourceTemplates[sourceResource] then __reloadResourceTemplates[sourceResource] = {} end
    if not createdTemplates[elementType] then createdTemplates[elementType] = {} end
    createdTemplates[elementType][sourceResource] = elementTemplate
    __reloadResourceTemplates[sourceResource][elementType] = true
    __reloadResourceTemplates.__cache.loadStatus = "initialized"
    __reloadResourceTemplates.__cache.loaded = false
    return true

end