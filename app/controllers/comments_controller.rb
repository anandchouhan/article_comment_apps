class CommentsController < ApplicationController
	before_action :user_id
	before_action :authenticate_user!, only: [:create] 

	def new
		@article = Article.find(params[:article_id])
		@comment = Comment.new
	end

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		@comment.user_id = current_user.id
			if @comment.save
				redirect_to user_articles_path 
	 		else
	 			render 'new'
	 		end      
	end

	def index
		@article = Article.find(params[:article_id])
		@comments = Comment.all
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		if @comment.destroy
			redirect_to user_articles_path
		end
	end

	private
	def user_id
		@user = User.find_by(id: params[:user_id])
	end

	def comment_params
		params.require(:comment).permit(:text, :article_id, :user_id)
	end
end
