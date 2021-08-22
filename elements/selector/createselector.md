---
description: >-
  Creates a new selector which can be further used to select a data from your
  data-list.
---

# create

## **Syntax:**

```lua
selector create(x, y, width, height, type, [parent = nil], [postGUI = false])
```

### **Parameters:**

* **x** \(float\) : Absolute x coordinate of the selector within the container.
* **y** \(float\) : Absolute y coordinate of the selector within the container.
* **width** \(float\) : Absolute width of the selector.
* **height** \(float\) : Absolute height of the selector.
* **type** \(string\) : Type of selector \(horizontal\vertical\).
* **parent** \(element\) : Supported parent element to use as a container for the selector. \(_Optional_\)
* **postGUI** \(bool\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)

### **Returns:**

* **selector** \(element\) : Created selector element.

## **Example:**

```lua
local sX, sY = guiGetScreenSize()
local selector_width, selector_height = 28, 140
local createdSelector = beautify.selector.create((sX - selector_width)/2, (sY - selector_height)/2, selector_width, selector_height, "horizontal", nil, false)
beautify.setUIVisible(createdSelector, true)
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa59a1b6c94431637be36b1cf1c57a0bfdface1a/.gitbook/assets/createselector.png)

