require "rails_helper"

RSpec.describe CampStaffMembership, type: :model do
  it "rejects the camp organizer as staff" do
    organizer = create(:user, :organizer)
    camp = create(:camp, organizer: organizer)
    membership = CampStaffMembership.new(camp: camp, user: organizer)

    expect(membership).not_to be_valid
    expect(membership.errors[:user_id]).to be_present
  end

  it "rejects players as staff" do
    camp = create(:camp)
    player = create(:user)
    membership = build(:camp_staff_membership, camp: camp, user: player)

    expect(membership).not_to be_valid
    expect(membership.errors[:user]).to be_present
  end
end
