require 'rails_helper'

RSpec.describe Article, type: :model do

  subject { FactoryGirl.build(:article) }

  # title validations
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of :title }
  
  # content validations
  it { is_expected.to validate_presence_of :content }
  
  # associations
  it { is_expected.to belong_to :user }
  
end
