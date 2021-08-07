---
description: Sets the text of the label.
---

# setLabelText

## **Syntax:**

```lua
state setLabelText(label, text)
```

#### _**\#Counterpart:**_ [_**getLabelText**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-getLabelText)

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