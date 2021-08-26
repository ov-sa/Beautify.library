----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: attacher.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Attacher ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    isElement = isElement,
    isKeyOnHold = isKeyOnHold,
    getAbsoluteCursorPosition = getAbsoluteCursorPosition
}


-------------------
--[[ Variables ]]--
-------------------

CLIENT_ATTACHED_ELEMENT = false


-----------------------------------------------
--[[ Functions: Retrieves Attached Element ]]--
-----------------------------------------------

function getAttachedElement()

    return CLIENT_ATTACHED_ELEMENT

end


----------------------------------------------
--[[ Functions: Attaches/Detaches Element ]]--
----------------------------------------------

function attachElement(element, isInternal)

    if CLIENT_MTA_WINDOW_ACTIVE or not CLIENT_IS_CURSOR_SHOWING or not imports.isKeyOnHold("mouse1") then return false end
    if CLIENT_ATTACHED_ELEMENT and CLIENT_ATTACHED_ELEMENT.element and imports.isElement(CLIENT_ATTACHED_ELEMENT.element) and (CLIENT_ATTACHED_ELEMENT.element == element) then return false end
    local cursor_offsetX, cursor_offsetY = imports.getAbsoluteCursorPosition()
    if not cursor_offsetX or not cursor_offsetY then return false end

    CLIENT_ATTACHED_ELEMENT = {
        element = element,
        offsetX = cursor_offsetX - createdElements[element].gui.x,
        offsetY = cursor_offsetY - createdElements[element].gui.y,
        isInternal = (isInternal and true) or false
    }
    return true

end

function detachElement()

    if not CLIENT_ATTACHED_ELEMENT then return false end

    CLIENT_ATTACHED_ELEMENT = false
    return true

end