----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: element: attacher.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Attacher ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

attachedElement = false


-----------------------------------------------
--[[ Functions: Retrieves Attached Element ]]--
-----------------------------------------------

function getAttachedElement()

    return attachedElement

end


----------------------------------------------
--[[ Functions: Attaches/Detaches Element ]]--
----------------------------------------------

function attachElement(element, isInternal)

    if GuiElement.isMTAWindowActive() or not isCursorShowing() or not getKeyState("mouse1") or not isUIValid(element) or not isUIVisible(element) then return false end
    if attachedElement and attachedElement.element and isElement(attachedElement.element) and (attachedElement.element == element) then return false end
    local cursorOffset = {getAbsoluteCursorPosition()}
    if not cursorOffset[1] or not cursorOffset[2] then return false end

    attachedElement = {
        element = element,
        offsetX = cursorOffset[1] - createdElements[element].gui.x,
        offsetY = cursorOffset[2] - createdElements[element].gui.y,
        isInternal = (isInternal and true) or false
    }
    return true

end

function detachElement()

    if not attachedElement then return false end

    attachedElement = false
    return true

end