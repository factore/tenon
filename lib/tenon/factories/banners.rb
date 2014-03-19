FactoryGirl.define do
  factory :banner, class: Tenon::Banner do
    sequence(:title) { |n| "Test Banner - #{n}" }
    file_id { create(:asset).id }
  end
end
