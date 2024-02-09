class Connection < ApplicationRecord
  STATUSES = ['pending', 'accepted', 'rejected', 'deleted',]

  belongs_to :user

  belongs_to :requested, class_name: 'User', foreign_key: :connected_user_id
  belongs_to :received, class_name: 'User', foreign_key: :user_id

  scope :requested_connections, ->(user) { includes(:requested).where("user_id = ?", user.id) }
  scope :received_connections, ->(user) { includes(:received).where("connected_user_id = ?", user.id) }

  validates :connected_user_id, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
end
