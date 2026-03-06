FactoryBot.define do
  factory :message do
    association :conversation
    association :user
    body { Faker::Lorem.sentence }
  end
end
