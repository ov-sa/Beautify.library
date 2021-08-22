---
description: Clears the text of the selector.
---

# clearText

## **Syntax:**

```lua
state clearText(selector)
```

### **Parameters:**

* **selector** \(element\) : Selector element you wish to clear the text of.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.selector.clearText(createdSelector)
print(tostring(resultState))
```

![](../../.gitbook/assets/clearselectortext.png)

