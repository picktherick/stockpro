class Product < ApplicationRecord
  validates :name, :description, :quantity, :price_in_cents, presence: true

  has_one :barcode, dependent: :destroy

  enum status: { in_stock: "in_stock", low_stock: "low_stock", out_of_stock: "out_of_stock" }

  scope :with_no_barcode, -> { select{ |product| product.barcode.nil? }}
  scope :with_barcode, -> { select{ |product| product.barcode.present? }}
end
