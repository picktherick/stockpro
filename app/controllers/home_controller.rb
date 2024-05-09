class HomeController < ApplicationController
  def index
    products = Product.all
    @total_of_products = products.map { |p| p.quantity }.sum
    @products_total_amount = products.map { |p| (p.price_in_cents * 100).to_i * p.quantity }.sum

    orders = Order.all
    @total_of_orders = orders.map { |o| o.quantity }.sum
    @orders_total_amount = orders.map { |o| (o.product.price_in_cents * 100).to_i * o.quantity }.sum
  end
end
