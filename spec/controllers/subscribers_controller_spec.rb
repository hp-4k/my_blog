require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do
  
  describe "POST :create" do
    
    before :each do
      @user = create(:user)
      request.env["HTTP_REFERER"] = 'original_page'
    end
    
    context "with a valid email" do
      
      before :each do
        post :create, subscriber: attributes_for(:subscriber), user: @user.slug
      end
      
      it "adds a new subscriber" do
        expect(@user.subscribers.count).to eq 1
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the referrer" do
        expect(response).to redirect_to 'original_page'
      end
      
    end
    
    context "with an invalid email" do
      
      before :each do
        post :create, subscriber: attributes_for(:invalid_subscriber), user: @user.slug
      end
      
      it "does not add a new subscriber" do
        expect(@user.subscribers.count).to eq 0
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the referrer" do
        expect(response).to redirect_to 'original_page'
      end
      
    end
    
  end
  
  describe "GET #unsubscribe" do
    
    before :each do
      @user = create(:user)
      @subscriber = @user.subscribers.create(attributes_for(:subscriber))
    end
    
    context "with valid parameters" do
      
      before :each do
        get :unsubscribe, id: @subscriber.id, token: @subscriber.unsubscribe_token
      end
      
      it "cancels the subscription" do
        expect(@user.subscribers.count).to eq 0
      end
      
      it "sets a flash message" do
        expect(flash).not_to be_empty
      end
      
      it "redirects to the home page" do
        expect(response).to redirect_to root_url
      end
      
    end
    
    context "with invalid paramteres" do
      
      before :each do
        get :unsubscribe, id: @subscriber.id, token: 'invalid'
      end
      
      it "does not remove the subscription" do
        expect(@user.subscribers.count).to eq 1
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
