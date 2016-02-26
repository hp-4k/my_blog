require 'rails_helper'

RSpec.describe User, type: :model do
 
  subject { FactoryGirl.build(:user) }
  
  # name validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(4) }
  it { is_expected.to validate_uniqueness_of(:name) }
  
  # email validations
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_values(
    "user@example.com",
    "USER@foo.COM",
    "A_US-ER@foo.bar.org",
    "first.last@foo.jp",
    "alice+bob@baz.cn").for(:email) }
  it { is_expected.not_to allow_values(
    "user@example,com",
    "user_at_foo.org",
    "user.name@example.",
    "foo@bar_baz.com",
    "foo@bar+baz.com").for(:email) }
  
  # password validations
  it { is_expected.to have_secure_password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  
  # associations
  it { is_expected.to have_many :articles }
  
end
