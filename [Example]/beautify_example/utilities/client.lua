  
----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: utilities: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Client Sided Utilities ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

resource = getResourceRootElement(getThisResource())
CLIENT_MTA_RESOLUTION = {GuiElement.getScreenSize()}
loadstring(exports.beautify_library:fetchImports())()