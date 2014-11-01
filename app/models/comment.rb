class Comment
	include LM::Model

	fields :content, :user, :digg
	
	def user
		User.new getField(:user)
	end

	def digg
		Digg.new getField(:digg)
	end

end