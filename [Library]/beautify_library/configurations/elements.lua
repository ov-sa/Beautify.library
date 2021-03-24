----------------------------------------------------------------
--[[ Resource: Beautify Library
     Script: configurations: elements.lua
     Server: -
     Author: OvileAmriam
     Developer: -
     DOC: 01/02/2021 (OvileAmriam)
     Desc: Element's Confign ]]--
----------------------------------------------------------------


------------------------
--[[ Configurations ]]--
------------------------

--inputDelayDuration = 500 --(In milliseconds)
availableElements = {

    ["beautify_window"] = {
        __syntax = {
            functionName = "createWindow",
            parameters = {
                {name = "x", type = "float"},
                {name = "y", type = "float"},
                {name = "width", type = "float"},
                {name = "height", type = "float"},
                {name = "title", type = "string"}
            },
        },
        __renderFunction = renderWindow,
        __allowedChildren = {
            ["beautify_gridlist"] = true
        },
        __apis = {},
        __minimumSize = 56,
        __titleBar = {
            paddingX = 5,
            height = 25,
            close_button = {
                hoverAnimDuration = 1000
            }
        },
        __contentSection = {
            padding = 5
        }
    },

    ["beautify_gridlist"] = {
        __syntax = {
            functionName = "createGridlist",
            parameters = {
                {name = "x", type = "float"},
                {name = "y", type = "float"},
                {name = "width", type = "float"},
                {name = "height", type = "float"}
            },
        },
        __renderFunction = renderGridlist,
        __allowedChildren = {},
        __apis = {
            ["test"] = {
                parameters = {
                    {name = "x", type = "float"},
                    {name = "y", type = "float"}
                }
            }
        },
        __minimumSize = 25,
        __columnBar = {
            padding = 5,
            height = 22,
        }
    }

}