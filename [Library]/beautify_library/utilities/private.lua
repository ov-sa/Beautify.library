local imports = {
    type = type,
    tostring = tostring,
    tonumber = tonumber,
    pairs = pairs,
    ipairs = ipairs,
    fileExists = fileExists,
    fileOpen = fileOpen,
    fileRead = fileRead,
    fileGetSize = fileGetSize,
    fileClose = fileClose,
    getElementType = getElementType,
    dxSetBlendMode = dxSetBlendMode,
    string = string
}

string = utf8
for i, j in imports.pairs(imports.string) do
    if not string[i] then
        string[i] = j
    end
end
imports.string = string

function table.clone(recievedTable, isRecursiveMode)

    if not recievedTable or imports.type(recievedTable) ~= "table" then return false end

    local clonedTable = {}
    for i, j in imports.pairs(recievedTable) do
        if imports.type(j) == "table" and isRecursiveMode then
            clonedTable[i] = table.clone(j, true)
        else
            clonedTable[i] = j
        end
    end
    return clonedTable

end


---------------------------------------
--[[ Function: Fetches File's Data ]]--
---------------------------------------

function fetchFileData(filePath)

    if not filePath or not imports.fileExists(filePath) then return false end
    local file = imports.fileOpen(filePath, true)
    if not file then return false end

    local fileData = imports.fileRead(file, imports.fileGetSize(file))
    imports.fileClose(file)
    return fileData

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