class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  def index
    @orders = Order.all.order("created_at DESC")
  end

  def show; end

  def find_product
    render json: Product.find(params[:product_id]).quantity
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    product = Product.find(params[:order][:product_id])
    product_quantity = product.quantity

    if @order.save! && product.update(quantity: (product_quantity - params[:order][:quantity].to_i))
      product.update(status: "in_stock") if product.quantity >= 20
      product.update(status: "low_stock") if product.quantity < 20
      product.update(status: "out_of_stock") if product.quantity == 0
      flash[:success] = "Encomenda criada com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar criar a Encomenda: #{@order.errors.full_messages}"
    end

    redirect_to orders_path
  end

  def edit; end

  def update
    if @order.update(order_params)
      flash[:success] = "Encomenda atualizada com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar atualizar a Encomenda: #{@order.errors.full_messages}"
    end

    redirect_to orders_path
  end

  def destroy
    product = @order.product
    product_quantity = product.quantity

    if @order.destroy! && product.update(quantity: (product_quantity + @order.quantity))
      product.update(status: "in_stock") if product.quantity >= 20
      product.update(status: "low_stock") if product.quantity < 20
      product.update(status: "out_of_stock") if product.quantity == 0
      flash[:success] = "Encomenda excluído com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar excluir a Encomenda: #{@order.errors.full_messages}"
    end

    redirect_to orders_path
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      attrs = params.require(:order).permit(
        :product_id,
        :client_id,
        :quantity,
        :status
      )
    end
end
