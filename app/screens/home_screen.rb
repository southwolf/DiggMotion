class HomeScreen < PM::ChaTableScreen
	include ChaWork::Basic
	include ChaWork::Message

	title 'DiggMotion'
	refreshable

	def view_did_load
		set_nav_bar_button :left, title: "设置", action: :setting
    	set_nav_bar_button :right, system_item: :add, action: :add

    	init_data
		load_data
	end

	# ======================================
	# 初始化数据
	# ======================================

	def init_data
		@data = []
		@page = 1
		@menu_index = 0
		@category   = 'News'
	end

	def load_data
		wait_msg
		Digg.where(:category=>@category)
			.page(@page)
			.sort(:createdAt=>:desc)
			.find do |diggs, error|
			@data = diggs
			update_table_view
			hide_msg
		end
	end

	def reload_data
    	@page = 1
    	@data = []
		load_data
    end

	def on_refresh
		reload_data
		stop_refreshing
	end

	# ======================================
	# Menu
	# ======================================
	
	def header_height(secion_index)
		40
	end

	def header_view(secion_index)
		menu = ChaMenu.alloc.initWithFrame([[0, 0], [320, 40]])
      	menu.data = Config::CATEGORY
      	menu.delegate = self
      	menu.background_color 	= '#ECECEC'.uicolor
      	menu.selected_color		= '#c5333a'.uicolor 
      	menu.selected_index 	= @menu_index
      	menu.setup
      	menu
	end

	def selected_menu(index)
    	@menu_index = index
    	@category 	= Config::CATEGORY[index]
    	reload_data
    end


	# ======================================
	# 定义TableViewCell
	# ======================================
	
	def cell_height(index_path)
		110
	end

	def cell_action(index_path)
		digg = @data[index_path.row]
		open DetailScreen.new(digg: digg)
	end

	def table_view_cell(index_path)
		digg = @data[index_path.row]

		cell = empty_cell

	    like_btn_bg = digg.like? ? 'btn-like-pre' : 'btn-like'
	    cell << like_btn = image_btn(like_btn_bg, '15,5,30,80')
	    like_btn.on_tap do
	    	like(index_path)
	    end

	    cell << label(digg.like_count, '15,35,30,30', 14, false, '#000000', 'center')
		cell << label(digg.title, '60,20,250,18', 16)
		cell << context(digg.tagline, '60,40,250,40', 13, '#666666')
		cell << image('icn-comment', '60,85,12,12')
    	cell << label(digg.comment_count, '80,85,40,12', 12, false, '#666666')

		cell
	end

	def like(index_path)
		unless User.login?
			open_modal LoginScreen.new(nav_bar: true, delegate: self)
			return
		end

        digg = @data[index_path.row]
        User.current.like digg
        rows = [index_path]
		self.view.reloadRowsAtIndexPaths(rows, withRowAnimation:UITableViewRowAnimationNone)
	end

    
	# ======================================
	# 页面跳转，委托函数
	# ======================================
   	
    def setting
    	open SettingScreen
    end

    def add
    	if User.login?
    		open AddScreen.new(delegate: self)
    	else
    		open_modal LoginScreen.new(nav_bar: true, delegate: self)
    	end
    end

    # 登录成功
    def login_success
    	update_table_view
    end

    # Digg添加成功
    def digg_saved(digg)
    	@category = digg.category

    	hash = Hash[Config::CATEGORY.map.with_index.to_a]
    	@menu_index = hash[@category]
    	reload_data
    end

end