----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: handlers: renderer: deckpane.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Deck Pane Pane's Renderer ]]--
----------------------------------------------------------------


-----------------
--[[ Imports ]]--
-----------------

local imports = {
    isElement = isElement,
    getUIParent = getUIParent,
    __getUITemplate = __getUITemplate,
    manageElementForceRender = manageElementForceRender,
    renderElementChildren = renderElementChildren,
    renderScrollbar = renderScrollbar,
    isMouseOnPosition = isMouseOnPosition,
    dxSetRenderTarget = dxSetRenderTarget,
    dxSetBlendMode = dxSetBlendMode,
    dxDrawImage = dxDrawImage
}


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_deckpane"


--------------------------------
--[[ Function: Renders Deck Pane ]]--
--------------------------------

function renderDeckPane(element, isActiveMode, isFetchingInput, mouseReference)

    local elementReference = createdElements[element]
    if not isFetchingInput then
        local elementParent = imports.getUIParent(element)
        if not elementParent then imports.dxSetRenderTarget() end
        local isElementToBeRendered, isElementToBeForceRendered = true, false
        local isElementInterpolationToBeRefreshed = CLIENT_MTA_RESTORED
        local isElementToBeReloaded = (not CLIENT_MTA_MINIMIZED) and (elementReference.gui["__UI_CACHE__"].reloadElement or (CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)] and CLIENT_RESOURCE_TEMPLATE_RELOAD[(elementReference.sourceResource)][elementType]))
        local isElementToBeUpdated = isElementToBeReloaded or elementReference.gui["__UI_CACHE__"].updateElement or CLIENT_MTA_RESTORED
        local elementTemplate = imports.__getUITemplate(elementType, elementReference.sourceResource)

        if not isElementToBeRendered then return false end
        if (isActiveMode or isElementToBeReloaded) and isElementToBeUpdated then
            if not elementReference.gui["__UI_CACHE__"]["Deckpane"] then
                elementReference.gui["__UI_CACHE__"]["Deckpane"] = {
                    offsets = {},
                    view = {
                        offsets = {
                            offsetY = 0
                        }
                    }
                }
            end
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startX = elementReference.gui.x
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startY = elementReference.gui.y
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.width = elementReference.gui.width
            elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.height = elementReference.gui.height
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startX = elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startX
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startY = elementReference.gui["__UI_CACHE__"]["Deckpane"].offsets.startY
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.width = elementReference.gui.viewSection.width
            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height = elementReference.gui.viewSection.height
            if not CLIENT_MTA_MINIMIZED then
                elementReference.gui["__UI_CACHE__"].reloadElement = nil
            end
            elementReference.gui["__UI_CACHE__"].updateElement = nil
        end

        if isActiveMode then
            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"] = {}
        end
        if elementReference.gui.renderTarget and imports.isElement(elementReference.gui.renderTarget) then
            if isActiveMode then
                local isScrollerComponentToBeRendered = false
                if #elementReference.renderIndexReference[(elementReference.renderIndex)].children > 0 then
                    local lastDeckReference = createdElements[(elementReference.renderIndexReference[(elementReference.renderIndex)].children[(#elementReference.renderIndexReference[(elementReference.renderIndex)].children)].element)]
                    if lastDeckReference.gui["__UI_CACHE__"] and lastDeckReference.gui["__UI_CACHE__"]["Deck"] then
                        local deckpane_data_height = lastDeckReference.gui["__UI_CACHE__"]["Deck"].offsets.startY + (lastDeckReference.gui.currentHeight or 0)
                        local deckpane_exceeded_height = deckpane_data_height - elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height
                        if deckpane_exceeded_height > 0 then
                            elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsetY = deckpane_exceeded_height*elementReference.gui.scrollBar_Vertical.currentPercent*0.01
                            elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"] = {
                                {
                                    isDisabled = elementReference.isDisabled,
                                    elementReference = elementReference,
                                    startX = elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.width,
                                    startY = 0,
                                    height = elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height,
                                    overflownSize = deckpane_exceeded_height,
                                    multiplier = lastDeckReference.gui["__UI_CACHE__"]["Title Bar"].offsets.height,
                                    postGUI = false
                                },
                                elementReference.gui.scrollBar_Vertical
                            }
                            isElementToBeForceRendered = isElementToBeForceRendered or imports.renderScrollbar(element, false, false, false, false, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][2], false, true)
                            isScrollerComponentToBeRendered = true
                        end
                    end
                end
                if not isScrollerComponentToBeRendered then
                    local isScrollerToBeResetted = elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsetY ~= 0
                    isElementToBeForceRendered = isElementToBeForceRendered or isScrollerToBeResetted
                    elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsetY = 0
                end
                imports.manageElementForceRender(element, isElementToBeForceRendered)
                imports.renderElementChildren(element, isActiveMode)
                local isElementBeingForceRendered = false
                if elementReference.rootElement then
                    isElementBeingForceRendered = (CLIENT_ELEMENT_FORCE_RENDERED[(elementReference.rootElement)] and CLIENT_ELEMENT_FORCE_RENDERED[(elementReference.rootElement)].renderChildren[element]) or isElementBeingForceRendered
                else
                    isElementBeingForceRendered = CLIENT_ELEMENT_FORCE_RENDERED[element] or isElementBeingForceRendered
                end
                if isScrollerComponentToBeRendered then
                    imports.dxSetRenderTarget(elementReference.gui.renderTarget)
                    imports.dxSetBlendMode("modulate_add")
                    imports.renderScrollbar(element, isElementBeingForceRendered, false, isElementBeingForceRendered, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][2], false)
                end
                imports.dxSetBlendMode("blend")
                if not elementParent then
                    imports.dxSetRenderTarget()
                else
                    imports.dxSetRenderTarget(createdElements[elementParent].gui.renderTarget)
                end
            end
            imports.dxDrawImage(elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startX, elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.startY, elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.width, elementReference.gui["__UI_CACHE__"]["Deckpane"].view.offsets.height, elementReference.gui.renderTarget, 0, 0, 0, -1, elementReference.gui.postGUI)
        end
    else
        local __mouseReference = {x = mouseReference.x, y = mouseReference.y}
        imports.renderElementChildren(element, isActiveMode, true, mouseReference)
        local deckpane_children_count = #elementReference.renderIndexReference[(elementReference.renderIndex)].children
        if deckpane_children_count > 0 then
            local isElementHovered = CLIENT_HOVERED_ELEMENT.element and ((CLIENT_HOVERED_ELEMENT.element == element) or createdElements[element].children[(CLIENT_HOVERED_ELEMENT.element)])
            if isElementHovered and elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"] then
                imports.renderScrollbar(element, false, false, false, elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][1], elementReference.gui["__UI_INPUT_FETCH_CACHE__"]["Scroll Bars"]["Vertical"][2], true)
            end
        end
    end
    return true

end