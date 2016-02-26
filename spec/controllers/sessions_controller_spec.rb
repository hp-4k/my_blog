require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  
  describe "POST #create" do

    before :each do
      @user = create(:user)
    end
    
    context "with correct credentials" do
      
      before :each do
        post :create, session: { email: @user.email, password: @user.password }
      end
      
      it "logs the user in" do
        expect(current_user).to eq @user
      end
      
      it "redirects to user page" do
        expect(response).to redirect_to @user
      end
      
    end
    
    context "with incorrect credentials" do
      
      before :each do
        post :create, session: { email: 'invalid', password: 'wrong' }
      end
      
      it "does not log the user in" do
        expect(current_user).to be nil
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "renders 'pages/home' view" do
        expect(response).to render_template('pages/home')
      end
      
    end
    
  end
  
  describe "DELETE #destroy" do
    
    before :each do
      @user = create(:user)
      log_in(@user)
      delete :destroy
    end
    
    it "logs the user out" do
      expect(current_user).to be nil
    end
    
    it "sets a flash message" do
      expect(flash).not_to be_empty
    end
    
    it "redirects to the home page" do
      expect(response).to redirect_to root_url
    end
    
  end

end
