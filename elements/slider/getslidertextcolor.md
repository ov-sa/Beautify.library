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

![](https://github.com/OvileAmriam/MTA-Beautify-Library/tree/6614fb15966a56264b74a8a4ff0630898d171494/.gitbook/assets/getslidertextcolor.png)

