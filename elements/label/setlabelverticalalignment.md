---
description: Sets the vertical alignment of the label.
---

# setVerticalAlignment

## **Syntax:**

```lua
state setVerticalAlignment(label, alignment)
```

#### _**\#Counterpart:**_ [_**getVerticalAlignment**_](getlabelverticalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to set the vertical alignment of.
* **alignment** \(string\) : Vertical alignment of the label \(top/center/bottom\).

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.label.setVerticalAlignment(createdLabel, "center")
print(tostring(resultState))
```

![](../../.gitbook/assets/setlabelverticalalignment.png)

