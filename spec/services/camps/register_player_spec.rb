require "rails_helper"

RSpec.describe Camps::RegisterPlayer, type: :service do
  let(:organizer) { create(:user, :organizer) }
  let(:player) { create(:user) }

  describe "#call" do
    context "when camp is published and has spots" do
      it "creates a pending registration" do
        camp = create(:camp, :published, organizer: organizer, max_participants: 10)
        result = described_class.new(camp: camp, user: player).call

        expect(result.success?).to be true
        expect(result.registration).to be_persisted
        expect(result.registration.status).to eq("pending")
      end
    end

    context "when camp is not published" do
      it "fails with appropriate error" do
        camp = create(:camp, organizer: organizer)
        result = described_class.new(camp: camp, user: player).call

        expect(result.success?).to be false
        expect(result.error).to eq("Camp is not open for registration")
      end
    end

    context "when camp is full" do
      it "fails with appropriate error" do
        camp = create(:camp, :published, organizer: organizer, min_participants: 1, max_participants: 1)
        create(:registration, camp: camp, status: :confirmed)

        result = described_class.new(camp: camp, user: player).call

        expect(result.success?).to be false
        expect(result.error).to eq("Camp is full")
      end
    end

    context "when player is already registered" do
      it "fails with appropriate error" do
        camp = create(:camp, :published, organizer: organizer, max_participants: 10)
        create(:registration, user: player, camp: camp, status: :confirmed)

        result = described_class.new(camp: camp, user: player).call

        expect(result.success?).to be false
        expect(result.error).to eq("You are already registered")
      end
    end

    context "when registration fills the last spot" do
      it "creates a pending registration without marking the camp as full (coach confirms later)" do
        camp = create(:camp, :published, organizer: organizer, min_participants: 1, max_participants: 1)
        result = described_class.new(camp: camp, user: player).call

        expect(result.success?).to be true
        expect(result.registration.status).to eq("pending")
        # Camp stays published — the coach's confirmation triggers full? check
        expect(camp.reload.status).to eq("published")
      end
    end
  end
end
