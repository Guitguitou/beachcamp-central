FactoryBot.define do
  factory :camp_staff_membership do
    association :camp
    association :user, factory: [:user, :organizer]
    position { 0 }

    after(:build) do |membership|
      next if membership.camp.blank? || membership.user.blank?

      if membership.user_id == membership.camp.organizer_id
        membership.user = FactoryBot.create(:user, :organizer)
      end
    end
  end
end
