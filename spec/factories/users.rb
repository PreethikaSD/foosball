FactoryBot.define do
  factory :user do
    email "testme@example.com"
    password "foosball"
    first_name "John"
    last_name  "Doe"
    role "admin"
  end
end
