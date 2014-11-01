class CommentScreen < PM::ChaTableScreen
	include ChaWork::Basic
	include ChaWork::Message

	title '评论'

	attr_accessor :digg, :delegate

	def view_did_load
		set_nav_bar_button :right, system_item: :add, action: :add

    	@data = []
		@page = 1

		load_data
	end

	def load_data
		wait_msg
		query = Comment.query
		query.includeKey(:user)
		query.includeKey(:comment)
		query.findByHash(:digg=>@digg.AVObject)
			.sort(:createdAt=>:desc)
			.page(@page)
			.find do |comments, error|
			@data += comments
			update_table_view
			hide_msg
		end
	end
	
	def cell_height(index_path)
		comment = @data[index_path.row]
		content_height = comment.content.height(width: 240, size: 13)
		content_height + 50
	end

	def table_view_cell(index_path)
		comment = @data[index_path.row]
		user 	= comment.user

		cell = empty_cell
    	cell << image('Icon',     '15,10,25,25', 'photo', true)
    	cell << label(user.name,      '60,10,150,14', 14)
    	cell << label(user.profile,       '60,28,240,12', 12, false, '#CCCCCC')
    	cell << context(comment.content,  "60,45,240,0", 13)
    	cell.selectionStyle = UITableViewCellSelectionStyleNone
		cell
	end

	def add
		open AddCommentScreen.new(digg: @digg, delegate: self)
	end

	def comment_saved(comment)
		@data += [comment]
		update_table_view
	end

end