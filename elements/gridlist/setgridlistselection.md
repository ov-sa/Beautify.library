---
description: Selects specified row from the gridlist.
---

# setSelection

## **Syntax:**

```lua
state setSelection(gridlist, row)
```

#### _**\#Counterpart:**_ [_**getSelection**_](getgridlistselection.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to select the row of.
* **row** \(int\) : Index of the row you wish to be selected.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.setSelection(createdGridlist, 1)
print(tostring(resultState))
```

![](../../.gitbook/assets/setgridlistselection.png)

