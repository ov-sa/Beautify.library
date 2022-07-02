  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: utilities: client.lua
     Server: -
     Author: vStudio
     Developer: -
     DOC: 01/02/2021
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

angle = {}
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


-----------------------------------
--[[ Function: Rounds A Number ]]--
-----------------------------------

function math.round(number, decimals)
    
    decimals = decimals or 0
    return imports.tonumber(imports.string.format(("%."..decimals.."f"), number))

end


------------------------------------------------
--[[ Function: Appends Space b/w Characters ]]--
------------------------------------------------

function string.spaceChars(baseString, appender)

    if baseString then
        return imports.string.sub(imports.string.gsub(baseString, ".", (appender or " ").."%0"), 2)
    end
    return false

end


---------------------------------------------------
--[[ Function: Retrieves Shortest Target Angle ]]--
---------------------------------------------------

function angle.shortTarget(startAngle, targetAngle)

    local currentAngleLength = false
    if startAngle < targetAngle then
        currentAngleLength = targetAngle - startAngle
    else
        currentAngleLength = startAngle - targetAngle
    end
    local reverseAngleLength = 360 - currentAngleLength
    if reverseAngleLength < currentAngleLength then
        targetAngle = -reverseAngleLength
    end
    return targetAngle

end


----------------------------------------------
--[[ Functions: Clones Table/UI's-Outline ]]--
----------------------------------------------

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
--[[ Function: Parses String ]]--
---------------------------------

function string.parse(rawString)

    if not rawString then return false end

    if imports.tostring(rawString) == "nil" then
        rawString = nil
    elseif imports.tostring(rawString) == "false" then
        rawString = false
    elseif imports.tostring(rawString) == "true" then
        rawString = true
    end
    return imports.tonumber(rawString) or rawString

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