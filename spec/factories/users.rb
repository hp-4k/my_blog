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
  
  factory :other_user, class: User do
    name "foobar2"
    email "foo2@bar.baz"
    password "foobar2"
    password_confirmation "foobar2"
  end
  
end