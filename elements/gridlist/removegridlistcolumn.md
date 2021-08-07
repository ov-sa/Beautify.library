---
description: Removes a specified column from the gridlist.
---

# removeGridlistColumn

## **Syntax:**

```lua
state removeGridlistColumn(gridlist, column)
```

#### _**\#Counterpart:**_ [_**addGridlistColumn**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/addGridlistColumn/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to remove the column from.
* **column** \(int\) : Index of the column you wish to remove.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.removeGridlistColumn(createdGridlist, 1)
print(tostring(resultState))
```

