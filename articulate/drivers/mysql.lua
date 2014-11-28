require('mysqloo')
require('tmysql4')

class 'MySQLArticulateDriver' extends 'ArticulateDriver' is {
	
	connection = nil,
	connected = false,
	
	__construct = function(self, hostname, username, password, database, port, socketPath)
		
		port = port or 3306
		
		if mysqloo then
			
			local dbConnection = mysqloo.connect(hostname, username, password, database, port)
			
			function dbConnection.onConnected()
				self.connection = dbConnection
				self.connected = true
			end
			
			function dbConnection.onConnectionFailed(db, err)
				throw ''
			end
			
			dbConnection:connect()
			
		elseif tmysql
			
			local dbConnection, dbError = tmysql.initialize(hostname, username, password, databas, port, socketPath)
			
			if dbConnection then
				self.connection = dbConnection
				self.connected = true
			elseif dbError then
				
			end
			
			
			
		end
		
	end
	
}

articulate.RegisterDriver('mysql', 'MySQLArticulateDriver')