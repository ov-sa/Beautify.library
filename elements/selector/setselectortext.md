---
description: Sets the text of the selector.
---

# setText

## **Syntax:**

```lua
state setText(selector, text)
```

#### _**\#Counterpart:**_ [_**getText**_](getselectortext.md)

### **Parameters:**

* **selector** \(element\) : Selector element you wish to set the text of.
* **text** \(string\) : Text of the selector.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.setText(createdSelector, "Ethnicity")
print(tostring(resultState))
```

![](../../.gitbook/assets/setselectortext.png)

