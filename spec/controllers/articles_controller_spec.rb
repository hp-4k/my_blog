require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  
  describe 'GET :index' do
    
    before :each do
      @user = create(:user) do |user|
        user.articles.create(attributes_for(:article))
        user.articles.create(attributes_for(:other_article))
      end
      @other_user = create(:other_user) do |other_user|
        other_user.articles.create(attributes_for(:article3))
      end
      get :index, id: @user.slug
    end
    
    it "assigns the specified user to @user" do
      expect(assigns(:user)).to eq @user
    end
    
    it "assigns all user's articles to @articles" do
      expect(assigns(:articles)).to include(@user.articles[0])
      expect(assigns(:articles)).to include(@user.articles[1])
    end
    
    it "does not assign other user's articles to @articles" do
      expect(assigns(:articles)).not_to include(@other_user.articles.first)
    end
    
    it "renders the index view" do
      expect(response).to render_template(:index)
    end
    
  end
  
  describe 'GET :show' do
    
    before :each do
      @user = create(:user)
      @article = @user.articles.create(attributes_for(:article))
      get :show, id: @article.slug # use pretty urls
    end
    
    it "assigns the specified article to @article" do
      expect(assigns(:article)).to eq @article
    end
    
    it "assigns the article's author to @user" do
      expect(assigns(:user)).to eq @user
    end
    
    it "renders the show view" do
      expect(response).to render_template(:show)
    end
    
  end
  
end
