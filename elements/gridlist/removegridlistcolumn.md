---
description: Removes a specified column from the gridlist.
---

# removeColumn

## **Syntax:**

```lua
state removeColumn(gridlist, column)
```

#### _**\#Counterpart:**_ [_**addColumn**_](addgridlistcolumn.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to remove the column from.
* **column** \(int\) : Index of the column you wish to remove.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.gridlist.removeColumn(createdGridlist, 1)
print(tostring(resultState))
```

![](../../.gitbook/assets/removegridlistcolumn.png)

