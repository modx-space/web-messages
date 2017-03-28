class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @friends = current_user.active_friends
  end

  def make_friend
    user = User.find_by make_friend_params
    current_user.make_friend user if user.present?

    redirect_to home_index_url
  end

  def cancel_friend
    Friend.find(params[:id]).update(is_active: false)

    redirect_to home_index_url
  end

  private
  def make_friend_params
    params.require(:user).permit(:email)
  end
end
