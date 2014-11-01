class Digg
	include LM::Model

	fields :title, :tagline, :url, :like_count, :like_users, :comment_count, :user, :category

  	def user
    	User.new getField(:user)
  	end

	def like?
	    return false unless User.login?
	    users = getField(:like_users) || []
	    users.include? User.current.objectId
	end

end