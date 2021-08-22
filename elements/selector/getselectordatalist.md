---
description: Retrieves the list of the selector.
---

# getDataList

## **Syntax:**

```lua
list getDataList(selector)
```

#### _**\#Counterpart:**_ [_**setDataList**_](setselectordatalist.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to retrieve the list of.

### **Returns:**

* **list** \(table\) : Table containing the datas of the selector.

## **Example:**

```lua
local selectorDataList = beautify.selector.getDataList(createdSelector)
print(toJSON(selectorDataList))
```

![](../../.gitbook/assets/getselectordatalist.png)

