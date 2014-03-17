FactoryGirl.define do
  factory :page, class: Tenon::Page do
    sequence(:title) { |n| "Test Page - #{n}" }
  end
end