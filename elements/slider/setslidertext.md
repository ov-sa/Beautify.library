---
description: Sets the text of the slider.
---

# setSliderText

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

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/7e0ecb751e5cb5fb7c0112b4713a70ed9fb13497/.gitbook/assets/setslidertext.png)

