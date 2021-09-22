----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


-------------------
--[[ Variables ]]--
-------------------

local elementType = "beautify_gridlist"


------------------------
--[[ Configurations ]]--
------------------------

availableElements[elementType] = {
    reference = "gridlist",
    syntax = {
        functionName = "createGridlist",
        parameters = {
            {name = "x", type = "float"},
            {name = "y", type = "float"},
            {name = "width", type = "float"},
            {name = "height", type = "float"}
        }
    },
    renderFunction = renderGridlist,
    allowedChildren = false,
    isDraggable = false,
    minimumSize = 25,
    columnBar = {
        padding = 5,
        height = 22,
    },
    rowBar = {
        padding = 5,
        height = 23,
        hoverAnimDuration = 3000
    }
}

availableElements[elementType]["APIs"] = {
    ["countGridlistColumns"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType}
        }
    },
    ["addGridlistColumn"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "name", type = "string"},
            {name = "width", type = "float"}
        }
    },
    ["removeGridlistColumn"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "column", type = "number"}
        }
    },
    ["setGridlistColumnName"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "column", type = "number"},
            {name = "name", type = "string"}
        }
    },
    ["getGridlistColumnName"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "column", type = "number"}
        }
    },
    ["countGridlistRows"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType}
        }
    },
    ["clearGridlistRows"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType}
        }
    },
    ["addGridlistRow"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType}
        }
    },
    ["removeGridlistRow"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "row", type = "number"}
        }
    },
    ["setGridlistRowData"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "row", type = "number"},
            {name = "column", type = "number"},
            {name = "data", type = "string"}
        }
    },
    ["getGridlistRowData"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "row", type = "number"},
            {name = "column", type = "number"}
        }
    },
    ["setGridlistSelection"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType},
            {name = "row", type = "number"}
        }
    },
    ["getGridlistSelection"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = elementType}
        }
    }
}