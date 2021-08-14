---
description: Retrieves the horizontal alignment of the label.
---

# getHorizontalAlignment

## **Syntax:**

```lua
alignment getHorizontalAlignment(label)
```

#### _**\#Counterpart:**_ [_**setHorizontalAlignment**_](setlabelhorizontalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the horizontal alignment of.

### **Returns:**

* **alignment** \(string\) : Horizontal alignment of the label.

## **Example:**

```lua
local labelHorizontalAlignment = beautify.label.getHorizontalAlignment(createdLabel)
print(labelHorizontalAlignment)
```

![](../../.gitbook/assets/getlabelhorizontalalignment.png)

