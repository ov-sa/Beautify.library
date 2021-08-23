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

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/6adf777fcae5634a6287a4566898e862fd33c352/.gitbook/assets/getselectorselection.png)

