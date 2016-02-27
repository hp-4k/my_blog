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
    
    it "renders the 'show' view" do
      expect(response).to render_template(:show)
    end
    
  end
  
  describe 'GET :new' do
    
    before :each do
      @user = create(:user)
    end
    
    context "when logged in" do
      
      before :each do
        log_in(@user)
        get :new
      end
      
      it "assigns a blank article to @article" do
        expect(assigns(:article)).to be_an(Article)
      end
      
      it "renders the 'new' view" do
        expect(response).to render_template(:new)
      end
      
    end
    
    context "when not logged in" do
      
      before :each do
        get :new
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to root_url
      end
      
    end
    
  end
  
  describe "POST :create" do
    
    before :each do
      @user = create(:user)
    end
    
    context "when logged in" do
    
      before :each do
        log_in(@user)
      end
    
      context "with valid parameters" do
        
        before :each do
          post :create, article: attributes_for(:article)
        end
        
        it "creates a new article" do
          expect(@user.articles.count).to eq 1
        end
        
        it "redirects to the article page" do
          article = @user.articles.last
          expect(response).to redirect_to article_url(article.slug)
        end
        
      end
      
      context "with invalid parameters" do
        
        before :each do
          post :create, article: attributes_for(:invalid_article)
        end
        
        it "does not create a new article" do
          expect(@user.articles).to be_empty
        end
        
        it "renders the form again" do
          expect(response).to render_template(:new)
        end
        
      end
      
    end
    
    context "when not logged in" do
      
      before :each do
        post :create, article: attributes_for(:article)
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to root_url
      end
      
    end
    
  end
  
end
