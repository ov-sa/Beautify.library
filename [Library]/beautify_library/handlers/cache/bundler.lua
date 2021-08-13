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
        if j.reference then
            bundlerData = bundlerData..[[["]]..j.reference..[["] = {]]
            bundlerData = bundlerData..j.syntax.functionName..[[ = BEAUTIFY_FUNC_INIT.]]..j.syntax.functionName..[[,]]
            for k, v in pairs(j.APIs) do
                bundlerData = bundlerData..k..[[ = BEAUTIFY_FUNC_INIT.]]..k..[[,]]
            end
            bundlerData = bundlerData..[[},]]
        end
    end
    bundlerData = bundlerData..[[}]]

end)