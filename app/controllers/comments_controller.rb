class CommentsController < ApplicationController

	def index
		@comments = Comment.hash_tree
	end

	def show
		@comment = Comment.find(params[:id])
	end

	def new
		@article = Article.find(params[:article_id])
		@comment = Comment.new(parent_id: params[:parent_id])
	end

	def create
		if params[:comment][:parent_id].to_i > 0
	    parent = Comment.find_by_id(params[:comment].delete(:parent_id))
	    @comment = parent.children.build(comment_params)

		  if @comment.save
	    	flash[:success] = 'Your comment was successfully added!'
	    	 redirect_to article_path(params["comment"]["article_id"].to_i)
	  	else
	    	render 'new'
	  	end

  	else
  		@article = Article.find(params[:article_id])
    	@comment = @article.comments.create(comment_params)
    	redirect_to article_path(@article)
  	end
	end

	private

	def comment_params
		params.require(:comment).permit(:title, :body, :article_id).merge(user_id: current_user.id)
	end

end


