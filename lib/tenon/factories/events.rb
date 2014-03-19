FactoryGirl.define do
  factory :event, class: Tenon::Event do
    sequence(:title) { |n| "Test Event - #{n}" }
    starts_at Time.now
    ends_at Time.now + 1.hour
  end
end
