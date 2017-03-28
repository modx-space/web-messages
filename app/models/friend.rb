class Friend < ApplicationRecord
  belongs_to :host,   class_name: "User", foreign_key: :user_id
  belongs_to :guest, class_name: "User", foreign_key: :friend_id
end
