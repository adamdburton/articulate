class 'User' extends 'ArticulateModel' is {
	
	getFullNameAttribute = function()
		return string.format('%s %s', self.firstName, self.lastName)
	end
	
}