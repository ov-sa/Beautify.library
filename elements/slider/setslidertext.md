---
description: Sets the text of the slider.
---

# setText

## **Syntax:**

```lua
state setSliderText(slider, text)
```

#### _**\#Counterpart:**_ [_**getSliderText**_](getslidertext.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to set the text of.
* **text** \(string\) : Text of the slider.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.slider.setSliderText(createdSlider, "My First Slider #1")
print(tostring(resultState))
```

![](../../.gitbook/assets/setslidertext.png)

