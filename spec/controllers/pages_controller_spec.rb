require 'rails_helper'

RSpec.describe HighVoltage::PagesController, type: :controller do
  
  describe "GET to /pages/home" do
    
    before do
      get :show, id: 'home'
    end
    
    it "renders the 'home' template" do 
      expect(response.status).to eq 200
      expect(response).to render_template(:home)
    end
    
  end
  
end