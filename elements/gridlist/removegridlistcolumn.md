---
description: Removes a specified column from the gridlist.
---

# removeGridlistColumn

## **Syntax:**

```lua
state removeGridlistColumn(gridlist, column)
```

#### _**\#Counterpart:**_ [_**addGridlistColumn**_](addgridlistcolumn.md)

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

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/6acabc0cbcb0620b5fffa0b9fafb65273c38dc19/elements/gridlist/snaps/APIs/removeGridlistColumn.png)

