----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Cache Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

windowReferences = {}


-----------------------------------
--[[ Function: Destroys Window ]]--
-----------------------------------

function destroyWindow(window)

    if window and windowReferences[window] then
        for i, j in pairs(windowReferences[window]) do
            if i and isElement(i) then
                i:destroy()
            end
        end
        windowReferences[window] = nil
        return true
    end
    return false

end