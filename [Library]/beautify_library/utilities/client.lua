  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: utilities: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------

-------------------
--[[ Variables ]]--
-------------------

sX, sY = GuiElement.getScreenSize()


-----------------------------------
--[[ Function: Rounds A Number ]]--
-----------------------------------

function math.round(number, decimals)
    
    decimals = decimals or 0
    return tonumber(("%."..decimals.."f"):format(number))

end


------------------------------------------------------
--[[ Functions: Clones Table's/UI's Datas/Outline ]]--
------------------------------------------------------

function cloneTableDatas(recievedTable, isRecursiveMode)

    if not recievedTable or type(recievedTable) ~= "table" then return false end

    local clonedTable = {}
    for i, j in pairs(recievedTable) do
        if type(j) == "table" and isRecursiveMode then
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
    for i, j in pairs(nestedOutline or availableTemplates[elementType]) do
        if type(j) == "table" then
            if j.isOutLine then
                clonedOutline[i] = cloneUIOutline(elementType, j)
                if (i == "scrollBar_Horizontal") or (i == "scrollBar_Vertical") then
                    if i == "scrollBar_Horizontal" then
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

    if color and color[1] and color[2] and color[3] and color[4] then
        return color[1], color[2], color[3], color[4]
    end
    return false

end


------------------------------------------------------
--[[ Function: Retrieves Interpolation's Progress ]]--
------------------------------------------------------

function getInterpolationProgress(tickCount, delay)

    if not tickCount or not delay then return false end

    local now = getTickCount()
    local endTime = tickCount + delay
    local elapsedTime = now - tickCount
    local duration = endTime - tickCount
    local progress = elapsedTime / duration
    return progress

end


--------------------------------------------------------
--[[ Function: Retrieves Cursor's Absolute Position ]]--
--------------------------------------------------------

function getAbsoluteCursorPosition()

    if not isCursorShowing() then return false end

    local cX, cY = getCursorPosition()
    return cX*sX, cY*sY

end


---------------------------------------------
--[[ Function: Verifies Mouse's Position ]]--
---------------------------------------------

function isMouseOnPosition(x, y, w, h)

    x = tonumber(x); y = tonumber(y); w = tonumber(w); h = tonumber(h);
    if not isCursorShowing() then return false end
    if not x or not y or not w or not h then return false end

    local cX, cY = getAbsoluteCursorPosition()
    if (cX >= x and cX <= x + w and cY >= y and cY <= y + h) then
        return true
    end
    return false

end


--------------------------------------------
--[[ Function: Verifies UI's Parameters ]]--
--------------------------------------------

function areUIParametersValid(parameters, elementType, apiName)

    if not parameters or type(parameters) ~= "table" or not elementType or not availableElements[elementType] or (apiName and not availableElements[elementType].APIs[apiName]) then return false end

    local areParametersValid, templateReferenceIndex = true, false
    local functionReference = (not apiName and availableElements[elementType].syntax) or availableElements[elementType].APIs[apiName]
    local functionName = (not apiName and availableElements[elementType].syntax.functionName) or apiName
    local functionParemeters, additionParameters = functionReference.parameters, false
    for i, j in ipairs(functionParemeters) do
        if not parameters[i] or (type(parameters[i]) ~= (((j.type == "float") and "number") or j.type)) then
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
                        additionParameters = availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"][(parameters[i])]
                    end                    
                end
            elseif j.type == "userdata" then
                local elementType = parameters[i]:getType()
                if elementType ~= j.userDataType then
                    areParametersValid = false
                    break
                end
            end
        end
    end
    if additionParameters then
        if areParametersValid then
            for i, j in ipairs(additionParameters) do
                local parameterIndex = #functionParemeters + i
                if not parameters[parameterIndex] or (type(parameters[parameterIndex]) ~= (((j.type == "float") and "number") or j.type)) then
                    areParametersValid = false
                    break
                end
            end
        else
            additionParameters = false
        end
    end
    if not apiName and availableElements[elementType].syntax.parameters["TEMPLATE_PARAMETERS"] and not templateReferenceIndex then areParametersValid = false end

    if not areParametersValid then
        local syntaxMessage = functionName.."("
        for i = 1, (templateReferenceIndex or #functionParemeters), 1 do
            local parameterData = functionParemeters[i]
            syntaxMessage = syntaxMessage..parameterData.name.." : "..(((parameterData.type == "userdata") and "element") or parameterData.type)
            if (i ~= #functionParemeters) or (additionParameters and (#additionParameters ~= 0)) then
                syntaxMessage = syntaxMessage..", "
            end
        end
        if additionParameters then
            for i, j in ipairs(additionParameters) do
                syntaxMessage = syntaxMessage..j.name.." : "..(((j.type == "userdata") and "element") or j.type)
                if i ~= #additionParameters then
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


----------------------------------------
--[[ Event: On Client Resource Stop ]]--
----------------------------------------

local isLibraryResourceStopping = false
addEventHandler("onClientResourceStop", root, function()

    if source == resource then
        isLibraryResourceStopping = true
        collectgarbage()
    else
        __clearResourceUIElements(source)
        clearResourceUITemplates(source)
    end

end)


------------------------------------------
--[[ Event: On Client Element Destroy ]]--
------------------------------------------

addEventHandler("onClientElementDestroy", resourceRoot, function()

    if not isLibraryResourceStopping then
        destroyElement(source)
    end

end)