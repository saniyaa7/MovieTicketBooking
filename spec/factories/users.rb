FactoryBot.define do
  factory :user do
    name { Faker::Name.name_with_middle }
    age { Faker::Number.between(from: 10, to: 99) }
    phone_no { '1234567890' }
    password_digest { Faker::Internet.password(min_length: 8) }
    
    # Associate the user with a role using the role factory
    association :role, factory: :role
  end
end
