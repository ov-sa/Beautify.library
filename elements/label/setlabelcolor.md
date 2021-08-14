---
description: Sets the color of the label.
---

# setColor

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

![](../../.gitbook/assets/setlabelcolor.png)

