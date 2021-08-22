---
description: Sets the data-list of the selector.
---

# setDataList

## **Syntax:**

```lua
state setDataList(selector, datalist)
```

#### _**\#Counterpart:**_ [_**getDataList**_](getselectortext.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to set the text of.
* **text** \(string\) : Text of the selector.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.setText(createdSelector, "My First Selector #1")
print(tostring(resultState))
```

![](../../.gitbook/assets/setselectortext.png)

