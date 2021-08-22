---
description: Removes a specified row from the gridlist.
---

# removeRow

## **Syntax:**

```lua
state removeRow(gridlist, row)
```

#### _**\#Counterpart:**_ [_**addRow**_](addgridlistrow.md)_\*\*\*\*_

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to remove the row from.
* **row** \(int\) : Index of the row you wish to remove.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.removeRow(createdGridlist, 1)
print(tostring(resultState))
```

![](../../.gitbook/assets/removegridlistrow.png)
