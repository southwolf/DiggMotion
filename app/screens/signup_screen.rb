class SignupScreen < PM::Screen
  	include ChaWork::Basic
  	include ChaWork::Message
  	title "注册"

  	attr_accessor :delegate

  	def delegate=(parent)
		@delegate = WeakRef.new(parent)
	end

	def view_did_load
    	view.backgroundColor = UIColor.whiteColor

    	set_nav_bar_button :left, title: '取消', action: :close_screen

	    view << bottom_line('20,80,280,30')
	    view << @email 	  = textfield('20,80,280,30', '登录邮箱')
	    view << bottom_line('20,125,280,30')
	    view << @password = password_field('20,125,280,30', '密码')
	    view << bottom_line('20,170,280,30')
	    view << @name  	  = textfield('20,170,280,30', '名字')

        view << bbutton('注册', '20,220,280,40', :success, 'signup')

	    @email.on
  	end

	def validate
		if @email.text == ""
			msg('请输入帐号', :failure)
			@email.on
			return false
		elsif @password.text == ""
			msg('请输入密码', :failure)
			@password.on
			return false
		elsif @password.text.length < 6
			msg('密码至少6位字符', :failure)
			return false
		elsif @name.text == ""
			@name.on
			msg('请输入名字', :failure)
			return false
		end
		true
	end

	def signup
		return unless validate
		
		wait_msg
		user = User.new
		user.username = @email.text
		user.password = @password.text
		user.name 	  = @name.text
		if user.signUp
			msg('注册成功', :success)
			if @delegate.respond_to?(:login_success)
				@delegate.login_success  # 退出登录页面
			end
    		close_screen
    	else
    		msg('该邮箱已注册', :failure)
    		@email.on
    	end
	end

end
