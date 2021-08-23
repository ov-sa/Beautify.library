---
description: Sets the color of the selector's text.
---

# setTextColor

## **Syntax:**

```lua
state setTextColor(selector, color)
```

#### _**\#Counterpart:**_ [_**getTextColor**_](getselectortextcolor.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to set the text color of.
* **color** \(table\) : Table containing color of the selector's text.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.setTextColor(createdSelector, {255, 0, 0, 255})
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/dc68dea0ce4122d4b75970aa60f07f5277f6884f/.gitbook/assets/setselectortextcolor.png)

