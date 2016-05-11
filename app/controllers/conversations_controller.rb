class ConversationsController < ApplicationController
  before_action :require_user
  before_action :set_prep

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to prep_conversation_messages_path(prep_id: @prep.id, conversation_id: @conversation.id)
  end

  private

  def conversation_params
    params.permit(:recipient_id, :sender_id)
  end

end