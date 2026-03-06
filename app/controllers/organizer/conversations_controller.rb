module Organizer
  class ConversationsController < ApplicationController
    before_action :authenticate_user!
    layout "organizer"

    def index
      camp_ids = current_user.organized_camps.pluck(:id)
      @conversations = Conversation.where(camp_id: camp_ids).includes(:camp, :messages).order(updated_at: :desc)
    end

    def show
      @conversation = Conversation.find(params[:id])
      authorize @conversation
      @messages = @conversation.messages.ordered.includes(:user)
      @message = Message.new
    end
  end
end
