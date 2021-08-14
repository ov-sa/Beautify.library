----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: bundler.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Bundler's Cache Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local bundlerData = false


-----------------------------------
--[[ Function: Fetches Imports ]]--
-----------------------------------

function __fetchImports()

    if not bundlerData then return false end

    return bundlerData

end


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function(resourceSource)

    local resourceName = resourceSource:getName()

    bundlerData = [[
    local BEAUTIFY_LIBRARY = {
        call = call,
        resource = getResourceFromName("]]..resourceName..[["),
        functionClass = {}
    }
    function BEAUTIFY_LIBRARY.functionClass:__index(functionName)
        self[functionName] = function(...)
            return BEAUTIFY_LIBRARY.call(BEAUTIFY_LIBRARY.resource, functionName, ...)
        end
        return self[functionName]
    end
    local BEAUTIFY_FUNC_INIT = setmetatable({}, BEAUTIFY_LIBRARY.functionClass)
    beautify = {]]

    for i, j in pairs(availableElements) do
        if i == "__ELEMENT_ESSENTIALS__" then
            for k, v in ipairs(j) do
                bundlerData = bundlerData..v..[[ = BEAUTIFY_FUNC_INIT.]]..v..[[,]]
            end
        else
            if j.reference then
                local elementName = j.reference:sub(1,1):upper()..j.reference:sub(2)
                bundlerData = bundlerData..[[["]]..j.reference..[["] = {]]
                bundlerData = bundlerData..(j.syntax.functionName:gsub(elementName, "", 1))..[[ = BEAUTIFY_FUNC_INIT.]]..j.syntax.functionName..[[,]]
                for k, v in pairs(j.APIs) do
                    bundlerData = bundlerData..(k:gsub(elementName, "", 1))..[[ = BEAUTIFY_FUNC_INIT.]]..k..[[,]]
                end
                bundlerData = bundlerData..[[},]]
            end
        end
    end
    bundlerData = bundlerData..[[}]]

end)