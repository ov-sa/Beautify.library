----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: asset.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Asset's Cache Handler ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    pairs = pairs,
    ipairs = ipairs,
    fileExists = fileExists,
    dxCreateTexture = dxCreateTexture
}


-------------------
--[[ Variables ]]--
-------------------

createdAssets = {}


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    for i, j in imports.pairs(availableAssets) do
        createdAssets[i] = {}
        for k, v in imports.ipairs(j) do
            local assetPath = "files/assets/"..i.."/"..v
            if imports.fileExists(assetPath) then
                if i == "images" then
                    createdAssets[i][v] = imports.dxCreateTexture(assetPath, "argb", true, "clamp")
                end
            end
        end
    end

end)