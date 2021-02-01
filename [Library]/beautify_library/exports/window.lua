----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: exports: window.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Window's Exports ]]--
----------------------------------------------------------------


----------------------------------
--[[ Function: Creates Window ]]--
----------------------------------

function createWindow(x, y, width, height, title)

    x = tonumber(x); y =  tonumber(y); width = tonumber(width); height = tonumber(height);
    if not x or not y or not width or not height then return false end
    if not title then title = "" end
    title = tostring(title)

    outputUILog("<createWindow> (float: x, float: y, float: width, float: height, string: title)", "error")

end