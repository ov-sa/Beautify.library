----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: overlay: renderer.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Overlay's Renderer ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local currentOverlay = false


-----------------------------------
--[[ Functions: Custom DX APIs ]]--
-----------------------------------

local _dxDrawImage = dxDrawImage
function dxDrawImage(...)

    local parameters = {...}
    local paramColorIndex = 9
    local isOverlayEnabled = parameters[1] == true
    if #parameters > 0 then
        table.remove(parameters, 1)
    end

    if not isOverlayEnabled or not currentOverlay or not availableOverlays[currentOverlay] or not parameters[paramColorIndex] then
        _dxDrawImage(unpack(parameters))
    else
        if isOverlayEnabled then
            local prevColor = fromColor(parameters[paramColorIndex])
            parameters[paramColorIndex] = tocolor(availableOverlays[currentOverlay][1], availableOverlays[currentOverlay][2], availableOverlays[currentOverlay][3], prevColor[4])
            _dxDrawImage(unpack(parameters))
        end
    end

end

local _dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle(...)

    local parameters = {...}
    local paramColorIndex = 5
    local isOverlayEnabled = parameters[1] == true
    if #parameters > 0 then
        table.remove(parameters, 1)
    end

    if not isOverlayEnabled or not currentOverlay or not availableOverlays[currentOverlay] or not parameters[paramColorIndex] then
        _dxDrawRectangle(unpack(parameters))
    else
        if isOverlayEnabled then
            local prevColor = fromColor(parameters[paramColorIndex])
            parameters[paramColorIndex] = tocolor(availableOverlays[currentOverlay][1], availableOverlays[currentOverlay][2], availableOverlays[currentOverlay][3], prevColor[4])
            _dxDrawRectangle(unpack(parameters))
        end
    end

end

local _dxDrawText = dxDrawText
function dxDrawText(...)

    local parameters = {...}
    local paramColorIndex = 6
    local isOverlayEnabled = parameters[1] == true
    if #parameters > 0 then
        table.remove(parameters, 1)
    end

    if not isOverlayEnabled or not currentOverlay or not availableOverlays[currentOverlay] or not parameters[paramColorIndex] then
        _dxDrawText(unpack(parameters))
    else
        if isOverlayEnabled then
            local prevColor = fromColor(parameters[paramColorIndex])
            parameters[paramColorIndex] = tocolor(availableOverlays[currentOverlay][1], availableOverlays[currentOverlay][2], availableOverlays[currentOverlay][3], prevColor[4])
            _dxDrawText(unpack(parameters))
        end
    end

end


--TODO: REMOVE LATER :)
-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    local test = {}
    local testMode = 0
    for i, j in pairs(availableOverlays) do
        table.insert(test, i)
    end
    bindKey("1", "down", function()
        if testMode >= #test then
            testMode = 0
            currentOverlay = nil
        else
            testMode = testMode + 1
            currentOverlay = test[testMode]
        end
    end)
    
end)