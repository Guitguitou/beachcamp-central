require "rails_helper"

RSpec.describe CampPolicy, type: :policy do
  let(:organizer) { create(:user, :organizer) }
  let(:other_organizer) { create(:user, :organizer) }
  let(:player) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:camp) { create(:camp, organizer: organizer) }

  describe "#create?" do
    context "when user is an organizer" do
      it "allows camp creation" do
        policy = CampPolicy.new(organizer, Camp.new)
        expect(policy.create?).to be true
      end
    end

    context "when user is a player" do
      it "denies camp creation" do
        policy = CampPolicy.new(player, Camp.new)
        expect(policy.create?).to be false
      end
    end
  end

  describe "#update?" do
    context "when user is the camp organizer" do
      it "allows updating their own camp" do
        policy = CampPolicy.new(organizer, camp)
        expect(policy.update?).to be true
      end
    end

    context "when user is a different organizer" do
      it "denies updating someone else's camp" do
        policy = CampPolicy.new(other_organizer, camp)
        expect(policy.update?).to be false
      end
    end

    context "when user is an admin" do
      it "allows updating any camp" do
        policy = CampPolicy.new(admin, camp)
        expect(policy.update?).to be true
      end
    end
  end

  describe "#publish?" do
    context "when camp is a draft and user is the organizer" do
      it "allows publishing" do
        draft_camp = create(:camp, organizer: organizer, status: :draft)
        policy = CampPolicy.new(organizer, draft_camp)
        expect(policy.publish?).to be true
      end
    end

    context "when camp is already published" do
      it "denies publishing again" do
        published_camp = create(:camp, :published, organizer: organizer)
        policy = CampPolicy.new(organizer, published_camp)
        expect(policy.publish?).to be false
      end
    end
  end

  describe "Scope" do
    context "for a player" do
      it "only returns visible camps (published + full)" do
        create(:camp, :published, organizer: organizer)
        create(:camp, :full, organizer: organizer)
        create(:camp, organizer: organizer)

        scope = CampPolicy::Scope.new(player, Camp.all).resolve
        expect(scope.count).to eq(2)
      end
    end

    context "for an organizer" do
      it "only returns their own camps" do
        create(:camp, organizer: organizer)
        create(:camp, :published, organizer: other_organizer)

        scope = CampPolicy::Scope.new(organizer, Camp.all).resolve
        expect(scope.count).to eq(1)
        expect(scope.first.organizer).to eq(organizer)
      end
    end
  end
end
