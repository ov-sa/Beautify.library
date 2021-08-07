---
description: Sets the text of the label.
---

# setLabelText

## **Syntax:**

```lua
state setLabelText(label, text)
```

#### _**\#Counterpart:**_ [_**getLabelText**_](getlabeltext.md)

### **Parameters:**

* **label** \(element\) : Label element you wish to set the text of.
* **text** \(string\) : Text of the label.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.label.setLabelText(createdLabel, "My First Label #1")
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/fa0a436b55c8c25e32ea12d83b59a5808b2c3af2/.gitbook/assets/setlabeltext.png)

