# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :menu_item do
    menu_id 1
    title "MyString"
    list_order 1
  end
end
