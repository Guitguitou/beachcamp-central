require "rails_helper"

RSpec.describe Camp, type: :model do
  describe "validations" do
    context "with valid attributes" do
      it "is valid" do
        camp = build(:camp)
        expect(camp).to be_valid
      end
    end

    context "with missing required fields" do
      it "is invalid without a title" do
        camp = build(:camp, title: nil)
        expect(camp).not_to be_valid
        expect(camp.errors[:title]).to include("can't be blank")
      end
    end

    context "with end_date before start_date" do
      it "is invalid" do
        camp = build(:camp, start_date: Date.tomorrow, end_date: Date.current)
        expect(camp).not_to be_valid
        expect(camp.errors[:end_date]).to include("must be after start date")
      end
    end

    context "with max_participants less than min_participants" do
      it "is invalid" do
        camp = build(:camp, min_participants: 10, max_participants: 5)
        expect(camp).not_to be_valid
        expect(camp.errors[:max_participants]).to include("must be >= min participants")
      end
    end
  end

  describe "#spots_remaining" do
    context "when camp has confirmed registrations" do
      it "returns the correct number of remaining spots" do
        camp = create(:camp, :published, max_participants: 10)
        create_list(:registration, 3, camp: camp, status: :confirmed)

        expect(camp.spots_remaining).to eq(7)
      end
    end
  end

  describe "scopes" do
    context ".visible" do
      it "returns only published and full camps" do
        published = create(:camp, :published)
        full_camp = create(:camp, :full)
        create(:camp)
        create(:camp, :cancelled)

        expect(Camp.visible).to contain_exactly(published, full_camp)
      end
    end
  end
end
