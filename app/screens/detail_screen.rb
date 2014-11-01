class DetailScreen < PM::WebScreen
  title "网站"

  attr_accessor :digg

  def on_load
  	set_nav_bar_button :right, title: "评论(#{@digg.comment_count.to_i})", action: :show_comment
  end

  def content
    @digg.url.to_s.nsurl
  end

  def show_comment
  	open CommentScreen.new(digg: digg)
  end
  
end