***

## ━ Properties:
  - **Reference:** `button`
  - **isDraggable:** `false`
  - **Allowed Children:** -

## ━ Types:
  - **Default**
    - **Type:** `default`
    - **Additional Parameters:**
      - **width** (_float_) : Absolute width of the button.
      - **height** (_float_) : Absolute height of the button.

## ━ APIs:
* [createButton](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-createButton)
* [setButtonText](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-setButtonText)
* [getButtonText](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-getButtonText)

***

## ━ createButton
Creates a new blank button which can be further used to bind your events on.
### **Syntax:** 
```lua
button createButton(text, x, y, type, ...Template_Parameters..., [parent = nil], [postGUI = false])
```
- ### **Parameters:**
  - **x** (_float_) : Absolute x coordinate of the button within the container.
  - **y** (_float_) : Absolute y coordinate of the button within the container.
  - **type** (_string_) : Type of button.
  - **Template_Parameters** : Refer to [Button Types](#).
  - **parent** (_element_) : Supported parent element to use as a container for the button. (_Optional_)
  - **postGUI** (_bool_) : State whether the UI will be drawn below/over CEGUI. (_Optional_)
- ### **Returns:**
  - **button** (_element_) : Created button element.
- ### **Example:**
```lua
local sX, sY = guiGetScreenSize()
local button_width, button_height = 175, 24
local createdButton = beautify.button.createButton("Button #1", (sX - button_width)/2, (sY - button_height)/2, "default", button_width, button_height, nil, false)
beautify.setUIVisible(createdButton, true)

addEventHandler("onClientUIClick", createdButton, function(key)
    print("You've clicked your button! (Key: "..key..")")
end)
```

## ━ setButtonText
Sets the text of your button.
### **Syntax:**
```lua
state setButtonText(button, text)
```
##### _**#Counterpart: [getButtonText](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-getButtonText)**_
- ### **Parameters:**
  - **button** (_element_) : Button element you wish to set the text of.
  - **text** (_string_) : Text of the button.
- ### **Returns:**
  - **state** (_bool_) : Execution state.
- ### **Example:**
```lua
local resultState = beautify.button.setButtonText(createdButton, "My First Button #1")
print(tostring(resultState))
```

## ━ getButtonText
Retrieves the text of your button.
### **Syntax:**
```lua
text getButtonText(button)
```
##### _**#Counterpart: [setButtonText](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-setButtonText)**_
- ### **Parameters:**
  - **button** (_element_) : Button element you wish to retrieve the text of.
- ### **Returns:**
  - **text** (_string_) : Text of the button.
- ### **Example:**
```lua
local buttonText = beautify.button.getButtonText(createdButton)
print(buttonText)
```