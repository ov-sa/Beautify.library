## ━ createLabel

Creates a new label which can be further used to name your components.

### **Syntax:**

```lua
label createLabel(text, x, y, width, height, [parent = nil], [postGUI = false])
```

* **Parameters:**
  * **text** \(_string_\) : Text of the label.
  * **x** \(_float_\) : Absolute x coordinate of the label within the container.
  * **y** \(_float_\) : Absolute y coordinate of the label within the container.
  * **width** \(_float_\) : Absolute width of the label.
  * **height** \(_float_\) : Absolute height of the label.
  * **parent** \(_element_\) : Supported parent element to use as a container for the label. \(_Optional_\)
  * **postGUI** \(_bool_\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)
* **Returns:**
  * **label** \(_element_\) : Created label element.
* **Example:**

  ```lua
  local sX, sY = guiGetScreenSize()
  local label_width, label_height = 300, 50
  local createdLabel = beautify.button.createButton("Label #1", (sX - label_width)/2, (sY - label_height)/2, label_width, label_height, nil, false)
  beautify.setUIDisabled(createdLabel, true)
  beautify.setUIVisible(createdLabel , true)
  ```

## ━ setLabelText

Sets the text of your label.

### **Syntax:**

```lua
state setLabelText(label, text)
```

#### _**\#Counterpart:**_ [_**getLabelText**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-getLabelText)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to set the text of.
  * **text** \(_string_\) : Text of the label.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.label.setLabelText(createdLabel, "My First Label #1")
  print(tostring(resultState))
  ```

## ━ getLabelText

Retrieves the text of your label.

### **Syntax:**

```lua
text getLabelText(label)
```

#### _**\#Counterpart:**_ [_**setLabelText**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-setLabelText)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to retrieve the text of.
* **Returns:**
  * **text** \(_string_\) : Text of the label.
* **Example:**

  ```lua
  local labelText = beautify.label.getLabelText(createdLabel)
  print(labelText)
  ```

## ━ clearLabelColor

Clears overridden color of your label.

### **Syntax:**

```lua
state clearLabelColor(label)
```

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to clear the overrode color of.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.label.clearLabelColor(createdLabel)
  print(tostring(resultState))
  ```

## ━ setLabelColor

Sets the color of your label.

### **Syntax:**

```lua
state setLabelColor(label, color)
```

#### _**\#Counterpart:**_ [_**getLabelColor**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-getLabelColor)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to set the color of.
  * **color** \(_table_\) : Table containing color of the label.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.label.setLabelColor(createdLabel, {255, 0, 0, 255})
  print(tostring(resultState))
  ```

## ━ getLabelColor

Retrieves the color of your label.

### **Syntax:**

```lua
color getLabelColor(label)
```

#### _**\#Counterpart:**_ [_**setLabelColor**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-setLabelColor)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to retrieve the color of.
* **Returns:**
  * **color** \(_table_\) : Table containing color of the label.
* **Example:**

  ```lua
  local labelColor = beautify.label.getLabelColor(createdLabel)
  print(toJSON(labelColor))
  ```

## ━ setLabelHorizontalAlignment

Sets the horizontal alignment of your label.

### **Syntax:**

```lua
state setLabelHorizontalAlignment(label, alignment)
```

#### _**\#Counterpart:**_ [_**getLabelHorizontalAlignment**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-getLabelHorizontalAlignment)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to set the horizontal alignment of.
  * **alignment** \(_string_\) : Horizontal alignment of the label \(Left/Center/Right\).
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.label.setLabelHorizontalAlignment(createdLabel, "center")
  print(tostring(resultState))
  ```

## ━ getLabelHorizontalAlignment

Retrieves the horizontal alignment of your label.

### **Syntax:**

```lua
alignment getLabelHorizontalAlignment(label)
```

#### _**\#Counterpart:**_ [_**setLabelHorizontalAlignment**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-setLabelHorizontalAlignment)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to retrieve the horizontal alignment of.
* **Returns:**
  * **alignment** \(_string_\) : Horizontal alignment of the label.
* **Example:**

  ```lua
  local labelHorizontalAlignment = beautify.label.getLabelHorizontalAlignment(createdLabel)
  print(labelHorizontalAlignment)
  ```

## ━ setLabelVerticalAlignment

Sets the vertical alignment of your label.

### **Syntax:**

```lua
state setLabelVerticalAlignment(label, alignment)
```

#### _**\#Counterpart:**_ [_**getLabelVerticalAlignment**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-getLabelVerticalAlignment)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to set the vertical alignment of.
  * **alignment** \(_string_\) : Vertical alignment of the label \(Top/Center/Bottom\).
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.label.setLabelVerticalAlignment(createdLabel, "center")
  print(tostring(resultState))
  ```

## ━ getLabelVerticalAlignment

Retrieves the vertical alignment of your label.

### **Syntax:**

```lua
alignment getLabelVerticalAlignment(label)
```

#### _**\#Counterpart:**_ [_**setLabelVerticalAlignment**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Label#-setLabelVerticalAlignment)

* **Parameters:**
  * **label** \(_element_\) : Label element you wish to retrieve the vertical alignment of.
* **Returns:**
  * **alignment** \(_string_\) : Vertical alignment of the label.
* **Example:**

  ```lua
  local labelVerticalAlignment = beautify.label.getLabelVerticalAlignment(createdLabel)
  print(labelVerticalAlignment)
  ```

