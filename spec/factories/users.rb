FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.unique.email }
    password   { "password123" }
    # No role column — everyone is a player by default
    # Boolean flags default to false
    level      { :beginner }

    trait :organizer do
      organizer { true }
    end

    trait :coach do
      coach { true }
    end

    trait :admin do
      admin { true }
    end

    trait :organizer_and_coach do
      organizer { true }
      coach     { true }
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
