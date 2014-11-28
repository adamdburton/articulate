class 'ArticulateModel' is {
	
	connection = '',
	table = nil,
	primaryKey = 'id',
	perPage = 15,
	incrementing = true,
	timestamps = true,
	attributes = {},
	original = {},
	relations = {},
	with = {},
	
	exists = false,
	
	__construct = function(self, attributes)
		self::fill(attributes)
	end,
	
	-- Table
	
	getTable = function(self)
		if not self.table then
			self.table = snakeCase(self.__className)
		end
		
		return self.table
	end,
	
	-- Filling
	
	fill = function(self, attributes)
		for key, value in pairs(attributes) do
			self.attributes[key] = value
		end
	end,
	
	-- Finding
	
	find = function(self, id)
		return self::newQuery()->where(self.primaryKey, id)->first()
	end,
	
	where = function(self, ...)
		return self::newQuery()->where(unpack(...))
	end,
		
	limit = function(self, limit)
		return self::newQuery()->limit(limit)
	end,
	
	orderBy = function(self, orderBy, sort)
		return self::newQuery()->orderBy(orderBy, sort)
	end
	
	-- Queries
	
	newQueryBuilder = function(self)
		return articulate.ModelQueryBuilder(self.connection):setModel(self)
	end
	
	newQuery = function(self)
		return self:newQueryBuilder():with(self.with)
	end,
	
	-- Relations
	
	with = function(self, ...)
		local instance = new (self.__className);
		
		return instance:newQuery():with(unpack(...));
	end,
	
	hasOne = function(self, related, foreignKey, localKey)
		local instance = new related
		
		foreignKey = foreignKey or self:getForeignKey()
		localKey = localKey or self:getKeyName()
		
		return new ('HasOne', instance:newQuery(), self, instance:getTable() .. '.' .. foreignKey, localKey)
	end,
	
	belongsTo = function(self, related, foreignKey, otherKey, relation)
		relation = relation or -- find calling function name using debug library
		foreignKey = foreignKey or snakeCase($relation) .. '_id'
		
		local instance = new (related)
		local query = instance:newQuery()
		
		otherKey = otherKey or instance:getKeyName()
		
		return new ('BelongsTo', query, self, foreignKey, otherKey, relation)
	end,
	
	hasMany = function(self, related, foreignKey, localKey)
		foreignKey = foreignKey or self:getForeignKey()
		
		local instance = new (related)
		
		localKey = localKey or self:getKeyName();
		
		return new ('HasMany', instance:getQuery(), self, instance:getTable() .. '.' .. foreignKey, localKey)
	end,
		
	hasManyThrough = function(self, related, through, firstKey, secondKey)
		through = new (through)
		
		firstKey = firstKey or self:getForeignKey()
		secondKey = secondKey or through:getForeignKey()
		
		local related = new (related)
		local query = related:newQuery()
		
		return new ('HasManyThrough', query, self, through, firstKey, secondKey)
	end,
	
	belongsToMany = function(self, related, table, foreignKey, otherKey, relation)
		relation = relation or self:getBelongsToManyCaller()
		foreignKey = foreignKey or self:getForeignKey()
		
		local instance = new (related)
		
		otherKey = otherKey or instance:getForeignKey()
		table = table or self:joiningTable(related)
		
		local query = instance:newQuery()
		
		return new ('BelongsToMany', self, table, foreignKey, otherKey, relation)
	end,
	
	getBelongsToManyCaller = function()
		--[[
	        $self = __FUNCTION__;
	        $caller = array_first(debug_backtrace(false), function ($key, $trace) use($self) {
	            $caller = $trace['function'];
	            return !in_array($caller, Model::$manyMethods) && $caller != $self;
	        });
	        return !is_null($caller) ? $caller['function'] : null;
		]]
	end
	
	-- Pagination
	
	paginate = function(self)
		self:newQuery():limit(self.perPage)
	end
	
}