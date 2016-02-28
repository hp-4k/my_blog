FactoryGirl.define do
  factory :subscriber do
    user_id 1
    email "foo@bar.baz"
    unsubscribe_token nil
  end

end
