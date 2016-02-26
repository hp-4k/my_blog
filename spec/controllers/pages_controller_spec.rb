require 'rails_helper'

RSpec.describe HighVoltage::PagesController, type: :controller do
  
  context "on GET to /pages/home" do
    
    before do
      get :show, id: 'home'
    end

    it { should respond_with(:success) }
    it { should render_template(:home) }
    
  end
  
end