----------------------------------------------------------------
--[[ Resource: Beautify Library (Example) 
     Script: gui: ui_2.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 14/08/2021 (OvileAmriam)
     Desc: Example UI ]]--
----------------------------------------------------------------


----------------------
-->> Example UI 2 <<--
----------------------

function createExampleUI2()

    local window_width, window_height = 275, 350
    local createdWindow = beautify.window.create(725 + 25, (CLIENT_MTA_RESOLUTION[2] - window_height)/2, window_width, window_height, "Dev. UI #2", nil, false)
    
    local createdSlider = beautify.slider.create(12.5, 12.5, 250, 28, "horizontal", createdWindow, false)
    local createdSlider2 = beautify.slider.create(12.5, 52, 250, 28, "horizontal", createdWindow, false)
    local createdSlider3 = beautify.slider.create(12.5, 91.5, 250, 28, "horizontal", createdWindow, false)
    local createdSlider4 = beautify.slider.create(12.5, 131, 250, 28, "horizontal", createdWindow, false)
    local createdSlider5 = beautify.slider.create(12.5, 170.5, 250, 28, "horizontal", createdWindow, false)
    beautify.slider.setText(createdSlider, "VOLUME")
    beautify.slider.setText(createdSlider2, "VISIBILITY")
    beautify.slider.setText(createdSlider3, "DRAW DISTANCE")
    beautify.slider.setText(createdSlider4, "FIELD OF VIEW")
    beautify.slider.setText(createdSlider5, "GAMEPLAY SOUNDS")
    beautify.slider.setPercent(createdSlider, math.random(0, 100))
    beautify.slider.setPercent(createdSlider2, math.random(0, 100))
    beautify.slider.setPercent(createdSlider3, math.random(0, 100))
    beautify.slider.setPercent(createdSlider4, math.random(0, 100))
    beautify.slider.setPercent(createdSlider5, math.random(0, 100))
    beautify.setUIVisible(createdSlider, true)
    beautify.setUIVisible(createdSlider2, true)
    beautify.setUIVisible(createdSlider3, true)
    beautify.setUIVisible(createdSlider4, true)
    beautify.setUIVisible(createdSlider5, true)

    local createdSlider6 = beautify.slider.create(64.75, 200.5, 28, 140, "vertical", createdWindow, false)
    local createdSlider7 = beautify.slider.create(104.25, 200.5, 28, 140, "vertical", createdWindow, false)
    local createdSlider8 = beautify.slider.create(143.75, 200.5, 28, 140, "vertical", createdWindow, false)
    local createdSlider9 = beautify.slider.create(183.25, 200.5, 28, 140, "vertical", createdWindow, false)
    beautify.slider.setText(createdSlider6, "H-SENSITIVITY")
    beautify.slider.setText(createdSlider7, "V-SENSITIVITY")
    beautify.slider.setText(createdSlider8, "AMBIENCE")
    beautify.slider.setText(createdSlider9, "OVERLAYS")
    beautify.slider.setPercent(createdSlider6, math.random(0, 100))
    beautify.slider.setPercent(createdSlider7, math.random(0, 100))
    beautify.slider.setPercent(createdSlider8, math.random(0, 100))
    beautify.slider.setPercent(createdSlider9, math.random(0, 100))
    beautify.setUIVisible(createdSlider6, true)
    beautify.setUIVisible(createdSlider7, true)
    beautify.setUIVisible(createdSlider8, true)
    beautify.setUIVisible(createdSlider9, true)

    beautify.setUIVisible(createdWindow, true)
    beautify.setUIDraggable(createdWindow, true)

end