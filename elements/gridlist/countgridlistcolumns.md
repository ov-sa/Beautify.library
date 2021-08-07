---
description: Counts and retrieves the number of columns within the gridlist.
---

# countGridlistColumns

## **Syntax:**

```lua
count countGridlistColumns(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistRows**_](countgridlistrows.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the column count of.

### **Returns:**

* **count** \(int\) : Number of columns.

## **Example:**

```lua
local totalColumns = beautify.gridlist.countGridlistColumns(createdGridlist)
print(totalColumns)
```

