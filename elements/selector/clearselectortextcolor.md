---
description: Clears overridden color of the selector's text.
---

# clearTextColor

## **Syntax:**

```lua
state clearTextColor(selector)
```

### **Parameters:**

* **selector** \(element\) : Selector element you wish to clear the overrode text color of.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.clearTextColor(createdSelector)
print(tostring(resultState))
```

![](../../.gitbook/assets/clearselectortextcolor.png)

