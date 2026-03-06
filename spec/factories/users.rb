FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.unique.email }
    password   { "password123" }
    role       { :player }
    level      { :beginner }

    trait :organizer do
      role { :organizer }
    end

    trait :admin do
      role { :admin }
    end

    trait :intermediate do
      level { :intermediate }
    end

    trait :advanced do
      level { :advanced }
    end

    trait :pro do
      level { :pro }
    end
  end
end
