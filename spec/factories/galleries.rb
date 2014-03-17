FactoryGirl.define do
  factory :gallery, class: Tenon::Gallery do
    sequence(:title) {|n| "Test Gallery - #{n}" }
  end
end