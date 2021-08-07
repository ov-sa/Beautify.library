---
description: Sets the vertical alignment of the label.
---

# setLabelVerticalAlignment

## **Syntax:**

```lua
state setLabelVerticalAlignment(label, alignment)
```

#### _**\#Counterpart:**_ [_**getLabelVerticalAlignment**_](getlabelverticalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to set the vertical alignment of.
* **alignment** \(string\) : Vertical alignment of the label \(Top/Center/Bottom\).

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.label.setLabelVerticalAlignment(createdLabel, "center")
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa0a436b55c8c25e32ea12d83b59a5808b2c3af2/.gitbook/assets/setlabelverticalalignment.png)

