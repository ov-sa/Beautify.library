---
description: >-
  Retrieves specified row's data from the gridlist.
---

## **Syntax:**

```lua
data getGridlistRowData(gridlist, row, column)
```

#### _**\#Counterpart:**_ [_**setGridlistRowData**_](setgridlistrowdata)

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