class LoginScreen < PM::Screen
  	include ChaWork::Basic
  	include ChaWork::Message

  	attr_accessor :delegate 

	title "登录"
	
	def delegate=(parent)
		@delegate = WeakRef.new(parent)
	end

	def view_did_load
		view.backgroundColor = UIColor.whiteColor

		set_nav_bar_button :left, title: '返回', action: :close_screen
		set_nav_bar_button :right, title: '注册', action: :signup
		
		view << bottom_line('20,80,280,30')
	    view << @email 	  = textfield('20,80,280,30', '登录邮箱')
	    view << bottom_line('20,125,280,30')
	    view << @password = password_field('20,125,280,30', '密码')
     	view << bbutton('登录', '20,170,280,40', :success, 'login')

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
		end
		true
	end

	def login
		return unless validate
		wait_msg
		User.login(@email.text, @password.text) do |user, error|
			# 登录成功
			if !error
				msg('登录成功', :success)
				login_success
			else
				msg('邮箱或密码不正确', :failure)
				# msg(error.description, :failure)
			end
		end
	end

	def signup
		open SignupScreen.new(delegate: self)
	end

	def login_success
		if @delegate.respond_to?(:login_success)
			@delegate.login_success
		end
		close_screen
	end
end
