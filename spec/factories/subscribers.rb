FactoryGirl.define do
  
  factory :subscriber do
    email "foo@bar.baz"
    unsubscribe_token nil
  end
  
  factory :invalid_subscriber, class: Subscriber do
    email 'bad'
  end

end
