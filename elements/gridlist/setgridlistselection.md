---
description: Selects specified row from the gridlist.
---

# setGridlistSelection

## **Syntax:**

```lua
state setGridlistSelection(gridlist, row)
```

#### _**\#Counterpart:**_ [_**getGridlistSelection**_](getgridlistselection.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to select the row of.
* **row** \(int\) : Index of the row you wish to be selected.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.setGridlistSelection(createdGridlist, 1)
print(tostring(resultState))
```

