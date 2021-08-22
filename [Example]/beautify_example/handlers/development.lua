----------------------------------------------------------------
--[[ Resource: Beautify Library (Example)
     Script: handlers: development.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Development Handler ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

CLIENT_MTA_RESOLUTION = {GuiElement.getScreenSize()}
loadstring(exports.beautify_library:fetchImports())()


---------------------------
-->> Development UI 1 <<--
---------------------------

local function devUI1()

    local window_width, window_height = 700, 378
    local createdWindow = beautify.window.create(25, (CLIENT_MTA_RESOLUTION[2] - window_height)/2, window_width, window_height, "Dev. UI #1", nil, false)
    local createdLabel = beautify.label.create("DISCLAIMER: THIS IS JUST A DEVELOPMENT UI!", 0, 0, window_width, 20, createdWindow, false)
    local createdGridlist = beautify.gridlist.create(0, 20, window_width, window_height - 20 - 30, createdWindow, false)
    local createdButton = beautify.button.create("Button #1", 0, window_height - 30 + 5, "default", 175, 24, createdWindow, false)
    local createdButton2 = beautify.button.create("Button #2", 180, window_height - 30 + 5, "default", 175, 23, createdWindow, false)
    beautify.label.setHorizontalAlignment(createdLabel, "center")
    beautify.label.setVerticalAlignment(createdLabel, "center")
    beautify.setUIDisabled(createdLabel, true)
    beautify.setUIVisible(createdLabel, true)
    beautify.gridlist.addColumn(createdGridlist, "S.No", 75)
    beautify.gridlist.addColumn(createdGridlist, "Name", 250)
    beautify.gridlist.addColumn(createdGridlist, "Country", 100)
    beautify.gridlist.addColumn(createdGridlist, "Rank", 250)
    beautify.setUIVisible(createdGridlist, true)
    beautify.setUIVisible(createdButton, true)
    beautify.setUIVisible(createdButton2, true)

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

    local rowDatas = {
        {
            [1] = "1", [2] = "Tron", [3] = "BH", [4] = "CEO"
        },
        {
            [1] = "2", [2] = "Acen", [3] = "BZ", [4] = "Member"
        },
        {
            [1] = "3", [2] = "Aviril", [3] = "US", [4] = "Developer"
        },
        {
            [1] = "3", [2] = "Mario", [3] = "BH", [4] = "CEO"
        }
    }
    for x = 1, 500, 1 do
        for i, j in ipairs(rowDatas) do
            local rowIndex = beautify.gridlist.addRow(createdGridlist)
            local rowData = {}
            for k, v in pairs(j) do
                if k == 1 then
                    beautify.gridlist.setRowData(createdGridlist, rowIndex, k, tostring(beautify.gridlist.countRows(createdGridlist)))
                else
                    beautify.gridlist.setRowData(createdGridlist, rowIndex, k, v)
                end
                rowData[k] = beautify.gridlist.getRowData(createdGridlist, rowIndex, k)
            end
        end
    end
    beautify.gridlist.setSelection(createdGridlist, 1)

    addEventHandler("onClientUIScroll", createdGridlist, function(state)
        outputChatBox("Scrolled: "..state)
    end)
    addEventHandler("onClientUIAltered", createdGridlist, function()
        outputChatBox("Altered")
    end)

end


---------------------------
-->> Development UI 2 <<--
---------------------------

local function devUI2()

    local window_width, window_height = 275, 350
    local createdWindow = beautify.window.create(725 + 25, (CLIENT_MTA_RESOLUTION[2] - window_height)/2, window_width, window_height, "Dev. UI #2", nil, false)
    
    local createdSlider = beautify.slider.create(12.5, 12.5, 250, 28, "horizontal", createdWindow, false)
    local createdSlider2 = beautify.slider.create(12.5, 52, 250, 28, "horizontal", createdWindow, false)
    local createdSlider3 = beautify.slider.create(12.5, 91.5, 250, 28, "horizontal", createdWindow, false)
    local createdSlider4 = beautify.slider.create(12.5, 131, 250, 28, "horizontal", createdWindow, false)
    local createdSlider5 = beautify.slider.create(12.5, 170.5, 250, 28, "horizontal", createdWindow, false)
    beautify.slider.setText(createdSlider, "VOLUME")
    beautify.slider.setText(createdSlider2, "VISIBILITY")
    beautify.slider.setText(createdSlider3, "DRAW DISTANCE")
    beautify.slider.setText(createdSlider4, "FIELD OF VIEW")
    beautify.slider.setText(createdSlider5, "GAMEPLAY SOUNDS")
    beautify.slider.setPercent(createdSlider, math.random(0, 100))
    beautify.slider.setPercent(createdSlider2, math.random(0, 100))
    beautify.slider.setPercent(createdSlider3, math.random(0, 100))
    beautify.slider.setPercent(createdSlider4, math.random(0, 100))
    beautify.slider.setPercent(createdSlider5, math.random(0, 100))
    beautify.setUIVisible(createdSlider, true)
    beautify.setUIVisible(createdSlider2, true)
    beautify.setUIVisible(createdSlider3, true)
    beautify.setUIVisible(createdSlider4, true)
    beautify.setUIVisible(createdSlider5, true)

    local createdSlider6 = beautify.slider.create(64.75, 200.5, 28, 140, "vertical", createdWindow, false)
    local createdSlider7 = beautify.slider.create(104.25, 200.5, 28, 140, "vertical", createdWindow, false)
    local createdSlider8 = beautify.slider.create(143.75, 200.5, 28, 140, "vertical", createdWindow, false)
    local createdSlider9 = beautify.slider.create(183.25, 200.5, 28, 140, "vertical", createdWindow, false)
    beautify.slider.setText(createdSlider6, "H-SENSITIVITY")
    beautify.slider.setText(createdSlider7, "V-SENSITIVITY")
    beautify.slider.setText(createdSlider8, "AMBIENCE")
    beautify.slider.setText(createdSlider9, "OVERLAYS")
    beautify.slider.setPercent(createdSlider6, math.random(0, 100))
    beautify.slider.setPercent(createdSlider7, math.random(0, 100))
    beautify.slider.setPercent(createdSlider8, math.random(0, 100))
    beautify.slider.setPercent(createdSlider9, math.random(0, 100))
    beautify.setUIVisible(createdSlider6, true)
    beautify.setUIVisible(createdSlider7, true)
    beautify.setUIVisible(createdSlider8, true)
    beautify.setUIVisible(createdSlider9, true)

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

end


--------------------------
-->> Development UI 3 <<--
--------------------------

local function devUI3()

    local window_width, window_height = 275, 150
    local createdWindow = beautify.window.create(725 + 300 + 25, (CLIENT_MTA_RESOLUTION[2] - 350)/2, window_width, window_height, "Dev. UI #3", nil, false)
    
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


--------------------------
-->> Development UI 4 <<--
--------------------------

local function devUI4()

    local window_width, window_height = 275, 150
    local createdWindow = beautify.window.create(725 + 300 + 25, (CLIENT_MTA_RESOLUTION[2] - 350)/2 + 150 + 25 + 25, window_width, window_height, "Dev. UI #4", nil, false)
    
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


-----------------------------------------
--[[ Event: On Client Resource Start ]]--
-----------------------------------------

addEventHandler("onClientResourceStart", resourceRoot, function()

    devUI1()
    devUI2()
    devUI3()
    devUI4()
    showCursor(true)

    addEventHandler("onClientUIClick", root, function(key)
        outputChatBox("Clicked: "..source:getType())
    end)

end)