----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: label.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Label's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    tocolor = tocolor,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    manageElementForceRender = manageElementForceRender,
    unpackColor = unpackColor,
    dxSetRenderTarget = dxSetRenderTarget,
    dxDrawText = dxDrawText
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_label"


---------------------------------
--[[ Function: Renders Label ]]--
---------------------------------

function renderLabel(element, isActiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not elementReference.isValid or not elementReference.isVisible then return false end

    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementToBeRendered, isElementToBeForceRendered = false, false
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)

        if (elementReference.gui.width > 0) and (elementReference.gui.height > 0) then
            isElementToBeRendered = true
        end

        if not isElementToBeRendered then return false end
        if (isActiveMode or isElementToBeReloaded) and isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Label"] then
                elementReference.gui["__UI_CACHE__"]["Label"] = {
                    offsets = {},
                    text = {
                        offsets = {}
                    }
                }
            end
            elementReference.gui["__UI_CACHE__"]["Label"].offsets.startX = elementReference.gui.x
            elementReference.gui["__UI_CACHE__"]["Label"].offsets.startY = elementReference.gui.y
            elementReference.gui["__UI_CACHE__"]["Label"].offsets.width = elementReference.gui.width
            elementReference.gui["__UI_CACHE__"]["Label"].offsets.height = elementReference.gui.height
            elementReference.gui["__UI_CACHE__"]["Label"].text.text = elementReference.gui.text
            if isElementToBeReloaded then
                elementReference.gui["__UI_CACHE__"]["Label"].text.fontColor = imports.tocolor(imports.unpackColor(elementReference.gui.fontColor or elementTemplate.fontColor))
            end
            elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startX = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startY = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startY + (elementTemplate.fontPaddingY or 0)
            elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endX = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startX + elementReference.gui["__UI_CACHE__"]["Label"].offsets.width
            elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endY = elementReference.gui["__UI_CACHE__"]["Label"].offsets.startY + elementReference.gui["__UI_CACHE__"]["Label"].offsets.height
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        imports.dxDrawText(elementReference.gui["__UI_CACHE__"]["Label"].text.text, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startX, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.startY, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endX, elementReference.gui["__UI_CACHE__"]["Label"].text.offsets.endY, elementReference.gui["__UI_CACHE__"]["Label"].text.fontColor, elementTemplate.fontScale or 1, elementTemplate.font, elementReference.gui.alignment.horizontal, elementReference.gui.alignment.vertical, true, false, elementReference.gui.postGUI, false)
        if isActiveMode then
            imports.manageElementForceRender(element, isElementToBeForceRendered)
        end
    end
    return true

end