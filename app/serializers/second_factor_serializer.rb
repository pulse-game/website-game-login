class SecondFactorSerializer < ApplicationSerializer
	attributes 	:id,
				:user_id,
				:method,
				:enabled,
				:name
	
	def id
		object.id
	end
	
	def user_id
		object.user_id
	end
	
	def method
		object.method
	end
	
	def enabled
		object.enabled
	end
	
	def name
		object.name
	end
end