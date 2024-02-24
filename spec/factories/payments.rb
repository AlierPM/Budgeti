FactoryBot.define do
  factory :payment do
    name { 'Example payment 1' }
    amount { 350 }
    author { association(:user) }
    category { association(:category) }
  end
end
