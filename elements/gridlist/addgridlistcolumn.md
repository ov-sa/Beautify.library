---
description: Adds a new column to the gridlist.
---

# addColumn

## **Syntax:**

```lua
column addColumn(gridlist, name, width)
```

#### _**\#Counterpart:**_ [_**removeColumn**_](removegridlistcolumn.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to add the column in.
* **name** \(string\) : Name of the column.
* **width** \(float\) : Absolute width of the column.

### **Returns:**

* **column** \(int\) : Added column's index.

## **Example:**

```lua
local columnIndex1 = beautify.gridlist.addColumn(createdGridlist, "S.No", 75)
local columnIndex2 = beautify.gridlist.addColumn(createdGridlist, "Name", 250)
local columnIndex3 = beautify.gridlist.addColumn(createdGridlist, "Country", 100)
local columnIndex4 = beautify.gridlist.addColumn(createdGridlist, "Rank", 250)
```

![](../../.gitbook/assets/addgridlistcolumn.png)
