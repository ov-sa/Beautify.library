---
description: Counts and retrieves the number of rows within the gridlist.
---

# countGridlistRows

## **Syntax:**

```lua
count countGridlistRows(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistColumns**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/countGridlistColumns/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the row count of.

### **Returns:**

* **count** \(int\) : Number of rows.

## **Example:**

```lua
local totalRows = beautify.gridlist.countGridlistRows(createdGridlist)
print(totalRows )
```

