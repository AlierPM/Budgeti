FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@budgeti.com" }
    sequence(:name) { |n| "user#{n}" }
    password { 'pami@2024' }

    trait :confirmed do
      confirmed_at { Time.now }
    end
  end
end
