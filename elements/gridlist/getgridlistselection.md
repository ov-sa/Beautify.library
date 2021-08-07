---
description: Retrieves selected row from the gridlist.
---

# getGridlistSelection

## **Syntax:**

```lua
row getGridlistSelection(gridlist)
```

#### _**\#Counterpart:**_ [_**setGridlistSelection**_](setgridlistselection.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the selection of.

### **Returns:**

* **row** \(int\) : Index of the selected row.

## **Example:**

```lua
local resultState = beautify.gridlist.getGridlistSelection(createdGridlist)
print(resultState)
```

<img src="snaps/APIs/getGridlistSelection.png" alt=""/>