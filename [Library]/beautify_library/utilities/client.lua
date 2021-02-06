  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: utilities: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------


--------------------------------------------
--[[ Function: Verifies UI's Parameters ]]--
--------------------------------------------

function isUIParametersValid(paremeters, elementType)

    if not paremeters or type(paremeters) ~= "table" or not elementType or not availableElements[elementType] then return false end

    local areParametersValid = true
    for i, j in ipairs(availableElements[elementType].__syntax.parameters) do
        if not paremeters[i] or (type(paremeters[i]) ~= (((j.type == "float") and "number") or j.type)) then
            areParametersValid = false
            break
        end
    end
    if not areParametersValid then
        local syntaxMessage = availableElements[elementType].__syntax.functionName.."("
        for i, j in ipairs(availableElements[elementType].__syntax.parameters) do
            syntaxMessage = syntaxMessage..j.name.." : "..j.type
            if i ~= #availableElements[elementType].__syntax.parameters then
                syntaxMessage = syntaxMessage..", "
            end
        end
        syntaxMessage = syntaxMessage..")"
        outputUILog(syntaxMessage, "error")
        return false
    end
    return true

end


---------------------------------------------
--[[ Function: Retrieves Colors From Int ]]--
---------------------------------------------

function fromColor(color)

    color = tonumber(color)
	if color then
        local red = bitExtract(color, 16, 8)
        local green = bitExtract(color, 8, 8)
		local blue = bitExtract(color, 0, 8)
		local alpha = bitExtract(color, 24, 8)
		return {red, green, blue, alpha}
	end
    return false

end


----------------------------------------
--[[ Event: On Client Resource Stop ]]--
----------------------------------------

local isLibraryResourceStopping = false
addEventHandler("onClientResourceStop", root, function()

    if source == resource then
        isLibraryResourceStopping = true
    else
        --TODO: CLEAR RESOURCE'S GUIs
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