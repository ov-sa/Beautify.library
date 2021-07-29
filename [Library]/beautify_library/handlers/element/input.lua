----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: input.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Input Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

INPUT_CACHE = {
    prevKeyClickStates = {},
    prevScrollState = false,
    prevScrollStreak = {scrollState = false, tickCounter = false, streak = 1}
}
local DEFAULT_INPUT_KEYS = {
    "mouse1", "mouse2"
}


---------------------------------------------
--[[ Function: Verifies Input's Validity ]]--
---------------------------------------------

local function isInputValid()

    if GuiElement.isMTAWindowActive() then return false end

    resetKeyClickCache(nil, true)
    resetScrollCache(true)
    return true

end


---------------------------------------------
--[[ Functions: Adds/Resets Input States ]]--
---------------------------------------------

function addKeyClickCache(key)

    if not key or INPUT_CACHE.prevKeyClickStates[key] then return false end

    INPUT_CACHE.prevKeyClickStates[key] = {holdState = false, tickCounter = false, clickState = false}
    return true

end

function resetKeyClickCache(key, resetHold)

    if key then
        if not INPUT_CACHE.prevKeyClickStates[key] then return false end
        INPUT_CACHE.prevKeyClickStates[key].clickState = false
    else
        for i, j in pairs(INPUT_CACHE.prevKeyClickStates) do
            j.clickState = false
            if resetHold then
                j.holdState = false
            end
        end
    end
    return true

end

function resetScrollCache(resetStreak)

    if not INPUT_CACHE.prevScrollState then return false end

    if resetStreak and INPUT_CACHE.prevScrollState then
        INPUT_CACHE.prevScrollStreak.streak = 1
        INPUT_CACHE.prevScrollStreak.tickCounter = getTickCount()
    end
    INPUT_CACHE.prevScrollState = false
    return true

end


---------------------------------
--[[ Event: On Client Render ]]--
---------------------------------

addEventHandler("onClientRender", root, function()

    if not isInputValid() then return false end

    for i, j in pairs(INPUT_CACHE.prevKeyClickStates) do
        if not j.holdState then
            if getKeyState(i) then
                j.clickState = true
                j.holdState = true
            end
        else
            if not getKeyState(i) then
                j.holdState = false
            end
        end
    end

end, false, UI_PRIORITY_LEVEL.INPUT)


------------------------------
--[[ Event: On Client Key ]]--
------------------------------

addEventHandler("onClientKey", root, function(button, state)

    --if not isInputValid() then return false end

    local isMouseScrolled = false
    if button == "mouse_wheel_up" then
        isMouseScrolled = "up"
    elseif button == "mouse_wheel_down" then
        isMouseScrolled = "down"
    end

    if isMouseScrolled then
        if not INPUT_CACHE.prevScrollStreak.scrollState or INPUT_CACHE.prevScrollStreak.scrollState ~= isMouseScrolled then
            INPUT_CACHE.prevScrollStreak.scrollState = isMouseScrolled
            INPUT_CACHE.prevScrollStreak.streak = 1
            INPUT_CACHE.prevScrollStreak.tickCounter = getTickCount()
        else
            if (getTickCount() - INPUT_CACHE.prevScrollStreak.tickCounter) < 250 then
                INPUT_CACHE.prevScrollStreak.streak = INPUT_CACHE.prevScrollStreak.streak + 0.5
            else
                INPUT_CACHE.prevScrollStreak.streak = 1
            end
            INPUT_CACHE.prevScrollStreak.tickCounter = getTickCount()
        end
        INPUT_CACHE.prevScrollState = isMouseScrolled
    end

end, false, UI_PRIORITY_LEVEL.INPUT)


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    for i, j in ipairs(DEFAULT_INPUT_KEYS) do
        addKeyClickCache(j)
    end

end)