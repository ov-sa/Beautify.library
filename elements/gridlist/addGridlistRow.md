---
description: Adds a new row to the gridlist.
---

# addGridlistRow

## **Syntax:**

```lua
row addGridlistRow(gridlist)
```

#### _**\#Counterpart:**_ [_**removeGridlistRow**_](removeGridlistRow.md)

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
