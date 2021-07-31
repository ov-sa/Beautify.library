----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements: gridlist.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

availableElements["beautify_gridlist"] = {
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
    allowedChildren = {},
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

availableElements["beautify_gridlist"]["APIs"] = {
    ["countGridlistColumn"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"}
        }
    },
    ["addGridlistColumn"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"},
            {name = "name", type = "string"},
            {name = "width", type = "float"}
        }
    },
    ["removeGridlistColumn"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"},
            {name = "column", type = "number"}
        }
    },
    ["countGridlistRow"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"}
        }
    },
    ["addGridlistRow"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"}
        }
    },
    ["removeGridlistRow"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"},
            {name = "row", type = "number"}
        }
    },
    ["setGridlistRowData"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"},
            {name = "row", type = "number"},
            {name = "column", type = "number"},
            {name = "data", type = "string"}
        }
    },
    ["getGridlistRowData"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"},
            {name = "row", type = "number"},
            {name = "column", type = "number"}
        }
    },
    ["setGridlistSelection"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"},
            {name = "row", type = "number"}
        }
    },
    ["getGridlistSelection"] = {
        parameters = {
            {name = "gridlist", type = "userdata", userDataType = "beautify_gridlist"}
        }
    }
}