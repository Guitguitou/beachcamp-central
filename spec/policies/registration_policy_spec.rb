require "rails_helper"

RSpec.describe RegistrationPolicy, type: :policy do
  let(:organizer) { create(:user, :organizer) }
  let(:player) { create(:user) }
  let(:other_player) { create(:user) }
  let(:camp) { create(:camp, :published, organizer: organizer) }
  let(:registration) { create(:registration, user: player, camp: camp) }

  describe "#create?" do
    context "when user is a player and camp is published" do
      it "allows registration" do
        reg = Registration.new(user: player, camp: camp)
        policy = RegistrationPolicy.new(player, reg)
        expect(policy.create?).to be true
      end
    end

    context "when user is an organizer" do
      it "allows registration (organizer is also always a player)" do
        reg = Registration.new(user: organizer, camp: camp)
        policy = RegistrationPolicy.new(organizer, reg)
        expect(policy.create?).to be true
      end
    end
  end

  describe "#destroy?" do
    context "when user owns the registration" do
      it "allows cancellation" do
        policy = RegistrationPolicy.new(player, registration)
        expect(policy.destroy?).to be true
      end
    end

    context "when another player tries to cancel" do
      it "denies cancellation" do
        policy = RegistrationPolicy.new(other_player, registration)
        expect(policy.destroy?).to be false
      end
    end
  end

  describe "#update?" do
    context "when user is the camp organizer" do
      it "allows managing registrations" do
        policy = RegistrationPolicy.new(organizer, registration)
        expect(policy.update?).to be true
      end
    end

    context "when user is a player" do
      it "denies managing registrations" do
        policy = RegistrationPolicy.new(player, registration)
        expect(policy.update?).to be false
      end
    end
  end
end
