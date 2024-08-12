---@alias metaMethodType
---| "Add"
---| "Sub"
---| "Div"
---| "iDiv"
---| "Mul"
---| "Pow"
---| "Unm"
---| "Mod"
---| "tostring"
---| "Call"
---| "Equals"
---| "Less Than"
---| "Less Equals"
---| "Length"
---| "Concatenation"
---| "Metatable"


local metaOperators = {
    Add = "+",
    Sub = "-",
    Div = "/",
    iDiv = "//",
    Mul = "*",
    Pow = "^",
    Unm = "-",
    Mod = "%",
    tostring = "tostring",
    Call = "()",
    Equals = "==",
    ["Less Than"] = "<",
    ["Less Equals"] = "<=",
    Concatenation = "..",
    Length = "#",
    Metatable = "getmetatable"
}

---@class Constant
---@field Name string
---@field Description string?
---@field Type string
---@field Value string?
---@field Tags string[]?

---@class Field
---@field Name string
---@field Description string?
---@field Type string
---@field Tags string[]?

---@class Method
---@field Name string
---@field Description string?
---@field Parameters Parameter[]?
---@field Returns Return[]?

---@class Parameter
---@field Name string
---@field Type string
---@field Optional boolean?

---@class Return
---@field Name string?
---@field Type string
---@field Optional boolean?

---@class metaMethod
---@field Type metaMethodType
---@field paramA string
---@field paramB string?
---@field Return string?

---@class baseDoc
---@field Name string
---@field Description string?
---@field Type string

---@class libraryDocument: baseDoc
---@field Methods Method[]?
---@field Constants Constant[]?

---@class classDocument: baseDoc
---@field Methods Method[]?
---@field Fields Field[]?
---@field MetaMethods metaMethod[]?

---@class functionModuleDocument: Method

---@class anyDoc: baseDoc, libraryDocument, classDocument, functionModuleDocument

---@type fun(String: string, headerSize: integer?): string
local function Header(String, headerSize)
    return string.rep("#", headerSize or 1) .. " " .. String
end

---@type fun(Parameter: Parameter): string
local function parameterToString(Parameter)
    local Name = Parameter.Name .. ": "
    local Type = "`" .. Parameter.Type .. (Parameter.Optional and "?" or "") .. "`"

    return "| " .. Name .. Type .. " |"
end

---@type fun(Parameters: Parameter[]): string
local function parametersToString(Parameters)
    local listTop = "| Parameters |\n| :-- |\n"
    local list = ""

    for i, v in next, Parameters do
        list = list .. parameterToString(v) .. "\n"
    end

    return listTop .. list
end

---@type fun(Return: Return): string
local function returnToString(Return)
    local Name = Return.Name and Return.Name .. ": " or ""
    local Type = "`" .. Return.Type .. (Return.Optional and "?" or "") .. "`"

    return "| " .. Name .. Type .. " |"
end

---@type fun(Returns: Return[]): string
local function returnsToString(Returns)
    local listTop = "| Returns |\n| :-- |\n"
    local list = ""

    for i, v in next, Returns do
        list = list .. returnToString(v) .. "\n"
    end

    return listTop .. list
end

---@type fun(Method: Method): string
local function methodToString(Method)
    local Name = Header(Method.Name, 3) .. "\n"
    local Description = Method.Description and Method.Description .. "\n\n" or ""

    local Parameters = Method.Parameters and parametersToString(Method.Parameters) or ""
    local Returns = Method.Returns and returnsToString(Method.Returns) or ""

    return Name .. Description .. Parameters .. "\n" .. Returns
end

---@type fun(metaMethod: metaMethod): string
local function metaMethodToString(metaMethod)
    local Type = metaMethod.Type
    local Operator = metaOperators[Type]
    
    if not Operator then
        return ""
    end

    local Name = Header(Type, 3) .. "\n"
    local Result = "`" .. metaMethod.Return .. "`"

    if Type == "Metatable" or Type == "tostring" then
        Operator = "`" .. Operator .. "(" .. metaMethod.paramA .. ")`"
    elseif Type == "Add" or Type == "Sub" or Type == "Div" or Type == "iDiv" or Type == "Mul" or Type == "Pow" or Type == "Mod" or Type == "Equals" or Type == "Less Than" or Type == "Less Equals" or Type == "Concatenation" then
        Operator = "`" .. metaMethod.paramA .. " " .. Operator .. " " .. metaMethod.paramB .. "`"
    elseif Type == "Length" then
        Operator = "`" .. Operator .. metaMethod.paramA .. "`"
    elseif Type == "Call" then
        Operator = "`" .. metaMethod.paramA .. "()`"
    end

    return Name .. Operator .. " : " .. Result .. "\n\n"
end

---@type fun(Field: Field): string
local function fieldToString(Field)
    local Name = Header(Field.Name .. ": `" .. Field.Type .. "`", 3) .. "\n"
    local Tags = Field.Tags and "> Tags: " or ""
    local Description = Field.Description and Field.Description .. "\n" or ""

    if Field.Tags then
        for i, v in next, Field.Tags do
            Tags = Tags .. "`" .. v .. "` "
        end
        Tags = Tags .. "\n\n"
    end

    return Name .. Tags .. Description 
end

---@type fun(Constant: Constant): string
local function constantToString(Constant)
    local Name = Header(Constant.Name .. ": `" .. Constant.Type .. "`" .. (Constant.Value and " = `" .. Constant.Value .. "`" or ""), 3) .. "\n"
    local Tags = Constant.Tags and "> Tags: " or ""
    local Description = Constant.Description and Constant.Description .. "\n" or ""

    if Constant.Tags then
        for i, v in next, Constant.Tags do
            Tags = Tags .. "`" .. v .. "` "
        end
        Tags = Tags .. "\n\n"
    end

    return Name .. Tags .. Description
end

---@type fun(Doc: libraryDocument): string
local function libraryDocumentToString(Doc)
    local Name = Header(Doc.Name) .. "\n"
    local Description = Doc.Description and Doc.Description .. "\n\n" or ""

    local Constants = Doc.Constants and Header("Constants", 2) .. "\n" or ""
    local Methods = Doc.Methods and Header("Methods", 2) .. "\n" or ""

    if Doc.Constants then
        for i, v in next, Doc.Constants do
            Constants = Constants .. constantToString(v) .. "\n"
        end
    end

    if Doc.Methods then
        for i, v in next, Doc.Methods do
            Methods = Methods .. methodToString(v) .. "\n"
        end
    end

    return Name .. Description .. Constants .. Methods
end

---@type fun(Doc: classDocument): string
local function classDocumentToString(Doc)
    local Name = Header(Doc.Name .. " (Class)") .. "\n"
    local Description = Doc.Description and Doc.Description .. "\n\n" or ""

    local Fields = Doc.Fields and Header("Fields", 2) .. "\n" or ""
    local Methods = Doc.Methods and Header("Methods", 2) .. "\n" or ""
    local MetaMethods = Doc.MetaMethods and Header("Meta Methods", 2) .. "\n" or ""

    if Doc.Fields then
        for i, v in next, Doc.Fields do
            Fields = Fields .. fieldToString(v) .. "\n"
        end
    end

    if Doc.Methods then
        for i, v in next, Doc.Methods do
            Methods = Methods .. methodToString(v) .. "\n"
        end
    end

    if Doc.MetaMethods then
        for i, v in next, Doc.MetaMethods do
            MetaMethods = MetaMethods .. metaMethodToString(v) .. "\n"
        end
    end

    return Name .. Description .. Fields .. Methods .. MetaMethods
end

---@type fun(Method: Method): string
local function functionModuleDocumentToString(Method)
    local Name = Header(Method.Name, 1) .. "\n"
    local Description = Method.Description and Method.Description .. "\n\n" or ""

    local Parameters = Method.Parameters and parametersToString(Method.Parameters) or ""
    local Returns = Method.Returns and returnsToString(Method.Returns) or ""

    return Name .. Description .. Parameters .. "\n" .. Returns
end

---@param Docs anyDoc[]
return function(Docs)
    local Doc = ""

    for i, v in next, Docs do
        if v.Type == "Library" then
            Doc = Doc .. libraryDocumentToString(v) .. "\n"
        elseif v.Type == "Class" then
            Doc = Doc .. classDocumentToString(v) .. "\n"
        elseif v.Type == "Function" then
            Doc = Doc .. functionModuleDocumentToString(v) .. "\n"
        end
    end

    return Doc
end
