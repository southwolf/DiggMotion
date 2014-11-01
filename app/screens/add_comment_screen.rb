class AddCommentScreen < PM::Screen
  title "添加评论"
  include ChaWork::Basic
  include ChaWork::Message

  attr_accessor :digg, :delegate

  def delegate=(parent)
    @delegate = WeakRef.new(parent)
  end

  def on_load
    view.backgroundColor = UIColor.whiteColor
    self.automaticallyAdjustsScrollViewInsets = false

    set_nav_bar_button :right, title: '保存', action: :save

    view << @content = textview(frame: '10,0,300,150', font_size: 16)

    self.setEdgesForExtendedLayout(UIRectEdgeNone)
    
    @content.becomeFirstResponder
  end

  def save
    return unless validate
    msg('请稍候')
    comment = Comment.new
    comment.user    = User.current.AVUser
    comment.digg    = @digg.AVObject
    comment.content = @content.text

    if comment.save
      msg('评论发布成功', :success)
      if @delegate.respond_to?(:comment_saved)
      	@delegate.comment_saved(comment)
      end

      @digg.comment_count += 1
      @digg.save

      close_screen
    else
      msg('评论发布失败', :failure)
    end

  end


  def validate
    if @content.text == ''
      msg('请输入评论内容', :failure)
      return false
    elsif @content.text.length > 140
      msg('评论不能多于140字', :failure)
      return false
    end
    true
  end


end
