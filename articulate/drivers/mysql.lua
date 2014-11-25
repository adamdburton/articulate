class 'MySQLArticulateDriver' extends 'ArticulateDriver' is {
	
	private 'connection' = nil,
	
	__construct = function(self, hostname, username, password, database)
		
		if mysqloo then
			
		else
			
		end
		
	end
	
}

articulate.RegisterDriver('mysql', 'MySQLArticulateDriver')