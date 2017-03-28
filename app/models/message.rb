class Message < ApplicationRecord
  belongs_to :sender,   class_name: "User", foreign_key: :sender_id
  belongs_to :receiver, class_name: "User", foreign_key: :receiver_id

  def self.between_user(sender, receiver)
    condit = "(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)"
    where([condit, sender.id, receiver.id, receiver.id, sender.id])
  end
end
