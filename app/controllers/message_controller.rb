class MessageController < ApplicationController
  before_action :authenticate_user!, :load_target_user

  def index
    @all_messages = current_user.messages_with_user @target_user
  end

  def talk
    current_user.send_message(@target_user, params[:msg][:content])
    redirect_to message_index_url
  end

  private
  def load_target_user
    params.permit(:user_id)
    @target_user = User.find params[:user_id]
  end
end
