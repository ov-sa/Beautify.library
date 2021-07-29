  
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
    for i, j in pairs(nestedOutline or availableTemplates[elementType]) do
        if type(j) == "table" then
            if j.isOutLine then
                clonedOutline[i] = cloneUIOutline(elementType, j)
            end
        end
    end
    return clonedOutline

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

function areUIParametersValid(paremeters, elementType, apiName)

    if not paremeters or type(paremeters) ~= "table" or not elementType or not availableElements[elementType] or not availableTemplates[elementType or (apiName and not availableElements[elementType].apis[apiName]) then return false end

    local areParametersValid = true
    local functionReference = (not apiName and availableElements[elementType].syntax) or availableElements[elementType].apis[apiName]
    local functionName = (not apiName and availableElements[elementType].syntax.functionName) or apiName
    local functionParemers = functionReference.parameters
    local isSubTemplateOriented = false
    for i, j in ipairs(functionParemers) do
        if not paremeters[i] or (type(paremeters[i]) ~= (((j.type == "float") and "number") or j.type)) then
            areParametersValid = false
            break
        else
            if j.type == "userdata" then
                local elementType = paremeters[i]:getType()
                if elementType ~= j.userDataType then
                    areParametersValid = false
                    break
                end
            end
        end
        if j.isTemplateType then
            isSubTemplateOriented = i
            if not availableTemplates[elementType][(parameters[i])] then
                areParametersValid = false
                break
            end
            break
        end
    end
    if not areParametersValid then
        local syntaxMessage = functionName.."("
        for i, j in ipairs(functionParemers) do
            syntaxMessage = syntaxMessage..j.name.." : "..(((j.type == "userdata") and "element") or j.type)
            if i ~= #functionParemers then
                syntaxMessage = syntaxMessage..", "
            end
        end
        syntaxMessage = syntaxMessage..")"
        outputUILog(syntaxMessage, "error")
        return false
    end
    return true

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
        for i, j in pairs(createdElements) do
            if i and isElement(i) and j and j.sourceResource and j.sourceResource == source then
                i:destroy()
            end
        end
        clearResourceUITemplates(sourceResource)
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