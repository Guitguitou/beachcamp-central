FactoryBot.define do
  factory :registration do
    association :user
    association :camp, :published
    status { :confirmed }
  end
end
