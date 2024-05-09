class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all.order("created_at DESC")
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      @product.update(status: "in_stock") if @product.quantity >= 20
      @product.update(status: "low_stock") if @product.quantity < 20
      @product.update(status: "out_of_stock") if @product.quantity == 0

      flash[:success] = "Produto criado com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar criar o produto: #{@product.errors.full_messages}"
    end

    redirect_to products_url
  end

  def edit; end

  def update
    if @product.update(product_params)
      @product.update(status: "in_stock") if @product.quantity >= 20
      @product.update(status: "low_stock") if @product.quantity < 20
      @product.update(status: "out_of_stock") if @product.quantity == 0

      flash[:success] = "Produto atualizado com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar atualizar o produto: #{@product.errors.full_messages}"
    end

    redirect_to products_url
  end

  def destroy
    if @product.destroy!
      flash[:success] = "Produto excluído com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar excluir o produto: #{@product.errors.full_messages}"
    end

    redirect_to products_url
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      attrs = params.require(:product).permit(
        :name,
        :description,
        :quantity,
        :price_in_cents,
        :status
      )

      attrs[:price_in_cents] = attrs[:price_in_cents].gsub('.', '').gsub(',', '').to_f / 100.0

      attrs
    end
end
