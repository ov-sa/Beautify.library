----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: element.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Panel's Cache Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

windowCache = {

}


-----------------------------------
--[[ Function: Destroys Window ]]--
-----------------------------------

function __destroyWindow(window, skipSelf)

    if window and windowCache[window] then
        for i, j in pairs(windowCache[window]) do
            if i and isElement(i) then
                i:destroy()
            end
        end
        windowCache[window] = nil
        if not skipSelf then
            window:destroy()
        end
        return true
    end
    return false

end