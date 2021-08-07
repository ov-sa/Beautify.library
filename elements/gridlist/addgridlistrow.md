---
description: Adds a new row to the gridlist.
---

# addGridlistRow

## **Syntax:**

```lua
row addGridlistRow(gridlist)
```

#### _**\#Counterpart:**_ [_**removeGridlistRow**_](removegridlistrow.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to add the row in.

### **Returns:**

* **row** \(int\) : Added row's index.

## **Example:**

```lua
local rowIndex1 = beautify.gridlist.addGridlistRow(createdGridlist)
local rowIndex2 = beautify.gridlist.addGridlistRow(createdGridlist)
local rowIndex3 = beautify.gridlist.addGridlistRow(createdGridlist)
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/6acabc0cbcb0620b5fffa0b9fafb65273c38dc19/elements/gridlist/snaps/APIs/addGridlistRow.png)

