module Organizer
  class MessagesController < ApplicationController
    before_action :authenticate_user!

    def create
      @conversation = Conversation.find(params[:conversation_id])
      authorize @conversation, :create_message?
      @message = @conversation.messages.build(message_params.merge(user: current_user))

      if @message.save
        redirect_to organizer_conversation_path(@conversation)
      else
        redirect_to organizer_conversation_path(@conversation), alert: t("organizer.messages.create.failure")
      end
    end

    private

    def message_params
      params.require(:message).permit(:body)
    end
  end
end
