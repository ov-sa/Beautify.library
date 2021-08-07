---
description: Retrieves the color of the label.
---

# getLabelColor

## **Syntax:**

```lua
color getLabelColor(label)
```

#### _**\#Counterpart:**_ [_**setLabelColor**_](setlabelcolor.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the color of.

### **Returns:**

* **color** \(table\) : Table containing color of the label.

## **Example:**

```lua
local labelColor = beautify.label.getLabelColor(createdLabel)
print(toJSON(labelColor))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa0a436b55c8c25e32ea12d83b59a5808b2c3af2/.gitbook/assets/getlabelcolor.png)

