---
description: Sets the text of the selector.
---

# setText

## **Syntax:**

```lua
state setText(selector, text)
```

#### _**\#Counterpart:**_ [_**getText**_](getselectortext.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to set the text of.
* **text** \(string\) : Text of the selector.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.setText(createdSelector, "Ethnicity")
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/b2e36834261af71a665ec1a224f61083bd351509/.gitbook/assets/setselectortext.png)

