require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    
    it "assigns a new user to @user" do
      get :new
      expect(assigns(:user)).to be_a(User)
    end
    
    it "renders the :new view" do
      get :new
      expect(response).to render_template(:new)
    end
    
  end
  
  describe "POST #create" do

    context "with valid data" do
      
      before :each do
        post :create, user: attributes_for(:user)
      end
      
      it "creates a new user" do
        expect(User.count).to eq 1
      end
      
      it "logs the user in" do
        expect(logged_in?).to be true
      end
      
      it "redirects to user's articles page" do
        expect(response).to redirect_to articles_for_user_url(User.last.slug)
      end
      
    end
    
    context "with invalid data" do

      before :each do
        post :create, user: attributes_for(:invalid_user)
      end

      it "renders the :new view" do
        expect(response).to render_template(:new)
      end
      
      it "does not create a new user" do
        expect(User.count).to eq 0
      end
      
    end
    
  end

end
