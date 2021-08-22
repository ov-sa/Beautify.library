---
description: Selects specified data from the selector.
---

# setSelection

## **Syntax:**

```lua
state setSelection(selector, data)
```

#### _**\#Counterpart:**_ [_**getSelection**_](getselectorselection.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to select the data of.
* **data** \(int\) : Index of the data you wish to be selected.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.setSelection(createdSelector, 2)
print(tostring(resultState))
```

![](../../.gitbook/assets/setselectorselection.png)

