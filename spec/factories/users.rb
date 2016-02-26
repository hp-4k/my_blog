FactoryGirl.define do 
  factory :user do
    name "foobar"
    email "foo@bar.baz"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :invalid_user, class: User do
    name 'abc'
    email 'invalid'
    password 'short'
    password_confirmation 'does_not_match'
  end
end