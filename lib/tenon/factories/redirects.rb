FactoryGirl.define do
  factory :tenon_redirect, class: Tenon::Redirect do
    sequence(:title) { |n| "Test Page - #{n}" }
    'in' '\/on-the-floor\/(\d+-.*)'
    'out' '/posts/{0}'
  end
end


