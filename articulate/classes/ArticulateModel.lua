class 'ArticulateModel' is {
	
	connection = '',
	table = '',
	primaryKey = 'id',
	perPage = 15,
	incrementing = true,
	timestamps = true,
	attributes = {},
	original = {},
	relations = {},
	with = {},
	morphClass = '',
	exists = false,
	
	__construct = function(self, attributes)
		self::fill(attributes)
	end,
	
	fill = function(self, attributes)
		for key, value in pairs(attributes) do
			self.attributes[key] = value
		end
	end,
	
}