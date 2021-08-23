---
description: Sets the list of the selector.
---

# setDataList

## **Syntax:**

```lua
state setDataList(selector, list)
```

#### _**\#Counterpart:**_ [_**getDataList**_](getselectordatalist.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to set the list of.
* **list** \(table\) : Table containing the datas of the selector.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local selector_dataList = {
    "American",
    "Asian",
    "Arab",
    "African" 
}
local resultState = beautify.selector.setDataList(createdSelector, selector_dataList)
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/63ce80a583f0a48548c507530434e109f236aef7/.gitbook/assets/setselectordatalist.png)

