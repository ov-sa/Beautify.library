---
description: Sets the text of the button.
---

# setText

## **Syntax:**

```lua
state setText(button, text)
```

#### _**\#Counterpart:**_ [_**getText**_](getbuttontext.md)

### **Parameters:**

* **button** \(element\) : Button element you wish to set the text of.
* **text** \(string\) : Text of the button.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.button.setText(createdButton, "My First Button #1")
print(tostring(resultState))
```

![](../../.gitbook/assets/setbuttontext.png)

