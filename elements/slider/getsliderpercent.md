---
description: Retrieves the slidden percentage of the slider.
---

# getSliderPercent

## **Syntax:**

```lua
float getSliderPercent(slider)
```

#### _**\#Counterpart:**_ [_**setSliderPercent**_](setsliderpercent.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to retrieve the percentage of.

### **Returns:**

* **percentage** \(float\) : Percentage of the slider.

## **Example:**

```lua
local sliderText = beautify.slider.getSliderPercent(createdSlider)
print(sliderText)
```

![](../../.gitbook/assets/getsliderpercent.png)
