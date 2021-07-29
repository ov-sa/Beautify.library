----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: component: scrollbar.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Scroll Bar's Renderer ]]--
----------------------------------------------------------------


--------------------------------------
--[[ Function: Renders Scroll Bar ]]--
--------------------------------------

function renderScrollbar(elementParent)

    if not isUIValid(elementParent) then return false end
    local elementType = elementParent:getType()

    --TODO: CHECK IF ELEMENT IS SCROLLABLE OR NOT..
    return true

end