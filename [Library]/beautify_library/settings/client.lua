  
----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: settings: client.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Client Sided Settings ]]--
----------------------------------------------------------------


------------------
--[[ Settings ]]--
------------------

resource = getResourceRootElement(getThisResource())

inputDelayDuration = 500 --(In milliseconds)
availableElements = {

    ["ov_panel"] = {
        __clearCache = __destroyPanel
    }

}