FactoryGirl.define do
  factory :comment, class: Tenon::Comment do
    author_email 'sean@factore.ca'
    author_url 'www.factore.ca'
    author 'Sean Roberts'
    content 'Test Comment'
    commentable { create(:post) }
    bypass_humanizer true
  end
end
