---
description: Sets the horizontal alignment of the label.
---

# setLabelHorizontalAlignment

## **Syntax:**

```lua
state setLabelHorizontalAlignment(label, alignment)
```

#### _**\#Counterpart:**_ [_**getLabelHorizontalAlignment**_](getlabelhorizontalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to set the horizontal alignment of.
* **alignment** \(string\) : Horizontal alignment of the label \(Left/Center/Right\).

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.label.setLabelHorizontalAlignment(createdLabel, "center")
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa0a436b55c8c25e32ea12d83b59a5808b2c3af2/.gitbook/assets/setlabelhorizontalalignment.png)

