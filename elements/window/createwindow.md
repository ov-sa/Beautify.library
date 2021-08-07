---
description: >-
  Creates a new blank window which can be further used as a container for other
  elements.
---

# createWindow

## **Syntax:**

```lua
window createWindow(x, y, width, height, title, [parent = nil], [postGUI = false])
```

### **Parameters:**

* **x** \(float\) : Absolute x coordinate of the window within the container.
* **y** \(float\) : Absolute y coordinate of the window within the container.
* **width** \(float\) : Absolute width of the window.
* **height** \(float\) : Absolute height of the window.
* **title** \(string\) : Title of the window.
* **parent** \(element\) : Supported parent element to use as a container for the window. \(_Optional_\)
* **postGUI** \(bool\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)

### **Returns:**

* **window** \(element\) : Created window element.

## **Example:**

```lua
local sX, sY = guiGetScreenSize()
local window_width, window_height = 600, 300
local createdWindow = beautify.window.createWindow((sX - window_width)/2, (sY - window_height)/2, window_width, window_height, "Window #1", nil, false)
beautify.setUIDraggable(createdWindow, true)
beautify.setUIVisible(createdWindow, true)
```

![](../../.gitbook/assets/elements/window/createwindow.png)

