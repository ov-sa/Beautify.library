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
        renderClass = {},
        functionClass = {}
    }
    BEAUTIFY_LIBRARY.renderClass.__index = BEAUTIFY_LIBRARY.renderClass
    function BEAUTIFY_LIBRARY.renderClass:createRender(functionReference, elementReference)
        if not functionReference or (BEAUTIFY_LIBRARY.type(functionReference) ~= "function") then return false end
        if not elementReference then
            BEAUTIFY_LIBRARY.addEventHandler("onClientRender", root, functionReference, false, "]]..UI_PRIORITY_LEVEL.RENDER..[[")
        else
            if not beautify.isUIValid(elementReference) then return false end
            if not beautify.render.ELEMENT_RENDERS[elementReference] then
                beautify.render.ELEMENT_RENDERS[elementReference] = {
                    totalFunctions = 0,
                    renderFunctions = {}
                }
            end
            if beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] then return false end
            self = setmetatable({}, self) 
            self.functionReference = functionReference
            self.elementReference = elementReference
            self.renderFunction = function()
                if beautify.isUIVisible(self.elementReference) and beautify.isUIBeingForceRendered(self.elementReference) then
                    self.functionReference(self.elementReference, beautify.getUIPosition(self.elementReference))
                end
            end
            beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] = self
            beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions = beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions + 1
            BEAUTIFY_LIBRARY.addEventHandler("onClientRender", root, self.renderFunction, false, "]]..UI_PRIORITY_LEVEL.RENDER..[[")
        end
        return true 
    end
    function BEAUTIFY_LIBRARY.renderClass:removeRender(functionReference, elementReference)
        if not functionReference or (BEAUTIFY_LIBRARY.type(functionReference) ~= "function") then return false end
        if not elementReference then
            BEAUTIFY_LIBRARY.removeEventHandler("onClientRender", root, functionReference)
        else
            if not beautify.render.ELEMENT_RENDERS[elementReference] or not beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] then return false end
            BEAUTIFY_LIBRARY.removeEventHandler("onClientRender", root, beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference].renderFunction)
            beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] = nil
            beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions = beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions - 1
            if beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions <= 0 then
                beautify.render.ELEMENT_RENDERS[elementReference] = nil
            end
        end
        return true
    end
    function BEAUTIFY_LIBRARY.functionClass:__index(functionName)
        self[functionName] = function(...)
            return BEAUTIFY_LIBRARY.call(BEAUTIFY_LIBRARY.resource, functionName, ...)
        end
        return self[functionName]
    end
    BEAUTIFY_LIBRARY.functionInit = setmetatable({}, BEAUTIFY_LIBRARY.functionClass)
    beautify = {
        render = {
            ELEMENT_RENDERS = {},
            create = function(...)
                return BEAUTIFY_LIBRARY.renderClass:createRender(...)
            end,
            remove = function(...)
                return BEAUTIFY_LIBRARY.renderClass:removeRender(...)
            end
        }, ]]

    for i, j in imports.pairs(availableElements) do
        if i == "__ELEMENT_ESSENTIALS__" then
            for k, v in imports.ipairs(j) do
                bundlerData = bundlerData..v..[[ = BEAUTIFY_LIBRARY.functionInit.]]..v..[[,]]
            end
        else
            if j.reference then
                local elementName = imports.string.upper(imports.string.sub(j.reference, 1, 1))..imports.string.sub(j.reference, 2)
                bundlerData = bundlerData..[[["]]..j.reference..[["] = {]]
                bundlerData = bundlerData..(imports.string.gsub(j.syntax.functionName, elementName, "", 1))..[[ = BEAUTIFY_LIBRARY.functionInit.]]..j.syntax.functionName..[[,]]
                for k, v in imports.pairs(j.APIs) do
                    bundlerData = bundlerData..(imports.string.gsub(k, elementName, "", 1))..[[ = BEAUTIFY_LIBRARY.functionInit.]]..k..[[,]]
                end
                bundlerData = bundlerData..[[},]]
            end
        end
    end
    bundlerData = bundlerData..[[}]]

end)