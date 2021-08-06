## ━ createGridlist

Creates a new blank gridlist which can be further used to list your datas.

### **Syntax:**

```lua
gridlist createGridlist(x, y, width, height, [parent = nil], [postGUI = false])
```

* **Parameters:**
  * **x** \(_float_\) : Absolute x coordinate of the gridlist within the container.
  * **y** \(_float_\) : Absolute y coordinate of the gridlist within the container.
  * **width** \(_float_\) : Absolute width of the gridlist.
  * **height** \(_float_\) : Absolute height of the gridlist.
  * **parent** \(_element_\) : Supported parent element to use as a container for the gridlist. \(_Optional_\)
  * **postGUI** \(_bool_\) : State whether the UI will be drawn below/over CEGUI. \(_Optional_\)
* **Returns:**
  * **gridlist** \(_element_\) : Created gridlist element.
* **Example:**

  ```lua
  local sX, sY = guiGetScreenSize()
  local window_width, window_height = 600, 300
  local createdWindow = beautify.window.createWindow((sX - window_width)/2, (sY - window_height)/2, window_width, window_height, "Window #1", nil, false)
  local createdGridlist = beautify.gridlist.createGridlist(0, 0, window_width, window_height, createdWindow, false)
  beautify.setUIDraggable(createdWindow, true)
  beautify.setUIVisible(createdWindow, true)
  beautify.setUIVisible(createdGridlist, true)
  ```

## ━ countGridlistColumns

Counts and retrieves number of columns within your gridlist.

### **Syntax:**

```lua
count countGridlistColumns(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistRows**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-countGridlistRows)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to retrieve the column count of.
* **Returns:**
  * **count** \(_int_\) : Number of columns.
* **Example:**

  ```lua
  local totalColumns = beautify.gridlist.countGridlistColumns(createdGridlist)
  print(totalColumns)
  ```

## ━ addGridlistColumn

Adds new column to your gridlist.

### **Syntax:**

```lua
column addGridlistColumn(gridlist, name, width)
```

#### _**\#Counterpart:**_ [_**removeGridlistColumn**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-removeGridlistColumn)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to add the column in.
  * **name** \(_string_\) : Name of the column.
  * **width** \(_float_\) : Absolute width of the column.
* **Returns:**
  * **column** \(_int_\) : Added column's index.
* **Example:**

  ```lua
  local columnIndex1 = beautify.gridlist.addGridlistColumn(createdGridlist, "S.No", 75)
  local columnIndex2 = beautify.gridlist.addGridlistColumn(createdGridlist, "Name", 250)
  local columnIndex3 = beautify.gridlist.addGridlistColumn(createdGridlist, "Country", 100)
  local columnIndex4 = beautify.gridlist.addGridlistColumn(createdGridlist, "Rank", 250)
  ```

## ━ removeGridlistColumn

Removes specified column from your gridlist.

### **Syntax:**

```lua
state removeGridlistColumn(gridlist, column)
```

#### _**\#Counterpart:**_ [_**addGridlistColumn**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-addGridlistColumn)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to remove the column from.
  * **column** \(_int_\) : Index of the column you wish to remove.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.gridlist.removeGridlistColumn(createdGridlist, 1)
  print(tostring(resultState))
  ```

## ━ setGridlistColumnName

Sets specified column's name within your gridlist.

### **Syntax:**

```lua
state setGridlistColumnName(gridlist, column, name)
```

#### _**\#Counterpart:**_ [_**getGridlistColumnName**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-getGridlistColumnName)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to update the column name of.
  * **column** \(_int_\) : Index of the column you wish to update.
  * **name** \(_string_\) : Name of the column.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.gridlist.setGridlistColumnName(createdGridlist, 1, "Serial")
  print(tostring(resultState))
  ```

## ━ getGridlistColumnName

Retrieves specified column's name from your gridlist.

### **Syntax:**

```lua
name getGridlistColumnName(gridlist, column)
```

#### _**\#Counterpart:**_ [_**setGridlistColumnName**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-setGridlistColumnName)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to retrieve the column name of.
  * **column** \(_int_\) : Index of the column you wish to retrieve the name of.
* **Returns:**
  * **name** \(_string_\) : Name of the column.
* **Example:**

  ```lua
  local columnName= beautify.gridlist.getGridlistColumnName(createdGridlist, 1)
  print(columnName)
  ```

## ━ countGridlistRows

Counts and retrieves number of rows within your gridlist.

### **Syntax:**

```lua
count countGridlistRows(gridlist)
```

#### _**\#Counterpart:**_ [_**countGridlistColumns**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-countGridlistColumns)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to retrieve the row count of.
* **Returns:**
  * **count** \(_int_\) : Number of rows.
* **Example:**

  ```lua
  local totalRows = beautify.gridlist.countGridlistRows(createdGridlist)
  print(totalRows )
  ```

## ━ addGridlistRow

Adds new row to your gridlist.

### **Syntax:**

```lua
row addGridlistRow(gridlist)
```

#### _**\#Counterpart:**_ [_**removeGridlistRow**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-removeGridlistRow)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to add the row in.
* **Returns:**
  * **row** \(_int_\) : Added row's index.
* **Example:**

  ```lua
  local rowIndex1 = beautify.gridlist.addGridlistRow(createdGridlist)
  local rowIndex2 = beautify.gridlist.addGridlistRow(createdGridlist)
  local rowIndex3 = beautify.gridlist.addGridlistRow(createdGridlist)
  ```

## ━ removeGridlistRow

Removes specified row from your gridlist.

### **Syntax:**

```lua
state removeGridlistRow(gridlist, row)
```

#### _**\#Counterpart:**_ [_**addGridlistRow**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-addGridlistRow)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to remove the row from.
  * **row** \(_int_\) : Index of the row you wish to remove.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  ```lua
  local resultState = beautify.gridlist.removeGridlistRow(createdGridlist, 1)
  print(tostring(resultState))
  ```

## ━ setGridlistRowData

Sets specified row's data within your gridlist.

### **Syntax:**

```lua
state setGridlistRowData(gridlist, row, column, data)
```

#### _**\#Counterpart:**_ [_**getGridlistRowData**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-getGridlistRowData)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to update the row data of.
  * **row** \(_int_\) : Index of the row you wish to update.
  * **column** \(_int_\) : Index of the column you wish to update.
  * **data** \(_string_\) : Data of row's column.
* **Returns:**
  * **state** \(_bool_\) : Execution state.
* **Example:**

  \`\`\`lua

  beautify.gridlist.setGridlistRowData\(createdGridlist, 1, 1, "1"\)

  beautify.gridlist.setGridlistRowData\(createdGridlist, 1, 2, "Tron"\)

  beautify.gridlist.setGridlistRowData\(createdGridlist, 1, 3, "BH"\)

  beautify.gridlist.setGridlistRowData\(createdGridlist, 1, 4, "CEO"\)

beautify.gridlist.setGridlistRowData\(createdGridlist, 2, 1, "2"\) beautify.gridlist.setGridlistRowData\(createdGridlist, 2, 2, "Aviril"\) beautify.gridlist.setGridlistRowData\(createdGridlist, 2, 3, "US"\) beautify.gridlist.setGridlistRowData\(createdGridlist, 2, 4, "CEO"\)

beautify.gridlist.setGridlistRowData\(createdGridlist, 3, 1, "3"\) beautify.gridlist.setGridlistRowData\(createdGridlist, 3, 2, "Mario"\) beautify.gridlist.setGridlistRowData\(createdGridlist, 3, 3, "BH"\) beautify.gridlist.setGridlistRowData\(createdGridlist, 3, 4, "CEO"\)

```text
## ━ getGridlistRowData
Retrieves specified row's data from your gridlist.
### **Syntax:**
```lua
data getGridlistRowData(gridlist, row, column)
```

#### _**\#Counterpart:**_ [_**setGridlistRowData**_](https://github.com/OvileAmriam/MTA-Beautify-Library/wiki/Gridlist#-setGridlistRowData)

* **Parameters:**
  * **gridlist** \(_element_\) : Gridlist element you wish to retrieve the row data of.
  * **row** \(_int_\) : Index of the row you wish to retrieve the data of.
  * **column** \(_int_\) : Index of the column you wish to retrieve the data of.
* **Returns:**
  * **data** \(_string_\) : Data of row's column.
* **Example:**

  ```lua
  local rowData = beautify.gridlist.getGridlistRowData(createdGridlist, 1, 2)
  print(rowData)
  ```

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

