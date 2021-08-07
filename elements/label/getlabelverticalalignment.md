---
description: Retrieves the vertical alignment of the label.
---

# getLabelVerticalAlignment

## **Syntax:**

```lua
alignment getLabelVerticalAlignment(label)
```

#### _**\#Counterpart:**_ [_**setLabelVerticalAlignment**_](setlabelverticalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the vertical alignment of.

### **Returns:**

* **alignment** \(string\) : Vertical alignment of the label.

## **Example:**

```lua
local labelVerticalAlignment = beautify.label.getLabelVerticalAlignment(createdLabel)
print(labelVerticalAlignment)
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa0a436b55c8c25e32ea12d83b59a5808b2c3af2/.gitbook/assets/getlabelverticalalignment.png)

