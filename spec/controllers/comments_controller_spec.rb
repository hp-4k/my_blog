require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST :create" do
    
    before :each do
      user = create(:user)
      @article = user.articles.create(attributes_for(:article))
    end
    
    context "with invalid params" do
      
      before :each do
        post :create, comment: attributes_for(:invalid_comment), article: @article.slug
      end
      
      it "does not create a new comment" do
        expect(@article.comments.count).to eq 0
      end
      
      it "renders the article view" do
        expect(response).to render_template('articles/show')
      end
      
    end
    
    context "with valid params" do
    
      before :each do
        post :create, comment: attributes_for(:comment), article: @article.slug
      end
      
      it "creates a new comment" do
        expect(@article.comments.count).to eq 1
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the article commented on" do
        expect(response).to redirect_to article_url(@article.slug)
      end
      
    end
    
  end
  
  describe "DELETE :destroy" do
    
    before :each do
      @user = create(:user)
      @article = @user.articles.create(attributes_for(:article))
      @comment = @article.comments.create(attributes_for(:comment))
    end
    
    context "when not logged in" do
        
      before :each do
        delete :destroy, id: @comment.id
      end
      
      it "does not delete the comment" do
        expect(Comment.count).to eq 1
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to root_url
      end
      
    end
    
    context "when logged in as a wrong user" do
      
      before :each do
        other_user = create(:other_user)
        log_in(other_user)
        delete :destroy, id: @comment.id
      end
      
      it "does not delete the comment" do
        expect(@article.comments.count).to eq 1
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to root_url
      end
      
    end
    
    context "when logged in as the article owner" do
      
      before :each do
        log_in(@user)
        delete :destroy, id: @comment.id
      end
      
      it "deletes the comment" do
        expect(@article.reload.comments).to be_empty
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the article page" do
        expect(response).to redirect_to article_url(@article.slug)
      end
      
    end
    
  end

end
