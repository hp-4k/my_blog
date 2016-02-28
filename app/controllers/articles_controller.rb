class ArticlesController < ApplicationController
  
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_author, only: [:edit, :update, :destroy]
  
  def index
    @user = User.friendly.find(params[:id])
    @articles = @user.articles
  end
  
  def show
    @article = Article.friendly.find(params[:id])
    @user = @article.user
  end
  
  def new
    @article = current_user.articles.build
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_url(@article.slug)
    else
      render :new
    end
  end
  
  def edit
    @article = Article.friendly.find(params[:id])
  end
  
  def update
    @article = Article.friendly.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Article updated."
      redirect_to article_url(@article.slug)
    else
      render :edit
    end
  end
  
  def destroy
    article = Article.friendly.find(params[:id])
    user = article.user
    article.destroy
    flash[:success] = 'Your post has been deleted.'
    redirect_to articles_for_user_url(user.slug)
  end
  
  private
  
    def article_params
      params.require(:article).permit(:title, :content)
    end
  
    def require_login
      unless logged_in?
        flash[:warning] = "You need to sign in to access this page."
        redirect_to root_url
      end
    end
    
    def require_author
      unless current_user?(Article.friendly.find(params[:id]).user)
        flash[:warning] = "You don't have permission to access this page."
        redirect_to root_url
      end
    end
  
end
