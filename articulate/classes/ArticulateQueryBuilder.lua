class 'ArticulateQueryBuilder' is {
	
	private 'connection' = nil,
	private 'table' = '',
	
	__construct = function(self, connection)
		self.connection = connection
	end,
		
	public 'setTable' = function(self, table)
		self.table = table
		
		return self
	end,
	
	public 'with' = function(self, ...)
		local eagers = self:parseRelations(relations)
		
		self.eagerLoad = table.Merge(self.eagerLoad, eagers)
		
		return self	
	end
	
}