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
    table = {
        insert = table.insert
    },
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

function fetchImports(recieveData)

    if not bundlerData then return false end

    if recieveData == true then
        return bundlerData
    else
        return [[
        for i, j in ipairs(exports.beautify_library:fetchImports(true)) do
            loadstring(j)()
        end
        ]]
    end

end


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

imports.addEventHandler("onClientResourceStart", resource, function(resourceSource)

    imports.fetchFileData = fetchFileData
    local resourceName = imports.getResourceName(resourceSource)
    local importedFiles = {
        utilities = fetchFileData("utilities/client.lua"),
        settings = fetchFileData("settings/client.lua"),
        handlers = {
            input = fetchFileData("handlers/element/input.lua"),
            bundler = ""
        }
    }

    importedFiles.utilities = importedFiles.utilities..[[
    cloneUIOutline = nil
    areUIParametersValid = nil
    ]]

    imports.string.gsub(importedFiles.utilities, "if CLIENT_ATTACHED_ELEMENT then return false end", "")
    importedFiles.settings = importedFiles.settings..[[
    UI_VALID_ALIGNMENT = nil
    UI_VALID_SCROLLERS = nil
    ]]

    importedFiles.handlers.input = importedFiles.handlers.input..[[
    CLIENT_HOVERED_ELEMENT = nil
    local imports = {
        addEventHandler = addEventHandler,
        resetKeyClickCache = resetKeyClickCache,
        resetScrollCache = resetScrollCache
    }
    imports.addEventHandler("onClientRender", root, function()
        CLIENT_MTA_RESTORED = false
        imports.resetKeyClickCache()
        imports.resetScrollCache()
    end, false, UI_PRIORITY_LEVEL.RENDER)]]

    importedFiles.handlers.bundler = [[
    local imports = {
        call = call,
        type = type,
        addEventHandler = addEventHandler,
        removeEventHandler = removeEventHandler,
        resource = getResourceFromName("]]..resourceName..[["),
        renderClass = {},
        functionClass = {}
    }
    imports.renderClass.__index = imports.renderClass
    function imports.renderClass:createRender(functionReference, elementReference, ...)
        if not functionReference or (imports.type(functionReference) ~= "function") then return false end
        if not elementReference then
            if beautify.render.NON_ELEMENT_RENDERS[functionReference] then return false end
            self = setmetatable({}, self) 
            self.functionReference = functionReference
            self.elementReference = false
            self.cbArguments = {...}
            self.renderFunction = function()
                self.functionReference(self.cbArguments)
            end
            beautify.render.NON_ELEMENT_RENDERS[functionReference] = self
            imports.addEventHandler("onClientRender", root, self.renderFunction, false, UI_PRIORITY_LEVEL.RENDER)
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
            self.cbArguments = {...}
            self.renderFunction = function()
                self.functionReference(self.elementReference, beautify.getUIPosition(self.elementReference), self.cbArguments)
            end
            beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] = self
            beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions = beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions + 1
        end
        return true 
    end
    function imports.renderClass:removeRender(functionReference, elementReference)
        if not functionReference or (imports.type(functionReference) ~= "function") then return false end
        if not elementReference then
            if not beautify.render.NON_ELEMENT_RENDERS[functionReference] then return false end
            imports.removeEventHandler("onClientRender", root, beautify.render.NON_ELEMENT_RENDERS[functionReference].renderFunction)
            beautify.render.NON_ELEMENT_RENDERS[functionReference] = nil
        else
            if not beautify.render.ELEMENT_RENDERS[elementReference] or not beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] then return false end
            imports.removeEventHandler("onClientRender", root, beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference].renderFunction)
            beautify.render.ELEMENT_RENDERS[elementReference].renderFunctions[functionReference] = nil
            beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions = beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions - 1
            if beautify.render.ELEMENT_RENDERS[elementReference].totalFunctions <= 0 then
                beautify.render.ELEMENT_RENDERS[elementReference] = nil
            end
        end
        return true
    end
    imports.addEventHandler("onClientUIPostViewRTRender", root, function()
        if beautify.render.ELEMENT_RENDERS[source] then
            for i, j in pairs(beautify.render.ELEMENT_RENDERS[source].renderFunctions) do
                j.renderFunction()
            end
        end
    end)
    function imports.functionClass:__index(functionName)
        self[functionName] = function(...)
            return imports.call(imports.resource, functionName, ...)
        end
        return self[functionName]
    end
    imports.functionInit = setmetatable({}, imports.functionClass)
    beautify = {
        render = {
            NON_ELEMENT_RENDERS = {}, ELEMENT_RENDERS = {},
            create = function(...)
                return imports.renderClass:createRender(...)
            end,
            remove = function(...)
                return imports.renderClass:removeRender(...)
            end
        }, ]]
    for i, j in imports.pairs(availableElements) do
        if i == "__ELEMENT_ESSENTIALS__" then
            for k, v in imports.ipairs(j) do
                importedFiles.handlers.bundler = importedFiles.handlers.bundler..v..[[ = imports.functionInit.]]..v..[[,]]
            end
        else
            if j.reference then
                local elementName = imports.string.upper(imports.string.sub(j.reference, 1, 1))..imports.string.sub(j.reference, 2)
                importedFiles.handlers.bundler = importedFiles.handlers.bundler..[[["]]..j.reference..[["] = {]]
                importedFiles.handlers.bundler = importedFiles.handlers.bundler..(imports.string.gsub(j.syntax.functionName, elementName, "", 1))..[[ = imports.functionInit.]]..j.syntax.functionName..[[,]]
                for k, v in imports.pairs(j.APIs) do
                    importedFiles.handlers.bundler = importedFiles.handlers.bundler..(imports.string.gsub(k, elementName, "", 1))..[[ = imports.functionInit.]]..k..[[,]]
                end
                importedFiles.handlers.bundler = importedFiles.handlers.bundler..[[},]]
            end
        end
    end
    importedFiles.handlers.bundler = importedFiles.handlers.bundler..[[}]]

    bundlerData = {}
    imports.table.insert(bundlerData, importedFiles.utilities)
    imports.table.insert(bundlerData, importedFiles.settings)
    imports.table.insert(bundlerData, importedFiles.handlers.input)
    imports.table.insert(bundlerData, importedFiles.handlers.bundler)

end)