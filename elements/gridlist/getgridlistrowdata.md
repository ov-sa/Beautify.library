---
description: Retrieves specified row's data from the gridlist.
---

# getGridlistRowData

## **Syntax:**

```lua
data getGridlistRowData(gridlist, row, column)
```

#### _**\#Counterpart:**_ [_**setGridlistRowData**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/setgridlistrowdata/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the row data of.
* **row** \(int\) : Index of the row you wish to retrieve the data of.
* **column** \(int\) : Index of the column you wish to retrieve the data of.

### **Returns:**

* **data** \(string\) : Data of row's column.

## **Example:**

```lua
local rowData = beautify.gridlist.getGridlistRowData(createdGridlist, 1, 2)
print(rowData)
```

