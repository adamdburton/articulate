class 'SQLiteArticulateDriver' extends 'ArticulateDriver' is {
	
	connection = nil,
	
	__construct = function(self)
		
		
		
	end
	
}

articulate.RegisterDriver('sqlite', 'SQLiteArticulateDriver')