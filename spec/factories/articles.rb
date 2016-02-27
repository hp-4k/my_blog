FactoryGirl.define do
  
  factory :article do
    title "Article title"
    content "Article content"
  end
  
  factory :invalid_article, class: Article do
    title nil
    content nil
  end
  
  factory :other_article, class: Article do
    title "Other article title"
    content "Other article content"
  end
  
  factory :article3, class: Article do
    title "Article title 3"
    content "Article content 3"
  end

end
