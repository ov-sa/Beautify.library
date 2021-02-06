--TODO: TESTING, REMOVE LATER



local sX, sY = guiGetScreenSize()
sX = sX/1366; sY = sY/768;

addEventHandler("onClientResourceStart", resource, function()

    local window_width, window_height = 600, 350
    createWindow((sX*1366 - window_width)/2, (sY*768 - window_height)/2, window_width, window_height, "My First Window", tocolor(15, 15, 15, 255), false)

end)