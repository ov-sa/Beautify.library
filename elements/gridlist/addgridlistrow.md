---
description: Adds a new row to the gridlist.
---

# addRow

## **Syntax:**

```lua
row addRow(gridlist)
```

#### _**\#Counterpart:**_ [_**removeRow**_](removegridlistrow.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to add the row in.

### **Returns:**

* **row** \(int\) : Added row's index.

## **Example:**

```lua
local rowIndex1 = beautify.gridlist.addRow(createdGridlist)
local rowIndex2 = beautify.gridlist.addRow(createdGridlist)
local rowIndex3 = beautify.gridlist.addRow(createdGridlist)
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/b3f243cf817f9422df44925b004bc3e64988621f/.gitbook/assets/addRow.png)

