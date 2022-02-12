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
        utilities = imports.string.gsub(fetchFileData("utilities/client.lua")..[[
            cloneUIOutline = nil
            areUIParametersValid = nil
        ]], "if CLIENT_ATTACHED_ELEMENT then return false end", ""),
        settings = fetchFileData("settings/client.lua")..[[
            UI_VALID_ALIGNMENT = nil
            UI_VALID_SCROLLERS = nil
        ]],
        handlers = {
            input = fetchFileData("handlers/element/input.lua")..[[
                CLIENT_HOVERED_ELEMENT = nil
                imports.tonumber = tonumber
                imports.gettok = gettok
                imports.addEventHandler("onClientRender", root, function()
                    if CLIENT_MTA_MINIMIZED then return false end
                    CLIENT_MTA_RESTORED = false
                    resetKeyClickCache()
                    resetScrollCache()
                end, false, imports.gettok(UI_PRIORITY_LEVEL.INPUT, 1, "-").."-"..(imports.tonumber(imports.gettok(UI_PRIORITY_LEVEL.INPUT, 2, "-")) + 1))
            ]],
            bundler = ""
        }
    }

    importedFiles.handlers.bundler = [[
    local imports = {
        call = call,
        type = type,
        pairs = pairs,
        addEventHandler = addEventHandler,
        removeEventHandler = removeEventHandler,
        getResourceRootElement = getResourceRootElement,
        resource = getResourceFromName("]]..resourceName..[["),
        renderClass = {
            renderTypes = {
                render = "render",
                input = "input",
                types = {
                    ["input"] = {},
                    ["render"] = {eventName = "onClientUIPostViewRTRender"},
                    ["preRender"] = {eventName = "onClientUIPreRender"},
                    ["preViewRTRender"] = {eventName = "onClientUIPreViewRTRender"}
                }
            }
        },
        functionClass = {}
    }
    imports.renderClass.__index = imports.renderClass
    function imports.renderClass:createRender(functionReference, renderData, ...)
        if not functionReference or (imports.type(functionReference) ~= "function") then return false end
        renderData = renderData or {}
        if not renderData.elementReference then
            if not beautify.render.NON_ELEMENT_RENDERS[functionReference] then
                beautify.render.NON_ELEMENT_RENDERS[functionReference] = {
                    totalFunctions = 0
                }
            end
            local renderType = self.renderTypes.render
            if renderData.renderType == self.renderTypes.input then
                renderType = (self.renderTypes.types[(renderData.renderType)] and renderData.renderType) or renderType
            end
            if beautify.render.NON_ELEMENT_RENDERS[functionReference][renderType] then return false end
            self = setmetatable({}, self) 
            self.functionReference = functionReference
            self.renderData = {
                renderType = renderType
            }
            self.cbArguments = {...}
            self.renderFunction = function()
                self.functionReference(self.renderData, self.cbArguments)
            end
            beautify.render.NON_ELEMENT_RENDERS[functionReference][renderType] = self
            beautify.render.NON_ELEMENT_RENDERS[functionReference].totalFunctions = beautify.render.NON_ELEMENT_RENDERS[functionReference].totalFunctions + 1
            imports.addEventHandler("onClientRender", root, self.renderFunction, false, ((renderType == self.renderTypes.input) and UI_PRIORITY_LEVEL.INPUT) or UI_PRIORITY_LEVEL.RENDER)
        else
            if not beautify.isUIValid(renderData.elementReference) then return false end
            if not beautify.render.ELEMENT_RENDERS[(renderData.elementReference)] then
                beautify.render.ELEMENT_RENDERS[(renderData.elementReference)] = {
                    totalFunctions = 0,
                    renderFunctions = {}
                }
            end
            if not beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference] then
                beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference] = {
                    totalFunctions = 0
                }
                beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].totalFunctions = beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].totalFunctions + 1
            end
            local renderType = self.renderTypes.render
            if renderData.renderType then
                renderType = (self.renderTypes.types[(renderData.renderType)] and renderData.renderType) or renderType
            end
            if beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference][renderType] then return false end
            self = setmetatable({}, self) 
            self.functionReference = functionReference
            self.renderData = {
                elementReference = renderData.elementReference,
                renderType = renderType
            }
            self.cbArguments = {...}
            self.renderFunction = function()
                self.renderData.elementPosition = {beautify.getUIPosition(self.elementReference)}
                self.functionReference(self.renderData, self.cbArguments)
            end
            beautify.render.ELEMENT_RENDERS[(self.renderData.elementReference)].renderFunctions[functionReference][renderType] = self
            beautify.render.ELEMENT_RENDERS[(self.renderData.elementReference)].renderFunctions[functionReference].totalFunctions = beautify.render.ELEMENT_RENDERS[(self.renderData.elementReference)].renderFunctions[functionReference].totalFunctions + 1
            imports.addEventHandler(self.renderTypes.types[(self.renderData.renderType)].eventName, self.renderData.elementReference, self.renderFunction)
        end
        return true 
    end
    function imports.renderClass:removeRender(functionReference, renderData)
        if not functionReference or (imports.type(functionReference) ~= "function") then return false end
        renderData = renderData or {}
        if not elementReference then
            if not beautify.render.NON_ELEMENT_RENDERS[functionReference] then return false end
            local renderType = self.renderTypes.render
            if renderData.renderType == self.renderTypes.input then
                renderType = (self.renderTypes.types[(renderData.renderType)] and renderData.renderType) or renderType
            end
            if not beautify.render.NON_ELEMENT_RENDERS[functionReference][renderType] then return false end
            imports.removeEventHandler("onClientRender", root, beautify.render.NON_ELEMENT_RENDERS[functionReference][renderType].renderFunction)
            beautify.render.NON_ELEMENT_RENDERS[functionReference][renderType] = nil
            beautify.render.NON_ELEMENT_RENDERS[functionReference].totalFunctions = beautify.render.NON_ELEMENT_RENDERS[functionReference].totalFunctions - 1
            if beautify.render.NON_ELEMENT_RENDERS[functionReference].totalFunctions <= 0 then
                beautify.render.NON_ELEMENT_RENDERS[functionReference] = nil
            end
        else
            if not beautify.render.ELEMENT_RENDERS[(renderData.elementReference)] or not beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference] then return false end
            local renderType = self.renderTypes.render
            if renderData.renderType then
                renderType = (self.renderTypes.types[(renderData.renderType)] and renderData.renderType) or renderType
            end
            local selfReference = beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference][renderType]
            if not selfReference then return false end
            imports.removeEventHandler(self.renderTypes.types[(selfReference.renderData.renderType)].eventName, selfReference.renderData.elementReference, selfReference.renderFunction)
            beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference][renderType] = nil
            beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference].totalFunctions = beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference].totalFunctions - 1
            if beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference].totalFunctions <= 0 then
                beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].renderFunctions[functionReference] = nil
                beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].totalFunctions = beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].totalFunctions - 1
                if beautify.render.ELEMENT_RENDERS[(renderData.elementReference)].totalFunctions <= 0 then
                    beautify.render.ELEMENT_RENDERS[(renderData.elementReference)] = nil
                end
            end
        end
        return true
    end
    imports.addEventHandler("onClientElementDestroy", imports.getResourceRootElement(imports.resource), function()
        if not beautify.render.ELEMENT_RENDERS[source] then return false end
        for i, j in imports.pairs(beautify.render.ELEMENT_RENDERS[source].renderFunctions) do
            for k, v in imports.pairs(j) do
                if (k ~= "totalFunctions") then
                    imports.renderClass:removeRender(i, v.renderData)
                end
            end
        end
        beautify.render.ELEMENT_RENDERS[source] = nil
    end)
    function imports.functionClass:__index(functionName)
        self[functionName] = function(...)
            return imports.call(imports.resource, functionName, ...)
        end
        return self[functionName]
    end
    imports.functionInit = setmetatable({}, imports.functionClass)
    
    beautify = {
        native = {
            createFont = dxCreateFont,
            convertPixels = dxConvertPixels,
            createFont = dxCreateFont,
            createRenderTarget = dxCreateRenderTarget,
            createScreenSource = dxCreateScreenSource,
            createShader = dxCreateShader,
            createTexture = dxCreateTexture,
            drawCircle = dxDrawCircle,
            drawImage = dxDrawImage,
            drawImageSection = dxDrawImageSection,
            drawLine = dxDrawLine,
            drawLine3D = dxDrawLine3D,
            drawMaterialLine3D = dxDrawMaterialLine3D,
            drawMaterialPrimitive = dxDrawMaterialPrimitive,
            drawMaterialPrimitive3D = dxDrawMaterialPrimitive3D,
            drawMaterialSectionLine3D = dxDrawMaterialSectionLine3D,
            drawPrimitive = dxDrawPrimitive,
            drawPrimitive3D = dxDrawPrimitive3D,
            drawRectangle = dxDrawRectangle,
            drawText = dxDrawText,
            drawWiredSphere = dxDrawWiredSphere,
            getFontHeight = dxGetFontHeight,
            getMaterialSize = dxGetMaterialSize,
            getPixelColor = dxGetPixelColor,
            getPixelsSize = dxGetPixelsSize,
            getPixelsFormat = dxGetPixelsFormat,
            getStatus = dxGetStatus,
            getTextSize = dxGetTextSize,
            getTextWidth = dxGetTextWidth,
            getTexturePixels = dxGetTexturePixels,
            isAspectRatioAdjustmentEnabled = dxIsAspectRatioAdjustmentEnabled,
            setAspectRatioAdjustmentEnabled = dxSetAspectRatioAdjustmentEnabled,
            setPixelColor = dxSetPixelColor,
            setRenderTarget = dxSetRenderTarget,
            setShaderValue = dxSetShaderValue,
            setShaderTessellation = dxSetShaderTessellation,
            setShaderTransform = dxSetShaderTransform,
            setTextureEdge = dxSetTextureEdge,
            setTexturePixels = dxSetTexturePixels,
            updateScreenSource = dxUpdateScreenSource
        },
        assets = imports.call(imports.resource, "fetchAssets"),
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
    importedFiles.handlers.bundler = importedFiles.handlers.bundler..[[ 
    }]]

    bundlerData = {}
    imports.table.insert(bundlerData, importedFiles.utilities)
    imports.table.insert(bundlerData, importedFiles.settings)
    imports.table.insert(bundlerData, importedFiles.handlers.input)
    imports.table.insert(bundlerData, importedFiles.handlers.bundler)

end)