local _unpack = unpack
local function unpack(list)
    local noIndexList = {}
    local idx = 0
    for i, v in next, list do
        idx = idx + 1
        noIndexList[idx] = v
    end
    return _unpack(noIndexList)
end

-- keep in mind that i did resort it in the markdown so results may differ if you turn this into a markdown.

---@type {[string]: classDocument}
local Classes = {}

Classes.baseDoc = {
    Type = "Class",
    Name = "baseDoc",
    Description = "A base document type which every other document type inherits from.",

    Fields = {
        {
            Name = "Name",
            Type = "string"
        },
        {
            Name = "Type",
            Type = "string"
        },
        {
            Name = "Description",
            Type = "string?"
        }
    }
}

Classes.libraryDocument = {
    Type = "Class",
    Name = "libraryDocument",
    Description = "A library document useful for documenting libraries / modules.",
    Inherits = Classes.baseDoc,

    Fields = {
        {
            Name = "Methods",
            Type = "Method[]?"
        },
        {
            Name = "Constants",
            Type = "Constant[]?"
        }
    },
}

Classes.classDocument = {
    Type = "Class",
    Name = "classDocument",
    Inherits = Classes.baseDoc,

    Fields = {
        {
            Name = "Methods",
            Type = "Method[]?"
        },
        {
            Name = "Constants",
            Type = "Constant[]?"
        },
        {
            Name = "Inherits",
            Type = "classDocument? | classDocument[]?"
        },
        {
            Name = "MetaMethods",
            Type = "metaMethod[]?"
        }
    },
}

Classes.Constant = {
    Type = "Class",
    Name = "Constant",

    Fields = {
        {
            Name = "Name",
            Type = "string"
        },
        {
            Name = "Description",
            Type = "string?",
        },
        {
            Name = "Type",
            Type = "string"
        },
        {
            Name = "Value",
            Type = "string?"
        },
        {
            Name = "Tags",
            Type = "string[]?"
        }
    }
}

Classes.Field = {
    Type = "Class",
    Name = "Field",

    Fields = {
        {
            Name = "Name",
            Type = "string"
        },
        {
            Name = "Description",
            Type = "string?",
        },
        {
            Name = "Type",
            Type = "string"
        },
        {
            Name = "Tags",
            Type = "string[]?"
        }
    }
}

Classes.Method = {
    Type = "Class",
    Name = "Method",

    Fields = {
        {
            Name = "Name",
            Type = "string"
        },
        {
            Name = "Description",
            Type = "string?",
        },
        {
            Name = "Parameters",
            Type = "Parameter[]?"
        },
        {
            Name = "Returns",
            Type = "Return[]?"
        }
    }
}

Classes.Parameter = {
    Type = "Class",
    Name = "Parameter",

    Fields = {
        {
            Name = "Name",
            Type = "string"
        },
        {
            Name = "Type",
            Type = "string"
        },
        {
            Name = "Optional",
            Type = "boolean",
        },
    }
}

Classes.Return = {
    Type = "Class",
    Name = "Return",

    Fields = {
        {
            Name = "Name",
            Type = "string?"
        },
        {
            Name = "Type",
            Type = "string"
        },
        {
            Name = "Optional",
            Type = "boolean",
        },
    }
}

Classes.metaMethod = {
    Type = "Class",
    Name = "metaMethod",

    Fields = {
        {
            Name = "Type",
            Type = '"Add" | "Sub" | "Div" | "iDiv" | "Mul" | "Pow" | "Unm" | "Mod" | "tostring" | "Call" | "Equals" | "Less Than" | "Less Equals" | "Length" | "Concatenation" | "Metatable"',
            Description = "The meta method function."
        },
        {
            Name = "paramA",
            Type = "string",
            Description = "Also known as `self`"
        },
        {
            Name = "paramB",
            Type = "string?",
        },
        {
            Name = "Return",
            Type = "string?",
            Description = "The result of the meta method."
        }
    }
}

Classes.functionModuleDocument = {
    Type = "Class",
    Name = "functionModuleDocument",
    Inherits = Classes.Method
}

Classes.anyDoc = {
    Type = "Class",
    Name = "anyDoc",
    Inherits = {Classes.baseDoc, Classes.classDocument, Classes.libraryDocument, Classes.functionModuleDocument}
}

local Doc = {
    unpack(Classes)
}

return Doc
