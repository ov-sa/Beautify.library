--TODO: TESTING, REMOVE LATER



local sX, sY = guiGetScreenSize()
sX = sX/1366; sY = sY/768;

addEventHandler("onClientResourceStart", resource, function()

    --TODO: Throw error if negative values are entered, make config for it..
    local window_width, window_height = 600, 350
    createWindow((sX*1366 - window_width)/2, (sY*768 - window_height)/2, window_width, window_height, "My First Window", tocolor(5, 5, 5, 255))

end)