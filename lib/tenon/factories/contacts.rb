FactoryGirl.define do
  factory :contact, class: Tenon::Contact do
    email 'jamie@factore.ca'
    phone '555.555.5555'
    name 'Jamie Allen'
    content 'This is the message!'
    bypass_humanizer true
  end
end
