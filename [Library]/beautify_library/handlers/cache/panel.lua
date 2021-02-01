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

panelCache = {

}


----------------------------------
--[[ Function: Destroys Panel ]]--
----------------------------------

function __destroyPanel(panel)

    if panel and panelCache[panel] then
        for i, j in pairs(panelCache[panel]) do
            if i and isElement(i) then
                i:destroy()
            end
        end
        panelCache[panel] = nil
        return true
    end
    return false

end