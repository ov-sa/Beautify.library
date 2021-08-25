----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: gui: ui_1.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Example UI ]]--
----------------------------------------------------------------


----------------------
-->> Example UI 1 <<--
----------------------

function createExampleUI1()

    local window_width, window_height = 700, 378
    local createdWindow = beautify.window.create(25, (CLIENT_MTA_RESOLUTION[2] - window_height)/2, window_width, window_height, "Dev. UI #1", nil, false)
    local createdLabel = beautify.label.create("DISCLAIMER: THIS IS JUST A DEVELOPMENT UI!", 0, 0, window_width, 20, createdWindow, false)
    local createdGridlist = beautify.gridlist.create(0, 20, window_width, window_height - 20 - 30, createdWindow, false)
    
    beautify.label.setHorizontalAlignment(createdLabel, "center")
    beautify.label.setVerticalAlignment(createdLabel, "center")
    beautify.setUIDisabled(createdLabel, true)
    beautify.setUIVisible(createdLabel, true)
    beautify.gridlist.addColumn(createdGridlist, "S.No", 75)
    beautify.gridlist.addColumn(createdGridlist, "Name", 250)
    beautify.gridlist.addColumn(createdGridlist, "Country", 100)
    beautify.gridlist.addColumn(createdGridlist, "Rank", 250)
    beautify.setUIVisible(createdGridlist, true)

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

    local createdButton = beautify.button.create("Button #1", 0, window_height - 30 + 5, "default", 175, 24, createdWindow, false)
    local createdButton2 = beautify.button.create("Button #2", 180, window_height - 30 + 5, "default", 175, 24, createdWindow, false)
    beautify.setUIVisible(createdButton, true)
    beautify.setUIVisible(createdButton2, true)

    local createdCheckbox = beautify.checkbox.create(window_width - 150, window_height - 20 - 2, 150, 20, createdWindow, false)
    beautify.checkbox.setText(createdCheckbox, "Enable Light Mode")
    beautify.checkbox.setTextColor(createdCheckbox, {255, 255, 255, 255})
    beautify.setUIVisible(createdCheckbox, true)

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

    addEventHandler("onClientUIScroll", createdGridlist, function(state)
        outputChatBox("Scrolled: "..state)
    end)
    addEventHandler("onClientUIAltered", createdGridlist, function()
        outputChatBox("Altered")
    end)
    addEventHandler("onClientUISelectionAltered", createdCheckbox, function(state)
        exports.beautify_library:setUITemplate("beautify_scrollbar", (not state and availableTemplates["beautify_scrollbar"]["dark-blue-theme"]) or availableTemplates["beautify_scrollbar"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_window", (not state and availableTemplates["beautify_window"]["dark-blue-theme"]) or availableTemplates["beautify_window"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_gridlist", (not state and availableTemplates["beautify_gridlist"]["dark-blue-theme"]) or availableTemplates["beautify_gridlist"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_button", (not state and availableTemplates["beautify_button"]["dark-blue-theme"]) or availableTemplates["beautify_button"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_label", (not state and availableTemplates["beautify_label"]["dark-blue-theme"]) or availableTemplates["beautify_label"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_slider", (not state and availableTemplates["beautify_slider"]["dark-blue-theme"]) or availableTemplates["beautify_slider"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_selector", (not state and availableTemplates["beautify_selector"]["dark-blue-theme"]) or availableTemplates["beautify_selector"]["dark-red-theme"])
        exports.beautify_library:setUITemplate("beautify_checkbox", (not state and availableTemplates["beautify_checkbox"]["dark-blue-theme"]) or availableTemplates["beautify_checkbox"]["dark-red-theme"])
    end)

end