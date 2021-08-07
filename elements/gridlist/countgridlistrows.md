---
description: Counts and retrieves the number of rows within the gridlist.
---

# countGridlistRows

## **Syntax:**

```lua
count countGridlistRows(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistColumns**_](countgridlistcolumns.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the row count of.

### **Returns:**

* **count** \(int\) : Number of rows.

## **Example:**

```lua
local totalRows = beautify.gridlist.countGridlistRows(createdGridlist)
print(totalRows)
```

![](../../.gitbook/assets/elements/gridlist/api//countgridlistrows.png)

