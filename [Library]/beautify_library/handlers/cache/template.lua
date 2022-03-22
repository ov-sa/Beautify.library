----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: template.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Template's Cache Handler ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    type = type,
    tonumber = tonumber,
    pairs = pairs,
    ipairs = ipairs,
    getResourceName = getResourceName,
    isElement = isElement,
    destroyElement = destroyElement,
    collectgarbage = collectgarbage,
    fileExists = fileExists,
    dxCreateFont = dxCreateFont,
    table = table,
    math = math,
    string = string
}


-------------------
--[[ Variables ]]--
-------------------

CLIENT_RESOURCE_TEMPLATE_RELOAD = {
    __cache = {
        loaded = true,
        loadStatus = false
    }
}
local createdResourceTemplates = {}


--------------------------------------------------
--[[ Function: Clears Resource's UI Templates ]]--
--------------------------------------------------

local function __clearResourceUITemplates(resetElementTypeAssets)

    if not sourceResource then return false end

    if resetElementTypeAssets then
        if createdResourceTemplates[resetElementTypeAssets] and createdResourceTemplates[resetElementTypeAssets][sourceResource] then
            for i, j in imports.pairs(createdResourceTemplates[resetElementTypeAssets][sourceResource].assets) do
                if j and imports.isElement(j) then
                    imports.destroyElement(j)
                end
            end
            createdResourceTemplates[resetElementTypeAssets][sourceResource].assets = nil
        end
    else
        for i, j in imports.pairs(createdResourceTemplates) do
            if j[sourceResource] then
                __clearResourceUITemplates(i)
            end
            j[sourceResource] = nil
        end
    end
    imports.collectgarbage()
    return true

end
function clearResourceUITemplates() return __clearResourceUITemplates() end


-----------------------------------------
--[[ Function: Creates UI's Template ]]--
-----------------------------------------

local function __createTemplate(elementType, defaultTemplate, customTemplate)

    if not elementType or not defaultTemplate or not customTemplate then return false end

    for i, j in imports.pairs(defaultTemplate) do
        if customTemplate[i] then
            local defaultDataType, currentDataType = imports.type(j), imports.type(customTemplate[i])
            if defaultDataType == "table" then
                if currentDataType == defaultDataType then
                    defaultTemplate[i] = __createTemplate(elementType, j, customTemplate[i])
                end
            else
                if i == "font" then
                    if currentDataType == "table" and (#customTemplate[i] >= 2) then
                        local resourceName = imports.getResourceName(sourceResource)
                        local fontPath = ":"..(customTemplate[i][3] or resourceName).."/"..customTemplate[i][1]
                        if imports.fileExists(fontPath) then
                            local fontScale = imports.tonumber(customTemplate[i][2]) or 0
                            if fontScale > 0 then
                                local createdFont = imports.dxCreateFont(fontPath, fontScale)
                                if createdFont then
                                    defaultTemplate[i] = createdFont
                                    imports.table.insert(createdResourceTemplates[elementType][sourceResource].assets, createdFont)
                                end
                            end
                        end
                    end
                else
                    if currentDataType == defaultDataType then
                        if imports.string.find(i, "Acceleration", 1) or imports.string.find(i, "Speed", 1) then
                            defaultTemplate[i] = imports.math.max(0, imports.math.min(1, customTemplate[i]))
                        else
                            defaultTemplate[i] = customTemplate[i]
                        end
                    end
                end
            end
        end
    end
    return defaultTemplate

end


--------------------------------------------------
--[[ Functions: Retrieves/Set's UI's Template ]]--
--------------------------------------------------

function __getUITemplate(elementType, elementSourceResource)

    if not elementType or not availableTemplates[elementType] then return false end
    
    if elementSourceResource then
        if createdResourceTemplates[elementType] and createdResourceTemplates[elementType][elementSourceResource] then
            return createdResourceTemplates[elementType][elementSourceResource].template
        end
    else
        if sourceResource and createdResourceTemplates[elementType] and createdResourceTemplates[elementType][sourceResource] then
            return createdResourceTemplates[elementType][sourceResource].template
        end
    end
    return availableTemplates[elementType]

end

function setUITemplate(elementType, elementTemplate)

    if not sourceResource or not elementType or not elementTemplate or not availableTemplates[elementType] or imports.type(elementTemplate) ~= "table" then return false end

    if not CLIENT_RESOURCE_TEMPLATE_RELOAD[sourceResource] then CLIENT_RESOURCE_TEMPLATE_RELOAD[sourceResource] = {} end
    if not createdResourceTemplates[elementType] then createdResourceTemplates[elementType] = {} end
    __clearResourceUITemplates(elementType)
    createdResourceTemplates[elementType][sourceResource] = {
        assets = {},
        template = false
    }
    createdResourceTemplates[elementType][sourceResource].template = __createTemplate(elementType, imports.table.clone(availableTemplates[elementType], true), elementTemplate)
    CLIENT_RESOURCE_TEMPLATE_RELOAD[sourceResource][elementType] = true
    CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loadStatus = "initialized"
    CLIENT_RESOURCE_TEMPLATE_RELOAD.__cache.loaded = false
    return true

end

function getUITemplate(...)

    local parameters = {...}
    return __getUITemplate(parameters[1])

end