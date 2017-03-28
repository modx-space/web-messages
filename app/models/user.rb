class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable, :validatable, :timeoutable

  has_many :friends

  def make_friend(u)
    friends.find_or_create_by(friend_id: u.id).update(is_active: true) unless friend?(u)
  end

  def friend?(u)
    active_friends.pluck(:friend_id).include?(u.id)
  end

  def active_friends
    friends.where(is_active: true)
  end
end
