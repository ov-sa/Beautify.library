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