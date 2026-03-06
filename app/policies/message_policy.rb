class MessagePolicy < ApplicationPolicy
  def create?
    ConversationPolicy.new(user, record.conversation).create_message?
  end
end
