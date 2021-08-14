---
description: Retrieves specified row's data from the gridlist.
---

# getRowData

## **Syntax:**

```lua
data getRowData(gridlist, row, column)
```

#### _**\#Counterpart:**_ [_**setRowData**_](setgridlistrowdata.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the row data of.
* **row** \(int\) : Index of the row you wish to retrieve the data of.
* **column** \(int\) : Index of the column you wish to retrieve the data of.

### **Returns:**

* **data** \(string\) : Data of row's column.

## **Example:**

```lua
local rowData = beautify.gridlist.getRowData(createdGridlist, 1, 2)
print(rowData)
```

![](../../.gitbook/assets/getgridlistrowdata.png)

