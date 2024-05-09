class Order < ApplicationRecord
  belongs_to :product

  after_create :set_total

  enum status: { pending: "pending", on_delivery_route: "on_delivery_route", delivered: "delivered" }

  private

  def set_total
    self.update(total_price_in_cents: ((self.product.price_in_cents * 100).to_i * self.quantity))
  end
end
