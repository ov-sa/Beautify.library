---
description: Retrieves the percentage of the slider.
---

# getPercent

## **Syntax:**

```lua
percent getPercent(slider)
```

#### _**\#Counterpart:**_ [_**setPercent**_](setsliderpercent.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to retrieve the percentage of.

### **Returns:**

* **percent** \(float\) : Percentage of the slider.

## **Example:**

```lua
local sliderPercent = beautify.slider.getPercent(createdSlider)
print(sliderPercent)
```

![](../../.gitbook/assets/getsliderpercent.png)

