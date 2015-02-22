local table = table
local string = string
local hook = hook
local debug = debug
local math = math
local file = file
local type = type
local pairs = pairs
local pcall = pcall
local error = error
local setmetatable = setmetatable
local print = print
local MsgN = MsgN
local ErrorNoHalt = ErrorNoHalt
local IsValid = IsValid
local rawget = rawget
local rawset = rawset

module('articulate')

function ModelQueryBuilder(connection, model)
	return new ('ArticulateModelQueryBuilder', connection):setModel(model)
end