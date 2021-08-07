---
description: Retrieves selected row from the gridlist.
---

# getGridlistSelection

## **Syntax:**

```lua
row getGridlistSelection(gridlist)
```

#### _**\#Counterpart:**_ [_**setGridlistSelection**_](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/8b32a1354f437b84b8192867c66f498a0fc3cd85/docs/elements/gridlist/setGridlistSelection/README.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the selection of.

### **Returns:**

* **row** \(int\) : Index of the selected row.

## **Example:**

```lua
local resultState = beautify.gridlist.getGridlistSelection(createdGridlist)
print(resultState)
```

