local sX, sY = guiGetScreenSize()
sX = sX/1366; sY = sY/768;

addEventHandler("onClientResourceStart", resource, function()

    local window_width, window_height = 700, 350
    local createdWindow = createWindow((sX*1366 - window_width)/2, (sY*768 - window_height)/2, window_width, window_height, "Development UI", nil, false)
    local createdLabel = createLabel("DISCLAIMER: THIS IS JUST A DEVELOPMENT UI!", 0, 0, window_width, 20, createdWindow, false)
    local createdGridlist = createGridlist(0, 20, window_width, window_height - 20 - 30, createdWindow, false)
    local createdButton = createButton("Button #1", 0, window_height - 30 + 5, "default", 175, 24, createdWindow, false)
    local createdButton2 = createButton("Button #2", 180, window_height - 30 + 5, "default", 175, 23, createdWindow, false)
    setLabelColor(createdLabel, {235, 0, 0, 255})
    setLabelHorizontalAlignment(createdLabel, "center")
    setLabelVerticalAlignment(createdLabel, "center")
    addGridlistColumn(createdGridlist, "S.No", 75)
    addGridlistColumn(createdGridlist, "Name", 250)
    addGridlistColumn(createdGridlist, "Country", 100)
    addGridlistColumn(createdGridlist, "Rank", 250)
    setUIVisible(createdWindow, true)
    setUIDraggable(createdWindow, true)
    setUIVisible(createdLabel, true)
    setUIVisible(createdGridlist, true)
    setUIVisible(createdButton, true)
    setUIVisible(createdButton2, true)
    --setUIDisabled(createdGridlist, true)
    showCursor(true)

    local testRows = {
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
        for i, j in ipairs(testRows) do
            local rowIndex = addGridlistRow(createdGridlist)
            local rowData = {}
            for k, v in pairs(j) do
                if k == 1 then
                    setGridlistRowData(createdGridlist, rowIndex, k, tostring(countGridlistRows(createdGridlist)))
                else
                    setGridlistRowData(createdGridlist, rowIndex, k, v)
                end
                rowData[k] = getGridlistRowData(createdGridlist, rowIndex, k)
            end
        end
    end
    setGridlistSelection(createdGridlist, 1)

    addEventHandler("onClientUIClick", root, function(key)
        outputChatBox("Clicked: "..source:getType())
    end)
    addEventHandler("onClientUIScroll", createdGridlist, function(state)
        outputChatBox("Scrolled: "..state)
    end)
    addEventHandler("onClientUIAltered", createdGridlist, function()
        outputChatBox("Altered")
    end)

end)