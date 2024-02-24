FactoryBot.define do
  factory :category do
    name { 'Laptop PC' }
    user

    after(:build) do |category|
      category.icon.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'laptop_image.jpeg')),
                           filename: 'laptop_image.png', content_type: 'image/jpeg')
    end
  end
end
