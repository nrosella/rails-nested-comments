class ArticlesController < ApplicationController
	
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@comments = Comment.hash_tree
		@show = params[:id].to_i
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.create(article_params)
		if @article.save
			redirect_to article_path(@article)
		else
			render :new
		end
	end

	private
	def article_params
		params.require(:article).permit(:title, :body)	
	end

end