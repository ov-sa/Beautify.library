---
description: Retrieves the color of the selector's text.
---

# getTextColor

## **Syntax:**

```lua
color getTextColor(selector)
```

#### _**\#Counterpart:**_ [_**setTextColor**_](setselectortextcolor.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to retrieve the text color of.

### **Returns:**

* **color** \(table\) : Table containing color of the selector's text.

## **Example:**

```lua
local selectorTextColor = beautify.selector.getTextColor(createdSelector)
print(toJSON(selectorTextColor))
```

![](../../.gitbook/assets/getselectortextcolor.png)

