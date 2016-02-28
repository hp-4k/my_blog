class CommentsController < ApplicationController
  
  before_action :require_login, only: [:destroy]
  before_action :require_author, only: [:destroy]
  
  def create
    article = Article.friendly.find(params[:article])
    @comment = article.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'Your comment is now visible'
      redirect_to article_url(article.slug)
    else
      render 'articles/show', id: article.slug
    end
  end
  
  def destroy
    comment = Comment.find(params[:id]).destroy
    flash[:success] = 'Comment deleted.'
    redirect_to article_url(comment.article.slug)
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
  
    def require_login
      unless logged_in?
        flash[:warning] = "You need to sign in to be able to delete comments."
        redirect_to root_url
      end
    end
    
    def require_author
      unless current_user?(Comment.find(params[:id]).article.user)
        flash[:warning] = "You don't have permission to access this action."
        redirect_to root_url
      end
    end
  
end
