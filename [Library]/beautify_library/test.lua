--TODO: TESTING, REMOVE LATER



local sX, sY = guiGetScreenSize()
sX = sX/1366; sY = sY/768;

addEventHandler("onClientResourceStart", resource, function()

    local window_width, window_height = 700, 350
    local createdWindow = createWindow((sX*1366 - window_width)/2, (sY*768 - window_height)/2, window_width, window_height, "Development UI", false)
    local createdGridlist = createGridlist(0, 0, window_width, window_height, createdWindow, false)
    addGridlistColumn(createdGridlist, "S.No", 75)
    addGridlistColumn(createdGridlist, "Name", 250)
    addGridlistColumn(createdGridlist, "Country", 100)
    addGridlistColumn(createdGridlist, "Rank", 250)
    setUIVisible(createdWindow, true)

    local testRows = {
        {
            [1] = "1", [2] = "Tron", [3] = "BH", [4] = "CEO"
        },
        {
            [1] = "2", [2] = "Acen", [3] = "BZ", [4] = "Member"
        },
        {
            [1] = "3", [2] = "Aviril", [3] = "US", [4] = "Developer"
        }
    }
    for i, j in ipairs(testRows) do
        local rowIndex = addGridlistRow(createdGridlist)
        local rowData = {}
        for k, v in pairs(j) do
            setGridListRowData(createdGridlist, rowIndex, k, v)
            rowData[k] = getGridListRowData(createdGridlist, rowIndex, k)
        end
        outputChatBox(toJSON(rowData))
    end
    showCursor(true)

end)