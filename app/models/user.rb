class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :registerable, :validatable, :timeoutable

  has_many :friends
  has_many :messages,      class_name: :Message, foreign_key: :receiver_id
  has_many :sent_messages, class_name: :Message, foreign_key: :sender_id

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
    sent_messages.create(content: msg, receiver_id: u.id, status: 1)

    u.make_friend(self)
  end

  def unread_messages
    messages.where(sender_id: active_friends.pluck(:friend_id), status: 1)
  end

  def unread_messages_with_user(u)
    messages.where(sender_id: u.id, status: 1)
  end

  def messages_with_user(u)
    all_messages = Message.between_user(self, u)
    all_messages.where(receiver_id: id).update_all(status: 2)

    all_messages
  end
end
