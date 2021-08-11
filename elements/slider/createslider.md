---
description: >-
  Creates a new slider which can be further used to bind your functions/datas
  on.
---

# createSlider

## **Syntax:**

```lua
slider createSlider(x, y, width, height, type, [parent = nil], [postGUI = false])
```

### **Parameters:**

* **x** \(float\) : Absolute x coordinate of the slider within the container.
* **y** \(float\) : Absolute y coordinate of the slider within the container.
* **width** \(float\) : Absolute width of the slider.
* **height** \(float\) : Absolute height of the slider.
* **type** \(string\) : Type of slider \(horizontal\vertical\).
* **parent** \(element\) : Supported parent element to use as a container for the slider. \(_Optional_\)
* **postGUI** \(bool\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)

### **Returns:**

* **slider** \(element\) : Created slider element.

## **Example:**

```lua
local sX, sY = guiGetScreenSize()
local slider_width, slider_height = 300, 50
local createdSlider = beautify.slider.createSlider((sX - slider_width)/2, (sY - slider_height)/2, slider_width, slider_height, "horizontal", nil, false)
beautify.setUIVisible(createdSlider, true)
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8ab024377726be289b02b4cc09c68c74dbaaf367/.gitbook/assets/createslider.png)

