

## ━ setGridlistSelection

Selects specified row from your gridlist.

### **Syntax:**

```lua
state setGridlistSelection(gridlist, row)
```

#### _**\#Counterpart:**_ [_**getGridlistSelection**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-getGridlistSelection)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to select the row of.
  * **row** \(_int_\) : Index of the row you wish to be selected.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.gridlist.setGridlistSelection(createdGridlist, 1)
  print(tostring(resultState))
  ```

## ━ getGridlistSelection

Retrieves selected row from your gridlist.

### **Syntax:**

```lua
row getGridlistSelection(gridlist)
```

#### _**\#Counterpart:**_ [_**setGridlistSelection**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-setGridlistSelection)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to retrieve the selection of.
* **Returns:**
  * **row** \(_int_\) : Index of the selected row.
* **Example:**

  ```lua
  local resultState = beautify.gridlist.getGridlistSelection(createdGridlist)
  print(resultState)
  ```

