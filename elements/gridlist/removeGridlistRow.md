---
description: Removes a specified row from the gridlist.
---

# removeGridlistRow

## **Syntax:**

```lua
state removeGridlistRow(gridlist, row)
```

#### _**\#Counterpart:**_ [_**addGridlistRow**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/addGridlistRow/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to remove the row from.
* **row** \(int\) : Index of the row you wish to remove.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.removeGridlistRow(createdGridlist, 1)
print(tostring(resultState))
```

