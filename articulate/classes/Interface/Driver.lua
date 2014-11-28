interface 'ArticulateDriver' {
	
	connection = nil,
	connected = false,
	
	affectedRows = 0,
	insertID = 0,
	
	connect = function() end,
	query = function() end,
	
}