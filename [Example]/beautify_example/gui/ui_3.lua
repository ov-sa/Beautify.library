----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: gui: ui_3.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Example UI ]]--
----------------------------------------------------------------


----------------------
-->> Example UI 3 <<--
----------------------

function createExampleUI3()

    local window_width, window_height = 275, 150
    local createdWindow = beautify.window.create(725 + 300 + 25, (CLIENT_MTA_RESOLUTION[2] - 350)/2 + 50, window_width, window_height, "Dev. UI #3", nil, false)
    
    local createdSelector = beautify.selector.create(12.5, 12.5, 250, 20, "horizontal", createdWindow, false)
    local createdSelector2 = beautify.selector.create(12.5, 47.5, 250, 20, "horizontal", createdWindow, false)
    local createdSelector3 = beautify.selector.create(12.5, 82.5, 250, 20, "horizontal", createdWindow, false)
    local createdSelector4 = beautify.selector.create(12.5, 117.5, 250, 20, "horizontal", createdWindow, false)
    beautify.selector.setText(createdSelector, "Ethnicity")
    beautify.selector.setText(createdSelector2, "Torso")
    beautify.selector.setText(createdSelector3, "Trouser")
    beautify.selector.setText(createdSelector4, "Feet")

    beautify.selector.setDataList(createdSelector, {
        "American",
        "Asian",
        "Arab",
        "African"
    })
    beautify.selector.setDataList(createdSelector2, {
        "Shirt",
        "T-Shirt",
        "Hoodie",
        "Suit"
    })
    beautify.selector.setDataList(createdSelector3, {
        "Jeans",
        "Shorts",
        "Trackers"
    })
    beautify.selector.setDataList(createdSelector4, {
        "Slippers",
        "Sneakers",
        "Boots",
    })
    beautify.setUIVisible(createdSelector, true)
    beautify.setUIVisible(createdSelector2, true)
    beautify.setUIVisible(createdSelector3, true)
    beautify.setUIVisible(createdSelector4, true)
    beautify.setUIVisible(createdWindow, true)

    beautify.setUIDraggable(createdWindow, true)

end