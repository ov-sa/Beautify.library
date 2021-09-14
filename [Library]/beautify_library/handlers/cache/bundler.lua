----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: bundler.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Bundler's Cache Handler ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    pairs = pairs,
    ipairs = ipairs,
    getResourceName = getResourceName,
    addEventHandler = addEventHandler,
    string = {
        sub = string.sub,
        gsub = string.gsub,
        upper = string.upper
    }
}


-------------------
--[[ Variables ]]--
-------------------

local bundlerData = false


-----------------------------------
--[[ Function: Fetches Imports ]]--
-----------------------------------

function fetchImports()

    if not bundlerData then return false end

    return bundlerData

end


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

imports.addEventHandler("onClientResourceStart", resource, function(resourceSource)

    local resourceName = imports.getResourceName(resourceSource)

    bundlerData = [[
    local BEAUTIFY_LIBRARY = {
        call = call,
        type = type,
        addEventHandler = addEventHandler,
        removeEventHandler = removeEventHandler,
        resource = getResourceFromName("]]..resourceName..[["),
        functionClass = {}
    }
    function BEAUTIFY_LIBRARY.functionClass:__index(functionName)
        self[functionName] = function(...)
            return BEAUTIFY_LIBRARY.call(BEAUTIFY_LIBRARY.resource, functionName, ...)
        end
        return self[functionName]
    end
    local BEAUTIFY_FUNCTION_INIT = setmetatable({}, BEAUTIFY_LIBRARY.functionClass)
    beautify = {
        render = {
            create = function(functionReference, elementReference)
                if not functionReference or (BEAUTIFY_LIBRARY.type(functionReference) ~= "function") then return false end
                if not elementReference then
                    BEAUTIFY_LIBRARY.addEventHandler("onClientRender", root, functionReference, false, "]]..UI_PRIORITY_LEVEL.RENDER..[[")
                else
                    if not beautify.isUIValid(elementReference) then return false end
                end
            end,
            remove = function(functionReference, elementReference)
                if not functionReference or (BEAUTIFY_LIBRARY.type(functionReference) ~= "function") then return false end
                if not elementReference then
                    BEAUTIFY_LIBRARY.removeEventHandler("onClientRender", root, functionReference)
                else
                    if not beautify.isUIValid(elementReference) then return false end
                end
            end
        }, ]]

    for i, j in imports.pairs(availableElements) do
        if i == "__ELEMENT_ESSENTIALS__" then
            for k, v in imports.ipairs(j) do
                bundlerData = bundlerData..v..[[ = BEAUTIFY_FUNCTION_INIT.]]..v..[[,]]
            end
        else
            if j.reference then
                local elementName = imports.string.upper(imports.string.sub(j.reference, 1, 1))..imports.string.sub(j.reference, 2)
                bundlerData = bundlerData..[[["]]..j.reference..[["] = {]]
                bundlerData = bundlerData..(imports.string.gsub(j.syntax.functionName, elementName, "", 1))..[[ = BEAUTIFY_FUNCTION_INIT.]]..j.syntax.functionName..[[,]]
                for k, v in imports.pairs(j.APIs) do
                    bundlerData = bundlerData..(imports.string.gsub(k, elementName, "", 1))..[[ = BEAUTIFY_FUNCTION_INIT.]]..k..[[,]]
                end
                bundlerData = bundlerData..[[},]]
            end
        end
    end
    bundlerData = bundlerData..[[}]]

end)