FactoryGirl.define do
  factory :tenon_callout, class: Tenon::TenonCallout do
    sequence(:title) { |n| "Test Tenon Callout - #{n}" }
    uri '/tenon/pages/new'
    icon 'file-o'
    button_text 'Go for it!'
    content 'Tenon Callout test content'
  end
end
