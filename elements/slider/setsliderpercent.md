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

![](../../.gitbook/assets/setsliderpercent.png)
