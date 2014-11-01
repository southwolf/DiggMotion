class User
  include LeanMotion::User

  fields :name, :profile, :photo
  
  def self.current
    User.new AVUser.currentUser
  end

  def id
    self.objectId
  end

  # 是否存在
  def self.exist? username
    self.where(:username => username).count > 0
  end

  # 是否已登录
  def self.login?
    AVUser.currentUser
  end

  def like(digg)
    digg.like_users = [] if digg.like_users.nil?
    
    if digg.like? 
      digg.like_count -= 1
      digg.like_users -= [self.objectId]
    else
      digg.like_count += 1
      digg.like_users += [self.objectId]
    end 
    digg.save
  end

end