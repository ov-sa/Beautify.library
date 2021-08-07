---
description: Retrieves the text of the label.
---

# getLabelText

## **Syntax:**

```lua
text getLabelText(label)
```

#### _**\#Counterpart:**_ [_**setLabelText**_](setlabeltext.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to retrieve the text of.

### **Returns:**

* **text** \(string\) : Text of the label.

## **Example:**

```lua
local labelText = beautify.label.getLabelText(createdLabel)
print(labelText)
```

