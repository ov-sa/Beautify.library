---
description: Sets the horizontal alignment of the label.
---

# setHorizontalAlignment

## **Syntax:**

```lua
state setHorizontalAlignment(label, alignment)
```

#### _**\#Counterpart:**_ [_**getHorizontalAlignment**_](getlabelhorizontalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to set the horizontal alignment of.
* **alignment** \(string\) : Horizontal alignment of the label \(left/center/right\).

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.label.setHorizontalAlignment(createdLabel, "center")
print(tostring(resultState))
```

![](../../.gitbook/assets/setlabelhorizontalalignment.png)

