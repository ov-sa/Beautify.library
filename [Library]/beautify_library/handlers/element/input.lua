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
    prevScrollState = {scrollState = false, streakState = false, streakCounter = 1, tickCounter = getTickCount()}
}
local DEFAULT_INPUT_KEYS = {
    "mouse1", "mouse2"
}


---------------------------------------------
--[[ Function: Verifies Input's Validity ]]--
---------------------------------------------

local function isInputValid()

    if GuiElement.isMTAWindowActive() then
        resetKeyClickCache(nil, true)
        resetScrollCache(true)
        return false
    end
    return true

end


-------------------------------------------------------
--[[ Functions: Adds/Resets/Retrieves Input States ]]--
-------------------------------------------------------

function addKeyClickCache(key)

    if not key or INPUT_CACHE.prevKeyClickStates[key] then return false end

    INPUT_CACHE.prevKeyClickStates[key] = {holdState = false, clickState = false, tickCounter = getTickCount()}
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

function isKeyClicked(key)
   
    if not key or not INPUT_CACHE.prevKeyClickStates[key] then return false end

    return INPUT_CACHE.prevKeyClickStates[key].clickState

end

function isKeyOnHold(key)
   
    if not key or not INPUT_CACHE.prevKeyClickStates[key] then return false end

    return INPUT_CACHE.prevKeyClickStates[key].holdState

end

function isMouseScrolled()
   
    if not INPUT_CACHE.prevScrollState.scrollState then return false end

    return INPUT_CACHE.prevScrollState.scrollState, INPUT_CACHE.prevScrollState.streakCounter

end

function resetScrollCache(resetStreak)

    if not INPUT_CACHE.prevScrollState.scrollState then return false end

    if resetStreak and INPUT_CACHE.prevScrollState.scrollState then
        INPUT_CACHE.prevScrollState.streakCounter = 1
        INPUT_CACHE.prevScrollState.tickCounter = getTickCount()
    end
    INPUT_CACHE.prevScrollState.scrollState = false
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
                j.tickCounter = getTickCount()
            end
        else
            if not getKeyState(i) then
                j.holdState = false
                j.tickCounter = getTickCount()
            end
        end
    end

end, false, UI_PRIORITY_LEVEL.INPUT)


------------------------------
--[[ Event: On Client Key ]]--
------------------------------

addEventHandler("onClientKey", root, function(button, state)

    if not isInputValid() then return false end

    local isScrolled = false
    if button == "mouse_wheel_up" then
        isScrolled = "up"
    elseif button == "mouse_wheel_down" then
        isScrolled = "down"
    end

    if isScrolled then
        if not INPUT_CACHE.prevScrollState.streakCounterState or INPUT_CACHE.prevScrollState.streakCounterState ~= isScrolled then
            INPUT_CACHE.prevScrollState.streakCounterState = isScrolled
            INPUT_CACHE.prevScrollState.streakCounter = 1
            INPUT_CACHE.prevScrollState.tickCounter = getTickCount()
        else
            if (getTickCount() - INPUT_CACHE.prevScrollState.tickCounter) < UI_INPUT_FRAMES.SCROLL_DELAY then
                INPUT_CACHE.prevScrollState.streakCounter = INPUT_CACHE.prevScrollState.streakCounter + 0.5
            else
                INPUT_CACHE.prevScrollState.streakCounter = 1
            end
            INPUT_CACHE.prevScrollState.tickCounter = getTickCount()
        end
        INPUT_CACHE.prevScrollState.scrollState = isScrolled
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