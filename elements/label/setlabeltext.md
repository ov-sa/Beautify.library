---
description: Sets the text of the label.
---

# setText

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

![](../../.gitbook/assets/setlabeltext.png)

