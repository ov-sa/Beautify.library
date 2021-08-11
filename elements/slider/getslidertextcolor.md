---
description: Retrieves the color of the slider's text.
---

# getSliderTextColor

## **Syntax:**

```lua
color getSliderTextColor(slider)
```

#### _**\#Counterpart:**_ [_**setSliderTextColor**_](setslidertextcolor.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to retrieve the text color of.

### **Returns:**

* **color** \(table\) : Table containing color of the slider's text.

## **Example:**

```lua
local sliderTextColor = beautify.slider.getSliderTextColor(createdSlider)
print(toJSON(sliderTextColor))
```

![](../../.gitbook/assets/getslidertextcolor.png)