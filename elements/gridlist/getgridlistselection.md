---
description: Retrieves selected row from the gridlist.
---

# getSelection

## **Syntax:**

```lua
row getSelection(gridlist)
```

#### _**\#Counterpart:**_ [_**setSelection**_](setgridlistselection.md)

### **Parameters:**

* **gridlist** \(element\) : Gridlist element you wish to retrieve the selection of.

### **Returns:**

* **row** \(int\) : Index of the selected row.

## **Example:**

```lua
local gridlistSelection = beautify.gridlist.getSelection(createdGridlist)
print(gridlistSelection)
```

![](../../.gitbook/assets/getgridlistselection.png)

