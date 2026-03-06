FactoryBot.define do
  factory :camp do
    association :organizer, factory: [:user, :organizer]
    title       { "#{Faker::Address.city} Beach Volleyball Camp" }
    description { Faker::Lorem.paragraph(sentence_count: 3) }
    location    { Faker::Address.city }
    country     { Faker::Address.country }
    start_date  { 1.month.from_now.to_date }
    end_date    { 1.month.from_now.to_date + 5.days }
    level       { :beginner }
    price_cents { 29_900 }
    currency    { "EUR" }
    min_participants { 4 }
    max_participants { 16 }
    status      { :draft }
    featured    { false }

    trait :published do
      status { :published }
    end

    trait :full do
      status { :full }
    end

    trait :cancelled do
      status { :cancelled }
    end

    trait :featured do
      featured { true }
    end

    trait :small do
      max_participants { 2 }
    end
  end
end
