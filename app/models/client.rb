class Client < ApplicationRecord
  has_many :orders, dependent: :destroy

  enum status: { active: true, inactive: false }

  scope :active, -> { where(status: "active") }
end
