---
description: Retrieves the text of the button.
---

# getButtonText

## **Syntax:**

```lua
text getButtonText(button)
```

#### _**\#Counterpart:**_ [_**setButtonText**_](setbuttontext.md)

### **Parameters:**

* **button** \(element\) : Button element you wish to retrieve the text of.

### **Returns:**

* **text** \(string\) : Text of the button.

## **Example:**

```lua
local buttonText = beautify.button.getButtonText(createdButton)
print(buttonText)
```

