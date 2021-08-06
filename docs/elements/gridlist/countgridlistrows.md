---
description: >-
  Counts and retrieves number of rows within the gridlist.
---

## **Syntax:**

```lua
count countGridlistRows(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistColumns**_](countgridlistcolumns)

### **Parameters:**
  
* **gridlist** \(element\) : Gridlist element you wish to retrieve the row count of.

### **Returns:**

* **count** \(int\) : Number of rows.

## **Example:**

```lua
local totalRows = beautify.gridlist.countGridlistRows(createdGridlist)
print(totalRows )
```