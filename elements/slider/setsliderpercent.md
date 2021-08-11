---
description: Sets the percentage of the slider.
---

# setSliderPercent

## **Syntax:**

```lua
state setSliderPercent(slider, percent)
```

#### _**\#Counterpart:**_ [_**getSliderPercent**_](getsliderpercent.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to set the percentage of.
* **percent** \(float\) : Percentage of the slider.

### **Returns:**

* **state** \(bool\) : Execution state.

## **Example:**

```lua
local resultState = beautify.slider.setSliderPercent(createdSlider, 75)
print(tostring(resultState))
```

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/58714ad13d6e3877e8bc41e8bb96d921f5c9dd2b/.gitbook/assets/setsliderpercent.png)

