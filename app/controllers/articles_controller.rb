class ArticlesController < ApplicationController
  
  def index
    @user = User.friendly.find(params[:id])
    @articles = @user.articles
  end
  
end
