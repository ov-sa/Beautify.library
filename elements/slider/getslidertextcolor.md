---
description: Retrieves the color of the slider's text.
---

# getTextColor

## **Syntax:**

```lua
color getTextColor(slider)
```

#### _**\#Counterpart:**_ [_**setTextColor**_](setslidertextcolor.md)

### **Parameters:**

* **slider** \(element\) : Slider element you wish to retrieve the text color of.

### **Returns:**

* **color** \(table\) : Table containing color of the slider's text.

## **Example:**

```lua
local sliderTextColor = beautify.slider.getTextColor(createdSlider)
print(toJSON(sliderTextColor))
```

![](../../.gitbook/assets/getslidertextcolor.png)

