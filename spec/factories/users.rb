FactoryGirl.define do 
  factory :user do
    name "foobar"
    email "foo@bar.baz"
    password "foobar"
    password_confirmation "foobar"
  end
end