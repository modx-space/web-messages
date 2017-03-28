class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable, :validatable, :timeoutable

  has_many :friends
  has_many :messages, foreign_key: :sender_id

  def make_friend(u)
    friends.find_or_create_by(friend_id: u.id).update(is_active: true) unless friend?(u)
  end

  def friend?(u)
    active_friends.pluck(:friend_id).include?(u.id)
  end

  def active_friends
    friends.where(is_active: true)
  end

  def send_message(u, msg)
    messages.create(content: msg, receiver_id: u.id, status: 1)

    u.make_friend(self)
  end

  def unread_messages
    messages.where(status: 1)
  end

  def messages_with_user(u)
    sends    = messages.where(receiver_id: u.id)
    receives = u.messages.where(sender_id: id)

    sends + receives
  end
end
