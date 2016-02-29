require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  
  subject { build(:subscriber) }
  
  # associations
  it { is_expected.to belong_to :user }
  
  # email validations
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).scoped_to(:user_id)
    .with_message('is already subscribed to this user')
    .case_insensitive }
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
  
  describe 'upon creation' do
    
    it "generated an unsubscribe token" do
      subscriber = create(:subscriber)
      expect(subscriber.unsubscribe_token).to be_a(String)
    end
    
  end
  
end
