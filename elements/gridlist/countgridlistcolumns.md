---
description: Counts and retrieves the number of columns within the gridlist.
---

# countGridlistColumns

## **Syntax:**

```lua
count countGridlistColumns(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistRows**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/countgridlistrows/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the column count of.

### **Returns:**

* **count** \(int\) : Number of columns.

## **Example:**

```lua
local totalColumns = beautify.gridlist.countGridlistColumns(createdGridlist)
print(totalColumns)
```

