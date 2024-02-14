# spec/factories/movies.rb
FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    stars { Faker::Name.name }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
