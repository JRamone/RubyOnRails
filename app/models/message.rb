class Message < ApplicationRecord

  has_one :sender, foreign_key: :sender_id
  has_one :receiver, dependent: :destroy, foreign_key: :receiver_id

  validates :message_field, presence: true

end
