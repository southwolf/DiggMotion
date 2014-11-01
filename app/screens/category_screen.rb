class CategoryScreen < PM::GroupedTableScreen
  attr_accessor :delegate

  title "请选择种类"

  def on_load
    set_nav_bar_button :left, title: '取消', action: :close_screen
  end

  def table_data
    [{
      title: 'Category',
      cells: Config::CATEGORY.map{|name| {title: name, action: :select} } 
    }]
  end

  def select(args, index_path)
    category = Config::CATEGORY[index_path.row]
    if @delegate.respond_to? :on_select
      @delegate.on_select(category)
      close_screen
    end
  end

  def delegate=(parent)
    @delegate = WeakRef.new(parent)
  end

end