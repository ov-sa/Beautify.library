---
description: Retrieves the vertical alignment of the label.
---

# getVerticalAlignment

## **Syntax:**

```lua
alignment getVerticalAlignment(label)
```

#### _**\#Counterpart:**_ [_**setVerticalAlignment**_](setlabelverticalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the vertical alignment of.

### **Returns:**

* **alignment** \(string\) : Vertical alignment of the label.

## **Example:**

```lua
local labelVerticalAlignment = beautify.label.getVerticalAlignment(createdLabel)
print(labelVerticalAlignment)
```

![](../../.gitbook/assets/getlabelverticalalignment.png)

