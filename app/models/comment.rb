class Comment < ActiveRecord::Base
	
	acts_as_tree order: 'created_at DESC'

	def show_replies_text
		self.root? && self.leaf? ? true : false
	end

end
