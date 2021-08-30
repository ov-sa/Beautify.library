----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: gui: ui_6.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Example UI ]]--
----------------------------------------------------------------


----------------------
-->> Example UI 6 <<--
----------------------

function createExampleUI6()

    local window_width, window_height = 275, 700
    local createdWindow = beautify.window.create(25, (CLIENT_MTA_RESOLUTION[2] - window_height)/2 - 20, window_width, window_height, "Dev. UI #6", nil, false)

    local createdDeckPane = beautify.deckpane.create(0, 0, window_width, window_height, createdWindow, false)
    local deck_width, deck_height = window_width - 10, 125
    for i = 1, 4, 1 do
        local createdDeck = beautify.deck.create(0, ((deck_height + 32 + 5)*(i - 1)), deck_height, "Deck #"..i, createdDeckPane, false)
        beautify.setUIVisible(createdDeck, true)
    end
    beautify.setUIVisible(createdDeckPane, true)

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

end