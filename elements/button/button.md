## ━ setButtonText
Sets the text of your button.
### **Syntax:**
```lua
state setButtonText(button, text)
```

#### _**\#Counterpart:**_ [_**getButtonText**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-getButtonText)

* **Parameters:**
  * **button** \(_element_\) : Button element you wish to set the text of.
  * **text** \(_string_\) : Text of the button.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

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

#### _**\#Counterpart:**_ [_**setButtonText**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Button#-setButtonText)

* **Parameters:**
  * **button** \(_element_\) : Button element you wish to retrieve the text of.
* **Returns:**
  * **text** \(_string_\) : Text of the button.
* **Example:**

  ```lua
  local buttonText = beautify.button.getButtonText(createdButton)
  print(buttonText)
  ```

