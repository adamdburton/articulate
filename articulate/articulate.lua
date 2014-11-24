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

function AvailableDrivers()
	drivers = {}
	
	local f, d = file.Find('articulate/drivers/*.lua', 'LUA')
	
	for k, v in pairs(f) do
		
	end
end