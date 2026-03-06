require "rails_helper"

RSpec.describe Registration, type: :model do
  describe "validations" do
    context "when registering for a published camp with available spots" do
      it "creates a confirmed registration" do
        camp = create(:camp, :published, max_participants: 10)
        user = create(:user)

        registration = Registration.new(user: user, camp: camp, status: :confirmed)
        expect(registration).to be_valid
        expect(registration.save).to be true
      end
    end

    context "when registering for a draft camp" do
      it "rejects the registration because camp must be published" do
        camp = create(:camp, status: :draft)
        user = create(:user)

        registration = Registration.new(user: user, camp: camp, status: :confirmed)
        expect(registration).not_to be_valid
        expect(registration.errors[:camp]).to include("must be published to register")
      end
    end

    context "when registering for a full camp" do
      it "rejects the registration because camp has no spots" do
        camp = create(:camp, :published, min_participants: 1, max_participants: 1)
        create(:registration, camp: camp, status: :confirmed)

        user = create(:user)
        registration = Registration.new(user: user, camp: camp, status: :confirmed)
        expect(registration).not_to be_valid
        expect(registration.errors[:camp]).to include("is full")
      end
    end

    context "when user is already registered for the camp" do
      it "rejects duplicate registration" do
        camp = create(:camp, :published)
        user = create(:user)
        create(:registration, user: user, camp: camp)

        duplicate = Registration.new(user: user, camp: camp, status: :confirmed)
        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:user_id]).to include("already registered for this camp")
      end
    end
  end

  describe "auto-fill camp status" do
    context "when registration fills the last spot" do
      it "marks the camp as full" do
        camp = create(:camp, :published, min_participants: 1, max_participants: 2)
        create(:registration, camp: camp, status: :confirmed)

        user = create(:user)
        Registration.create!(user: user, camp: camp, status: :confirmed)

        expect(camp.reload.status).to eq("full")
      end
    end

    context "when registration does not fill the camp" do
      it "keeps the camp as published" do
        camp = create(:camp, :published, max_participants: 10)
        user = create(:user)
        Registration.create!(user: user, camp: camp, status: :confirmed)

        expect(camp.reload.status).to eq("published")
      end
    end
  end
end
