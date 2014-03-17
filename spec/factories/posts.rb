FactoryGirl.define do
  factory :post, class: Tenon::Post do
    title 'Test Post'
    excerpt 'Lorem ipsum test post'
  end
end