require "rails_helper"

RSpec.describe ConversationPolicy, type: :policy do
  let(:organizer) { create(:user, :organizer) }
  let(:registered_player) { create(:user) }
  let(:unregistered_player) { create(:user) }
  let(:camp) { create(:camp, :published, organizer: organizer) }
  let(:conversation) { create(:conversation, camp: camp) }

  before do
    create(:registration, user: registered_player, camp: camp, status: :confirmed)
  end

  describe "#show?" do
    context "when user is the camp organizer" do
      it "allows access" do
        policy = ConversationPolicy.new(organizer, conversation)
        expect(policy.show?).to be true
      end
    end

    context "when user is a registered player" do
      it "allows access" do
        policy = ConversationPolicy.new(registered_player, conversation)
        expect(policy.show?).to be true
      end
    end

    context "when user is NOT registered for the camp" do
      it "denies access" do
        policy = ConversationPolicy.new(unregistered_player, conversation)
        expect(policy.show?).to be false
      end
    end
  end

  describe "#create_message?" do
    context "when user is the organizer" do
      it "allows sending messages" do
        policy = ConversationPolicy.new(organizer, conversation)
        expect(policy.create_message?).to be true
      end
    end

    context "when user is a registered player" do
      it "allows sending messages" do
        policy = ConversationPolicy.new(registered_player, conversation)
        expect(policy.create_message?).to be true
      end
    end

    context "when user is not a participant" do
      it "denies sending messages" do
        policy = ConversationPolicy.new(unregistered_player, conversation)
        expect(policy.create_message?).to be false
      end
    end
  end
end
