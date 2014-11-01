class ModifyScreen < PM::Screen
  	include ChaWork::Basic
  	include ChaWork::Message
  	title "修改资料"

	def view_did_load
    	view.backgroundColor = UIColor.whiteColor

    	user = User.current
	    view << bottom_line('20,80,280,30')
	    view << @name 	  = textfield('20,80,280,30', '名字', user.name)
	    view << bottom_line('20,125,280,30')
	    view << @profile = textfield('20,125,280,30', '简介', user.profile)
	    
        view << bbutton('保存', '20,175,280,40', :success, 'save')

	    @name.on
  	end

	def validate
		if @name.text == ""
			msg('请输入名字', :failure)
			@name.on
			return false
		end
		true
	end

	def save
		return unless validate
		
		wait_msg
		user = User.current
		user.name 		= @name.text
		user.profile 	= @profile.text

		if user.save
			msg('修改成功', :success)
    		close_screen
    	end
	end

end
