----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: template.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Template's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableTemplate = {

    ["beautify_window"] = {
        titleBar = {
            font = DxFont("files/assets/fonts/signika_semibold.ttf", 12, true),
            fontColor = {50, 75, 200, 255},
            color = {0, 0, 0, 255},
            divider = {
                size = 2,
                color = {80, 80, 255, 75}
            },
            close_button = {
                fontColor = {175, 175, 175, 0},
                hoverColor = {50, 75, 200, 255}
            }
        }
    }

}