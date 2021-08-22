---
description: Retrieves specified column's name from the gridlist.
---

# getColumnName

## **Syntax:**

```lua
name getColumnName(gridlist, column)
```

#### _**\#Counterpart:**_ [_**setColumnName**_](setgridlistcolumnname.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the column name of.
* **column** \(int\) : Index of the column you wish to retrieve the name of.

### **Returns:**

* **name** \(string\) : Name of the column.

## **Example:**

```lua
local columnName = beautify.gridlist.getColumnName(createdGridlist, 1)
print(columnName)
```

![](../../.gitbook/assets/getgridlistcolumnname.png)

