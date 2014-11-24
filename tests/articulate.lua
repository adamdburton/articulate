articulate.RegisterClass('User', {
	
	getFullNameAttribute = function()
		return string.format('%s %s', self.firstName, self.lastName)
	end
	
})

class 'ArticulateModel' is {
	
	
	
}

class 'User' extends 'ArticulateModel' with {
	
}