---
description: Retrieves the horizontal alignment of the label.
---

# getLabelHorizontalAlignment

## **Syntax:**

```lua
alignment getLabelHorizontalAlignment(label)
```

#### _**\#Counterpart:**_ [_**setLabelHorizontalAlignment**_](setlabelhorizontalalignment.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the horizontal alignment of.

### **Returns:**

* **alignment** \(string\) : Horizontal alignment of the label.

## **Example:**

```lua
local labelHorizontalAlignment = beautify.label.getLabelHorizontalAlignment(createdLabel)
print(labelHorizontalAlignment)
```

![](../../.gitbook/assets/getlabelhorizontalalignment.png)

