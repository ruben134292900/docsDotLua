# baseDoc (Class)

A base document type which every other document type inherits from.

## Fields
### Name: `string`

### Type: `string`

### Description: `string?`


# libraryDocument (Class)
#### Inherits: `baseDoc`
A library document useful for documenting libraries / modules.

## Fields
### Methods: `Method[]?`

### Constants: `Constant[]?`

## Fields from `baseDoc`
### Name: `string`

### Type: `string`

### Description: `string?`


# classDocument (Class)
#### Inherits: `baseDoc`
## Fields
### Methods: `Method[]?`

### Constants: `Constant[]?`

### Inherits: `classDocument? | classDocument[]?`

### MetaMethods: `metaMethod[]?`

## Fields from `baseDoc`
### Name: `string`

### Type: `string`

### Description: `string?`


# functionModuleDocument (Class)
#### Inherits: `Method`
## Fields from `Method`
### Name: `string`

### Description: `string?`

### Parameters: `Parameter[]?`

### Returns: `Return[]?`


# anyDoc (Class)
#### Inherits: `baseDoc` `classDocument` `libraryDocument` `functionModuleDocument` 
## Fields from `classDocument`
### Methods: `Method[]?`

### Constants: `Constant[]?`

### Inherits: `classDocument? | classDocument[]?`

### MetaMethods: `metaMethod[]?`

## Fields from `baseDoc`
### Name: `string`

### Type: `string`

### Description: `string?`

## Fields from `libraryDocument`
### Methods: `Method[]?`

### Constants: `Constant[]?`


# Constant (Class)

## Fields
### Name: `string`

### Description: `string?`

### Type: `string`

### Value: `string?`

### Tags: `string[]?`


# Field (Class)

## Fields
### Name: `string`

### Description: `string?`

### Type: `string`

### Tags: `string[]?`


# Method (Class)

## Fields
### Name: `string`

### Description: `string?`

### Parameters: `Parameter[]?`

### Returns: `Return[]?`


# Parameter (Class)

## Fields
### Name: `string`

### Type: `string`

### Optional: `boolean`


# Return (Class)

## Fields
### Name: `string?`

### Type: `string`

### Optional: `boolean`


# metaMethod (Class)

## Fields
### Type: `"Add" | "Sub" | "Div" | "iDiv" | "Mul" | "Pow" | "Unm" | "Mod" | "tostring" | "Call" | "Equals" | "Less Than" | "Less Equals" | "Length" | "Concatenation" | "Metatable"`
The meta method function.

### paramA: `string`
Also known as `self`

### paramB: `string?`

### Return: `string?`
The result of the meta method.

