----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: event.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Event Handler ]]--
----------------------------------------------------------------


-----------------------------------
--[[ Event: On Client UI Click ]]--
-----------------------------------

local prevScrollState = false
local prevScrollStreak = {state = false, tickCounter = false, streak = 1}
local customUIEvents = {
    "onClientUIClick",
    "onClientUIScroll"
}
for i, j in ipairs(customUIEvents) do
    addEvent(j, false)
end


------------------------------
--[[ Event: On Client Key ]]--
------------------------------

addEventHandler("onClientKey", root, function(button, state)

    if GuiElement.isMTAWindowActive() then return false end

    local isMouseScrolled = false
    if button == "mouse_wheel_up" then
        isMouseScrolled = "up"
    elseif button == "mouse_wheel_down" then
        isMouseScrolled = "down"
    end

    if isMouseScrolled then
        if not prevScrollStreak.state or prevScrollStreak.state ~= isMouseScrolled then
            prevScrollStreak.state = isMouseScrolled
            prevScrollStreak.streak = 1
            prevScrollStreak.tickCounter = getTickCount()
        else
            if (getTickCount() - prevScrollStreak.tickCounter) < 250 then
                prevScrollStreak.streak = prevScrollStreak.streak + 0.5
            else
                prevScrollStreak.streak = 1
            end
            prevScrollStreak.tickCounter = getTickCount()
        end
        prevScrollState = isMouseScrolled
    end

end)