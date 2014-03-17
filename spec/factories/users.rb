FactoryGirl.define do
  factory :user, class: Tenon::User do
    sequence(:email) { |n| "user#{n}@factore.ca" }
    password 'password'
    approved true
  end

  factory :admin, parent: :user do
    email 'admin@factore.ca'
    roles { [Tenon::Role.find_by_title('Admin') || create(:admin_role)] }
  end

  factory :role, class: Tenon::Role do
    sequence(:title) { |n| "role-#{n}" }
  end

  factory :admin_role, parent: :role do
    title 'Admin'
  end
end
