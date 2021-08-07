

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

