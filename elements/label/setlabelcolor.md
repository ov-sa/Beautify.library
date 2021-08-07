---
description: Sets the color of the label.
---

# setLabelColor

## **Syntax:**

```lua
state setLabelColor(label, color)
```

#### _**\#Counterpart:**_ [_**getLabelColor**_](getlabelcolor.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to set the color of.
* **color** \(table\) : Table containing color of the label.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.label.setLabelColor(createdLabel, {255, 0, 0, 255})
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa0a436b55c8c25e32ea12d83b59a5808b2c3af2/.gitbook/assets/setlabelcolor.png)

