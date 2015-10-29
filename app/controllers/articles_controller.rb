class ArticlesController < ApplicationController
	before_action :user_id
	before_action :authenticate_user!, only: [:create]

	def new
		@article = Article.new
	end

	def create
		@article = @user.articles.create(article_params)
		if @article.save
			redirect_to user_articles_path
		else
			render 'new'
		end	
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to user_articles_path
		end
	end

	def index
		@articles = Article.all.includes(:comments)
	end

	def destroy
		@article = Article.find(params[:id])
		if @article.destroy
			redirect_to user_articles_path
		end
	end

	def like
    @article = Article.find(params[:id])
    #@article.like.create
    redirect_to user_articles_path
	end

	def dislike
    @article = Article.find(params[:id])
    #@article.dislike_from current_user
    redirect_to user_articles_path
	end


	private
  def user_id
    @user = User.find_by(id: params[:user_id])
  end

  def article_params
	  params.require(:article).permit(:title, :user_id)
  end

  def get_vote
  current_article = @article.detect{|r| r.id == params[:id].to_i}
  @article = current_article.likes.find_by_user_id(current_user.id)
  unless @like
    @like = Like.create(:user_id => current_user.id, :value => 0)
    current_article.likes << @like
  end
end

end
