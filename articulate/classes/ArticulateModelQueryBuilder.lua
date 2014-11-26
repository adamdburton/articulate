class 'ArticulateModelQueryBuilder' extends 'ArticulateQueryBuilder' is {
	
	private 'model' = nil,
	
	__construct = function(self, connection)
		self.connection = connection
	end,
	
	public 'setModel' = function(self, model)
		self.model = model
		
		return self:setTable(model:getTable())
	end,
	
}