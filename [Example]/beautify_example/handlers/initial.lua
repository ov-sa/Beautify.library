----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: handlers: initial.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Initial Handler ]]--
----------------------------------------------------------------


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resourceRoot, function()

    createExampleUI1()
    createExampleUI2()
    createExampleUI3()
    showCursor(true)

end)