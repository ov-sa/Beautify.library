---
description: Retrieves specified column's name from the gridlist.
---

# getGridlistColumnName

## **Syntax:**

```lua
name getGridlistColumnName(gridlist, column)
```

#### _**\#Counterpart:**_ [_**setGridlistColumnName**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/setgridlistcolumnname/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the column name of.
* **column** \(int\) : Index of the column you wish to retrieve the name of.

### **Returns:**

* **name** \(string\) : Name of the column.

## **Example:**

```lua
local columnName= beautify.gridlist.getGridlistColumnName(createdGridlist, 1)
print(columnName)
```

