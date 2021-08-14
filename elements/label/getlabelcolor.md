---
description: Retrieves the color of the label.
---

# getColor

## **Syntax:**

```lua
color getColor(label)
```

#### _**\#Counterpart:**_ [_**setColor**_](setlabelcolor.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the color of.

### **Returns:**

* **color** \(table\) : Table containing color of the label.

## **Example:**

```lua
local labelColor = beautify.label.getColor(createdLabel)
print(toJSON(labelColor))
```

![](../../.gitbook/assets/getlabelcolor.png)

