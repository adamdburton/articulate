class 'ArticulateModelQueryBuilder' extends 'PliantQueryBuilder' is {
	
	model = nil,
	
	__construct = function(self, connection)
		self.connection = connection
	end,
	
	setModel = function(self, model)
		self.model = model
		
		return self:setTable(model:getTable())
	end,
	
}