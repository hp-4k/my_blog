FactoryGirl.define do
  
  factory :comment do
    commenter "Commenter"
    body "Comment body"
  end
  
  factory :invalid_comment, class: Comment do
    commenter nil
    body nil
  end

end
