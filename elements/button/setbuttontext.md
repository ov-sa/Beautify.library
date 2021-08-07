---
description: Sets the text of the button.
---

# setButtonText

## **Syntax:**

```lua
state setButtonText(button, text)
```

#### _**\#Counterpart:**_ [_**getButtonText**_](getbuttontext.md)

### **Parameters:**

* **button** \(element\) : Button element you wish to set the text of.
* **text** \(string\) : Text of the button.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.button.setButtonText(createdButton, "My First Button #1")
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/93385f1e523e89dcaee8f9c7733d29a48ad4519e/.gitbook/assets/elements/button/api/setbuttontext.png)

