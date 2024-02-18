FactoryBot.define do
  factory :movie_show do
    language { Faker::Lorem.word || 'English' }  # Set a default language if Faker returns nil
    seat_count { Faker::Number.between(from: 50, to: 200) }
    show_start_time { DateTime.now()}
    show_end_time {  DateTime.now()+1.day }
    screen_no { Faker::Number.between(from: 1, to: 10) }
    association :movie
  end
end
