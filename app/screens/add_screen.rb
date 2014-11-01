class AddScreen < PM::Screen
  	include ChaWork::Basic
  	include ChaWork::Message
  	title "提交"

  	attr_accessor :delegate

  	def delegate=(parent)
  		@delegate=WeakRef.new(parent)
  	end

	def on_load
    	view.backgroundColor = UIColor.whiteColor

	    view << bottom_line('20,80,280,30')
	    view << @title 	  	= textfield('20,80,280,30', '名称')
	    view << bottom_line('20,125,280,30')
	    view << @tagline  	= textfield('20,125,280,30', '一句话描述')
	    view << bottom_line('20,170,280,30')
	    view << @url  	  	= textfield('20,170,280,30', '网址')
	    view << @category_btn  = bbutton('请选择类别', '20,220,140,40', :default)
	    @category_btn.on_tap do
	    	open_modal CategoryScreen.new(nav_bar: true, delegate: self)
	    end

	    view << bbutton('提交', '20,275,280,40', :info, 'save')
	    @title.on
  	end

  	def on_select(name)
  		@category_btn.title = name
  		@category = name
  	end

	def validate
		if @title.text == ""
			msg('请输入名称', :failure)
			return false
		elsif @tagline.text == ""
			msg('请输入一句话描述', :failure)
			return false
		elsif @url.text == ""
			msg('请输入网址', :failure)
			return false
		elsif @category.nil?
			msg('请选择类别', :failure)	
			return false
		end
		true
	end

	def save
		return unless validate
		
		wait_msg
		digg = Digg.new
		digg.title 		= @title.text
		digg.tagline 	= @tagline.text
		digg.url 		= @url.text
		digg.user 		= AVUser.currentUser
		digg.category 	= @category
		digg.like_users = [User.current.id]
		digg.like_count = 1
		if digg.save
			# 保存成功
			msg('提交成功', :success)
			if @delegate.respond_to?(:digg_saved)
				@delegate.digg_saved(digg)
			end
			close_screen
		end
	end

end
