class ArticlesController < ApplicationController
  
  def index
    @user = User.friendly.find(params[:id])
    @articles = @user.articles
  end
  
  def show
    @article = Article.find(params[:id])
    @user = @article.user
  end
  
end
