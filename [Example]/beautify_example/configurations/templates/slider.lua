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

    ["dark-silver-theme"] = {},

    ["dark-blue-theme"] = {
        fontColor = {198, 198, 198, 255},
        track = {
            progressedColor = {158, 158, 255, 255},
            unprogressedColor = {32, 32, 32, 255}
        },
        thumb = {
            slideAcceleration = 1,
            color = {158, 158, 255, 255}
        }
    },

    ["dark-red-theme"] = {
        fontColor = {198, 198, 198, 255},
        track = {
            progressedColor = {255, 158, 158, 255},
            unprogressedColor = {32, 32, 32, 255}
        },
        thumb = {
            slideAcceleration = 1,
            color = {255, 158, 158, 255}
        }
    },

    ["dark-green-theme"] = {
        fontColor = {198, 198, 198, 255},
        track = {
            progressedColor = {158, 255, 158, 255},
            unprogressedColor = {32, 32, 32, 255}
        },
        thumb = {
            slideAcceleration = 1,
            color = {158, 255, 158, 255}
        }
    },

    ["dark-yellow-theme"] = {
        fontColor = {198, 198, 198, 255},
        track = {
            progressedColor = {255, 255, 158, 255},
            unprogressedColor = {32, 32, 32, 255}
        },
        thumb = {
            slideAcceleration = 1,
            color = {255, 255, 158, 255}
        }
    }

}