----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: gui: ui_4.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Example UI ]]--
----------------------------------------------------------------


----------------------
-->> Example UI 4 <<--
----------------------

function createExampleUI4()

    local window_width, window_height = 275, 150
    local createdWindow = beautify.window.create(725 + 300 + 25, (CLIENT_MTA_RESOLUTION[2] - 350)/2 + 150 + 50 + 50, window_width, window_height, "Dev. UI #4", nil, false)

    local createdSelector = beautify.selector.create(12.5, 12, 250, 60, "vertical", createdWindow, false)
    local createdSelector2 = beautify.selector.create(12.5, 77, 250, 60, "vertical", createdWindow, false)
    beautify.selector.setText(createdSelector, "Helmet")
    beautify.selector.setText(createdSelector2, "Vest")
    beautify.selector.setDataList(createdSelector, {
        "Assault",
        "Ballistic",
        "Combat",
        "Tactical"
    })
    beautify.selector.setDataList(createdSelector2, {
        "Assault",
        "Ballistic",
        "Hunter",
        "Tactical"
    })
    beautify.setUIVisible(createdSelector, true)
    beautify.setUIVisible(createdSelector2, true)

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

end