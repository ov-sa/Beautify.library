---
description: Retrieves the text of the selector.
---

# getText

## **Syntax:**

```lua
text getText(selector)
```

#### _**\#Counterpart:**_ [_**setText**_](setselectortext.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to retrieve the text of.

### **Returns:**

* **text** \(string\) : Text of the selector.

## **Example:**

```lua
local selectorText = beautify.selector.getText(createdSelector)
print(selectorText)
```

![](../../.gitbook/assets/getselectortext.png)

