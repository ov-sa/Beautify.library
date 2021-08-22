---
description: Retrieves selected data from the selector.
---

# getSelection

## **Syntax:**

```lua
data getSelection(selector)
```

#### _**\#Counterpart:**_ [_**setSelection**_](setselectorselection.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to retrieve the selection of.

### **Returns:**

* **data** \(int\) : Index of the selected data.

## **Example:**

```lua
local selectorSelection = beautify.selector.getSelection(createdSelector)
print(selectorSelection)
```

![](../../.gitbook/assets/getselectorselection.png)

