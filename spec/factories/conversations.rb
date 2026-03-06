FactoryBot.define do
  factory :conversation do
    association :camp, :published
  end
end
