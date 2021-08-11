---
description: Sets the color of the slider's text.
---

# setSliderTextColor

## **Syntax:**

```lua
state setSliderTextColor(slider, color)
```

#### _**\#Counterpart:**_ [_**getSliderTextColor**_](getslidertextcolor.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to set the text color of.
* **color** \(table\) : Table containing color of the slider's text.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.slider.setSliderTextColor(createdSlider, {255, 0, 0, 255})
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/6614fb15966a56264b74a8a4ff0630898d171494/.gitbook/assets/setslidertextcolor.png)

