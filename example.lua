local toDoc = require("docs")

---@type libraryDocument
local lib = {
    Type = "Library",
    Name = "Library Name",

    Description = "This is a description",

    Constants = {
        {
            Name = "Constant Value",
            Description = "Description",
            Type = "any",
            Tags = {"Tag1", "Tag2"}
        },
        {
            Name = "Leet Value",
            Type = "integer",
            Value = "1337"
        },
    },

    Methods = {
        {
            Name = "function",
            Description = "Does shit",
            Parameters = {
                {
                    Name = "Parameter",
                    Type = "any",
                    Optional = true
                },
                {
                    Name = "Parameter2",
                    Type = "boolean",
                    Optional = false
                },

            }
        }
    }
}

---@type classDocument
local class = {
    Type = "Class",
    Name = "Class Name",

    Description = "This is the description of the class 😃",

    Fields = {
        {
            Name = "Field Value",
            Description = "Property",
            Type = "any",
            Tags = {"Tag1", "Tag2"},
        }
    },

    Methods = {
        {
            Name = "function",
            Description = "Does shit",
            Parameters = {
                {
                    Name = "Parameter",
                    Type = "any",
                    Optional = true
                },
                {
                    Name = "Parameter2",
                    Type = "boolean",
                    Optional = false
                },

            }
        },
        {
            Name = "function 2",
            Description = "Does shit too",
            Parameters = {
                {
                    Name = "Parameter",
                    Type = "any",
                    Optional = true
                },
                {
                    Name = "Parameter2",
                    Type = "boolean",
                    Optional = false
                },
            },
            Returns = {
                {
                    Name = "Return 1",
                    Type = "any",
                    Optional = true
                },
                {
                    Name = "Return 2",
                    Type = "boolean",
                    Optional = false
                },
            }
        }
    }
}

---@type functionModuleDocument
local functionModule = {
    Type = "FunctionModule",
    Name = "function",
    Description = "Does shit",
    Parameters = {
        {
            Name = "Parameter",
            Type = "any",
            Optional = true
        },
        {
            Name = "Parameter2",
            Type = "boolean",
            Optional = false
        },
    },
    Returns = {
        {
            Name = "Return 1",
            Type = "any",
            Optional = true
        },
        {
            Name = "Return 2",
            Type = "boolean",
            Optional = false
        },
    }
}

local Doc = {
    lib,
    class,
    functionModule
}

print(toDoc(Doc))
