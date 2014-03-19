FactoryGirl.define do
  factory :post, class: Tenon::Post do
    title 'Test Post'
    excerpt 'Lorem ipsum test post'
  end

  factory :post_category, class: Tenon::PostCategory do
    sequence(:title) { |n| "Test Post Category - #{n}" }
  end
end
