----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: cache: asset.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Asset's Cache Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

createdAssets = {}


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resource, function()

    for i, j in pairs(availableAssets) do
        createdAssets[i] = {}
        for k, v in ipairs(j) do
            local assetPath = "files/assets/"..i.."/"..v
            if File.exists(assetPath) then
                if i == "images" then
                    createdAssets[i][v] = DxTexture(assetPath, "argb", true, "clamp")
                end
            end
        end
    end

end)