  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: utilities: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    type = type,
    tonumber = tonumber,
    pairs = pairs,
    ipairs = ipairs,
    getElementType = getElementType,
    dxSetBlendMode = dxSetBlendMode,
    string = {
        format = string.format
    }
}


---------------------------------------
--[[ Function: Fetches File's Data ]]--
---------------------------------------

function fetchFileData(filePath)

    if not filePath or not fileExists(filePath) then return false end
    local file = fileOpen(filePath, true)
    if not file then return false end

    local fileData = fileRead(file, fileGetSize(file))
    fileClose(file)
    return fileData

end


----------------------------------
--[[ Function: Blends DX I/Ps ]]--
----------------------------------

function dxSetBlendMode(blendMode)

    if blendMode then
        if blendMode == "blend" then
            return false
        end
    end
    return imports.dxSetBlendMode(blendMode)

end


------------------------------------------------------
--[[ Functions: Clones Table's/UI's Datas/Outline ]]--
------------------------------------------------------

function cloneTableDatas(recievedTable, isRecursiveMode)

    if not recievedTable or imports.type(recievedTable) ~= "table" then return false end

    local clonedTable = {}
    for i, j in imports.pairs(recievedTable) do
        if imports.type(j) == "table" and isRecursiveMode then
            clonedTable[i] = cloneTableDatas(j, true)
        else
            clonedTable[i] = j
        end
    end
    return clonedTable

end

function cloneUIOutline(elementType, nestedOutline)

    if not elementType or not availableElements[elementType] or not availableTemplates[elementType] then return false end

    local clonedOutline = {}
    if not nestedOutline then
        clonedOutline["__UI_CACHE__"] = {}
        clonedOutline["__UI_INPUT_FETCH_CACHE__"] = {}
    end
    for i, j in imports.pairs(nestedOutline or availableTemplates[elementType]) do
        if imports.type(j) == "table" then
            if j.isOutLine then
                clonedOutline[i] = cloneUIOutline(elementType, j)
                if UI_VALID_SCROLLERS[i] then
                    if UI_VALID_SCROLLERS[i].isHorizontal then
                        clonedOutline[i].isHorizontal = true
                    end
                    clonedOutline[i].currentPercent = 0
                    clonedOutline[i].finalPercent = 0
                    clonedOutline[i].currentThumbSize = 0
                    clonedOutline[i].finalThumbSize = 0
                elseif (i == "slideBar_Horizontal") or (i == "slideBar_Vertical") then
                    clonedOutline[i].currentPercent = 0
                    clonedOutline[i].finalPercent = 0
                end
            end
        end
    end
    return clonedOutline

end


---------------------------------
--[[ Function: Unpacks Color ]]--
---------------------------------

function unpackColor(color)

    if color and #color >= 4 then
        return color[1], color[2], color[3], color[4]
    end
    return false

end


------------------------------------------------------
--[[ Function: Retrieves Interpolation's Progress ]]--
------------------------------------------------------

function getInterpolationProgress(tickCount, delay)

    local endTime = tickCount + delay
    local elapsedTime = CLIENT_CURRENT_TICK - tickCount
    local duration = endTime - tickCount
    local progress = elapsedTime / duration
    return progress

end


--------------------------------------------------------
--[[ Function: Retrieves Cursor's Absolute Position ]]--
--------------------------------------------------------

function getAbsoluteCursorPosition()

    if not CLIENT_IS_CURSOR_SHOWING or not CLIENT_CURSOR_OFFSET then return false end

    return CLIENT_CURSOR_OFFSET[1]*CLIENT_MTA_RESOLUTION[1], CLIENT_CURSOR_OFFSET[2]*CLIENT_MTA_RESOLUTION[2]

end


----------------------------------------------
--[[ Functions: Verifies Mouse's Position ]]--
----------------------------------------------

function isMouseOnPosition(x, y, width, height)

    if CLIENT_ATTACHED_ELEMENT then return false end
    local cursor_offsetX, cursor_offsetY = getAbsoluteCursorPosition()
    if not cursor_offsetX or not cursor_offsetY then return false end

    return (cursor_offsetX >= x) and (cursor_offsetX <= (x + width)) and (cursor_offsetY >= y) and (cursor_offsetY <= (y + height))

end

function isMouseOnCircularPosition(x, y, radius)

    if CLIENT_ATTACHED_ELEMENT then return false end
    local cursor_offsetX, cursor_offsetY = getAbsoluteCursorPosition()
    if not cursor_offsetX or not cursor_offsetY then return false end

    return ((cursor_offsetX - x)^2) + ((cursor_offsetY - y)^2) <= (radius^2)

end


-----------------------------------
--[[ Function: Rounds A Number ]]--
-----------------------------------

function math.round(number, decimals)
    
    decimals = decimals or 0
    return imports.tonumber(imports.string.format(("%."..decimals.."f"), number))

end


--------------------------------------------
--[[ Function: Verifies UI's Parameters ]]--
--------------------------------------------

function areUIParametersValid(parameters, elementType, apiName)

    if not parameters or imports.type(parameters) ~= "table" or not elementType or not availableElements[elementType] or (apiName and not availableElements[elementType].APIs[apiName]) then return false end

    local areParametersValid, templateReferenceIndex = true, false
    local functionReference = (not apiName and availableElements[elementType].syntax) or availableElements[elementType].APIs[apiName]
    local functionName = (not apiName and availableElements[elementType].syntax.functionName) or apiName
    local functionParemeters, additionalParameters = functionReference.parameters, false
    for i, j in imports.ipairs(functionParemeters) do
        if (parameters[i] == nil) or (imports.type(parameters[i]) ~= (((j.type == "float") and "number") or j.type)) then
            areParametersValid = false
            break
        else
            if j.type == "string" then
                if not apiName and availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"] and j.isTemplateType then
                    if not availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"][(parameters[i])] then
                        areParametersValid = false
                        break
                    else
                        templateReferenceIndex = i
                        additionalParameters = availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"][(parameters[i])]
                    end                    
                end
            elseif j.type == "userdata" then
                local elementType = imports.getElementType(parameters[i])
                if elementType ~= j.userDataType then
                    areParametersValid = false
                    break
                end
            end
        end
    end
    if additionalParameters then
        if areParametersValid then
            for i, j in imports.ipairs(additionalParameters) do
                local parameterIndex = #functionParemeters + i
                if not parameters[parameterIndex] or (imports.type(parameters[parameterIndex]) ~= (((j.type == "float") and "number") or j.type)) then
                    areParametersValid = false
                    break
                end
            end
        else
            additionalParameters = false
        end
    end
    if not apiName and availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"] and not templateReferenceIndex then areParametersValid = false end

    if not areParametersValid then
        local syntaxMessage = functionName.."("
        for i = 1, (templateReferenceIndex or #functionParemeters), 1 do
            local parameterData = functionParemeters[i]
            syntaxMessage = syntaxMessage..parameterData.name.." : "..(((parameterData.type == "userdata") and "element") or parameterData.type)
            if (i ~= #functionParemeters) or (additionalParameters and (#additionalParameters ~= 0)) then
                syntaxMessage = syntaxMessage..", "
            end
        end
        if additionalParameters then
            for i, j in imports.ipairs(additionalParameters) do
                syntaxMessage = syntaxMessage..j.name.." : "..(((j.type == "userdata") and "element") or j.type)
                if i ~= #additionalParameters then
                    syntaxMessage = syntaxMessage..", "
                end
            end
        end
        syntaxMessage = syntaxMessage..")"
        outputUILog(syntaxMessage, "error")
        return false
    end
    return true, templateReferenceIndex

end