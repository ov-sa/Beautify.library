---
description: >-
  Creates a new blank gridlist which can be further used to list your datas.
---

## **Syntax:**

```lua
gridlist createGridlist(x, y, width, height, [parent = nil], [postGUI = false])
```

### **Parameters:**

* **x** \(_float_\) : Absolute x coordinate of the gridlist within the container.
* **y** \(_float_\) : Absolute y coordinate of the gridlist within the container.
* **width** \(_float_\) : Absolute width of the gridlist.
* **height** \(_float_\) : Absolute height of the gridlist.
* **parent** \(_element_\) : Supported parent element to use as a container for the gridlist. \(_Optional_\)
* **postGUI** \(_bool_\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)

### **Returns:**

* **gridlist** \(_element_\) : Created gridlist element.

## **Example:**

```lua
local sX, sY = guiGetScreenSize()
local window_width, window_height = 600, 300
local createdWindow = beautify.window.createWindow((sX - window_width)/2, (sY - window_height)/2, window_width, window_height, "Window #1", nil, false)
local createdGridlist = beautify.gridlist.createGridlist(0, 0, window_width, window_height, createdWindow, false)
beautify.setUIDraggable(createdWindow, true)
beautify.setUIVisible(createdWindow, true)
beautify.setUIVisible(createdGridlist, true)
```