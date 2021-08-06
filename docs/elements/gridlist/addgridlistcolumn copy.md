---
description: >-
  Removes specified column from the gridlist.
---

## **Syntax:**

```lua
state removeGridlistColumn(gridlist, column)
```

#### _**\#Counterpart:**_ [_**addGridlistColumn**_](addgridlistcolumn)

### **Parameters:**

* **gridlist** \(_element_\) : Gridlist element you wish to remove the column from.
* **column** \(_int_\) : Index of the column you wish to remove.

### **Returns:**

* **state** \(_bool_\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.removeGridlistColumn(createdGridlist, 1)
print(tostring(resultState))
```