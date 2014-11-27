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
local FindMetaTable = FindMetaTable
local rawget = rawget
local rawset = rawset

module('articulate')

local drivers = {}
local connections = {}

function AvailableDrivers()
	return drivers
end

function RegisterDriver(name, className)
	drivers[name] = className
end

function Connection(driver, connectionInfo)
	return new (drivers[name], unpack(connectionInfo))
end

function QueryBuilder(connection)
	return new ('ArticulateQueryBuilder', connection)
end

function ModelQueryBuilder(connection)
	return new ('ArticulateModelQueryBuilder', connection)
end