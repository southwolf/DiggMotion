class PasswordScreen < PM::Screen
  	include ChaWork::Basic
  	include ChaWork::Message
  	title "修改密码"

	def view_did_load
    	view.backgroundColor = UIColor.whiteColor

	    view << bottom_line('20,80,280,30')
	    view << @old 	  = password_field('20,80,280,30', '原密码')
	    view << bottom_line('20,125,280,30')
	    view << @new = password_field('20,125,280,30', '新密码')
	    view << bottom_line('20,170,280,30')
	    view << @confirm  = password_field('20,170,280,30', '确认密码')

        view << bbutton('保存', '20,220,280,40', :success, 'save')
  
	    @old.on
  	end

	def validate
		if @old.text == ""
			msg('请输入原密码', :failure)
			@old.on
			return false
		elsif @new.text == ""
			msg('请输入新密码', :failure)
			@new.on
			return false
		elsif @new.text.length < 6
			msg('密码至少6位', :failure)
			@new.on
			return false	
		elsif @confirm.text == ""
			msg('请输入确认密码', :failure)
			@confirm.on
			return false
		elsif @new.text != @confirm.text
			msg('两次密码不一致', :failure)
			@confirm.on
			return false
		else
			# User.login(User.current.username, @new.text) do |user, error|
			# 	msg('原密码不正确', :failure)
			# 	@new.on
			# 	return false if error
			# end
		end
		true
	end

	def save
		return unless validate
		wait_msg

		User.login(User.current.username, @old.text) do |user, error|
			if !error
				save_password
			else
				msg('原密码不正确', :failure)
				@old.on
			end
		end
	end

	def save_password
		user = User.current
		user.password = @new.text

		if user.save
			msg('修改成功', :success)
    		close_screen
    	end
    end

end
