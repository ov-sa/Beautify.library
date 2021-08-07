---
description: Sets specified row's data within the gridlist.
---

# setGridlistRowData

## **Syntax:**

```lua
state setGridlistRowData(gridlist, row, column, data)
```

#### _**\#Counterpart:**_ [_**getGridlistRowData**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/getGridlistRowData/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to update the row data of.
* **row** \(int\) : Index of the row you wish to update.
* **column** \(int\) : Index of the column you wish to update.
* **data** \(string\) : Data of row's column.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
beautify.gridlist.setGridlistRowData(createdGridlist, 1, 1, "1")
beautify.gridlist.setGridlistRowData(createdGridlist, 1, 2, "Tron")
beautify.gridlist.setGridlistRowData(createdGridlist, 1, 3, "BH")
beautify.gridlist.setGridlistRowData(createdGridlist, 1, 4, "CEO")

beautify.gridlist.setGridlistRowData(createdGridlist, 2, 1, "2")
beautify.gridlist.setGridlistRowData(createdGridlist, 2, 2, "Aviril")
beautify.gridlist.setGridlistRowData(createdGridlist, 2, 3, "US")
beautify.gridlist.setGridlistRowData(createdGridlist, 2, 4, "CEO")

beautify.gridlist.setGridlistRowData(createdGridlist, 3, 1, "3")
beautify.gridlist.setGridlistRowData(createdGridlist, 3, 2, "Mario")
beautify.gridlist.setGridlistRowData(createdGridlist, 3, 3, "BH")
beautify.gridlist.setGridlistRowData(createdGridlist, 3, 4, "CEO")
```

