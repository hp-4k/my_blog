require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  it { is_expected.to validate_presence_of :commenter }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to(:article) }
  
end
