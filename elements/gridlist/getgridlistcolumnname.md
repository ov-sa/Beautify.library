---
description: Retrieves specified column's name from the gridlist.
---

# getColumnName

## **Syntax:**

```lua
name getGridlistColumnName(gridlist, column)
```

#### _**\#Counterpart:**_ [_**setGridlistColumnName**_](setgridlistcolumnname.md)

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

![](../../.gitbook/assets/getgridlistcolumnname.png)

