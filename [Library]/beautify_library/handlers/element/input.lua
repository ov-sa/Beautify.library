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
    prevScrollStreak = {state = false, tickCounter = false, streak = 1}
}


---------------------------------------------
--[[ Function: Verifies Input's Validity ]]--
---------------------------------------------

local function isInputValid()

    if GuiElement.isMTAWindowActive() then return false end

    resetKeyClickCache()
    resetScrollCache(true)
    return true

end


----------------------------------------
--[[ Functions: Resets Input States ]]--
----------------------------------------

function resetKeyClickCache()

    for i, j in pairs(INPUT_CACHE.prevKeyClickStates) do
        j.prevState = false
        j.currState = false
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

    if not prevLMBClickState then
        if getKeyState("mouse1") then
            isLMBClicked = true
            prevLMBClickState = true
        end
    else
        if not getKeyState("mouse1") then
            prevLMBClickState = false
        end
    end

end)


------------------------------
--[[ Event: On Client Key ]]--
------------------------------

addEventHandler("onClientKey", root, function(button, state)

    if not isInputValid() then return false end

    local isMouseScrolled = false
    if button == "mouse_wheel_up" then
        isMouseScrolled = "up"
    elseif button == "mouse_wheel_down" then
        isMouseScrolled = "down"
    end

    if isMouseScrolled then
        if not INPUT_CACHE.prevScrollStreak.state or INPUT_CACHE.prevScrollStreak.state ~= isMouseScrolled then
            INPUT_CACHE.prevScrollStreak.state = isMouseScrolled
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

end)