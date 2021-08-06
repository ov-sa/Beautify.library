Creates a new blank window which can be further used as a container for other elements.

### **Syntax:**

```lua
window createWindow(x, y, width, height, title, [parent = nil], [postGUI = false])
```

* **Parameters:**
  * **x** \(_float_\) : Absolute x coordinate of the window within the container.
  * **y** \(_float_\) : Absolute y coordinate of the window within the container.
  * **width** \(_float_\) : Absolute width of the window.
  * **height** \(_float_\) : Absolute height of the window.
  * **title** \(_string_\) : Title of the window.
  * **parent** \(_element_\) : Supported parent element to use as a container for the window. \(_Optional_\)
  * **postGUI** \(_bool_\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)
* **Returns:**
  * **window** \(_element_\) : Created window element.
* **Example:**

  ```lua
  local sX, sY = guiGetScreenSize()
  local window_width, window_height = 600, 300
  local createdWindow = beautify.window.createWindow((sX - window_width)/2, (sY - window_height)/2, window_width, window_height, "Window #1", nil, false)
  beautify.setUIDraggable(createdWindow, true)
  beautify.setUIVisible(createdWindow, true)
  ```

