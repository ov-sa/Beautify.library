----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: native.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Native's Cache Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local availableDXNatives = {
    "isCursorShowing",
    "getAbsoluteCursorPosition",
    "tocolor",
    "dxSetRenderTarget",
    "dxSetBlendMode",
    "dxDrawText",
    "dxDrawImage",
    "dxDrawRectangle"
}


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    if #availableDXNatives > 0 then
        local clonedNatives = ""
        for i, j in ipairs(availableDXNatives) do
            clonedNatives = j.." = "..j
            if i ~= #availableDXNatives then
                clonedNatives = clonedNatives.."\n"
            end
        end
        loadstring(clonedNatives)()
    end

end)