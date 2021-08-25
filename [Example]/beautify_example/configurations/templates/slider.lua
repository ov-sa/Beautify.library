----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: configurations: templates: slider.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplates["beautify_slider"] = {

    ["dark-blue-theme"] = {
        fontColor = {200, 200, 200, 255},
        track = {
            size = 3,
            progressedColor = {125, 125, 255, 255},
            unprogressedColor = {15, 15, 15, 255}
        },
        thumb = {
            size = 9.2,
            color = {125, 125, 255, 255}
        }
    },

    ["dark-red-theme"] = {
        fontColor = {200, 200, 200, 255},
        track = {
            size = 3,
            progressedColor = {255, 125, 125, 255},
            unprogressedColor = {15, 15, 15, 255}
        },
        thumb = {
            size = 9.2,
            color = {255, 125, 125, 255}
        }
    },

    ["dark-green-theme"] = {
        fontColor = {200, 200, 200, 255},
        track = {
            size = 3,
            progressedColor = {125, 255, 125, 255},
            unprogressedColor = {15, 15, 15, 255}
        },
        thumb = {
            size = 9.2,
            color = {125, 255, 125, 255}
        }
    },

    ["dark-yellow-theme"] = {
        fontColor = {200, 200, 200, 255},
        track = {
            size = 3,
            progressedColor = {255, 255, 125, 255},
            unprogressedColor = {15, 15, 15, 255}
        },
        thumb = {
            size = 9.2,
            color = {255, 255, 125, 255}
        }
    }

}