---
description: Sets specified column's name within the gridlist.
---

# setGridlistColumnName

## **Syntax:**

```lua
state setGridlistColumnName(gridlist, column, name)
```

#### _**\#Counterpart:**_ [_**getGridlistColumnName**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/getgridlistcolumnname/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to update the column name of.
* **column** \(int\) : Index of the column you wish to update.
* **name** \(string\) : Name of the column.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.setGridlistColumnName(createdGridlist, 1, "Serial")
print(tostring(resultState))
```

