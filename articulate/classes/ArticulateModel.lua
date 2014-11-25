class 'ArticulateModel' is {
	
	protected 'connection' = '',
	protected 'table' = '',
	protected 'primaryKey' = 'id',
	protected 'perPage' = 15,
	protected 'incrementing' = true,
	protected 'timestamps' = true,
	protected 'attributes' = {},
	protected 'original' = {},
	protected 'relations' = {},
	protected 'with' = {},
	
	public 'exists' = false,
	
	__construct = function(self, attributes)
		self::fill(attributes)
		
		self::
	end,
	
	public 'fill' = function(self, attributes)
		for key, value in pairs(attributes) do
			self.attributes[key] = value
		end
	end,
	
	public 'find' = function(self, id)
		return self::newQuery()->where(self.primaryKey, id)->first()
	end,
	
	public 'where' = function(self, ...)
		return self::newQuery()->where(unpack(...))
	end,
		
	public 'limit' = function(self, limit)
		return self::newQuery()->limit(limit)
	end,
	
	public 'orderBy' = function(self, orderBy, sort)
		return self::newQuery()->orderBy(orderBy, sort)
	end
	
	-- Queries
	
	private 'newQueryBuilder' = function(self)
		return articulate.QueryBuilder(self.connection):setTable(self.table)
	end
	
	public 'newQuery' = function(self)
		return self:newQueryBuilder():with(self.with)
	end,
	
	-- Relations
	
	public 'with' = function(self, ...)
		local instance = new (self.__className);
		
		return instance:newQuery():with(unpack(...));
	end,
	
	public 'hasOne' = function(self, related, foreignKey, localKey)
		local instance = new related
		
		foreignKey = foreignKey or self:getForeignKey()
		localKey = localKey or self:getKeyName()
		
		return new ('HasOne', instance:newQuery(), self, instance:getTable() .. '.' .. foreignKey, localKey)
	end,
	
	public 'belongsTo' = function(self, related, foreignKey, otherKey, relation)
		relation = relation or -- find calling function name using debug library
		foreignKey = foreignKey or snakeCase($relation) .. '_id'
		
		local instance = new (related)
		local query = instance:newQuery()
		
		otherKey = otherKey or instance:getKeyName()
		
		return new ('BelongsTo', query, self, foreignKey, otherKey, relation)
	end,
	
	public 'hasMany' = function(self, related, foreignKey, localKey)
		foreignKey = foreignKey or self:getForeignKey()
		
		local instance = new (related)
		
		localKey = localKey or self:getKeyName();
		
		return new ('HasMany', instance:getQuery(), self, instance:getTable() .. '.' .. foreignKey, localKey)
	end,
		
	public 'hasManyThrough' = function(self, related, through, firstKey, secondKey)
		through = new (through)
		
		firstKey = firstKey or self:getForeignKey()
		secondKey = secondKey or through:getForeignKey()
		
		local related = new (related)
		local query = related:newQuery()
		
		return new ('HasManyThrough', query, self, through, firstKey, secondKey)
	end,
	
	public 'belongsToMany' = function(self, related, table, foreignKey, otherKey, relation)
		relation = relation or self:getBelongsToManyCaller()
		foreignKey = foreignKey or self:getForeignKey()
		
		local instance = new (related)
		
		otherKey = otherKey or instance:getForeignKey()
		table = table or self:joiningTable(related)
		
		local query = instance:newQuery()
		
		return new ('BelongsToMany', self, table, foreignKey, otherKey, relation)
	end,
	
	protected 'getBelongsToManyCaller' = function()
		--[[
	        $self = __FUNCTION__;
	        $caller = array_first(debug_backtrace(false), function ($key, $trace) use($self) {
	            $caller = $trace['function'];
	            return !in_array($caller, Model::$manyMethods) && $caller != $self;
	        });
	        return !is_null($caller) ? $caller['function'] : null;
		]]
	end
	
}