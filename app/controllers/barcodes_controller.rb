class BarcodesController < ApplicationController
  before_action :set_barcode, only: %i[ show edit update destroy ]

  def index
    @barcodes = Barcode.all.order("created_at DESC")
  end

  def show; end

  def new
    @barcode = Barcode.new
  end

  def edit; end

  def create
    @barcode = Barcode.new(barcode_params)

    if @barcode.save!
      flash[:success] = "Código de Barras criado com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar criar o Código de Barras: #{@barcode.errors.full_messages}"
    end

    redirect_to barcodes_url
  end

  def update
    product = Product.find(params[:barcode][:product_id])

    return (
      flash[:error] = "Não foi possível adicionar o produto #{product.name} pois ele já pertence ao código de barras #{product.barcode.number}"
      redirect_to edit_barcode_url(@barcode)
    ) if product.barcode.present? && product.barcode.number != params[:barcode][:number]

    if @barcode.update(barcode_params)
      flash[:success] = "Código de Barras atualizado com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar atualizar o Código de Barras: #{@barcode.errors.full_messages}"
    end

    redirect_to barcodes_url
  end

  def destroy
    if @barcode.destroy!
      flash[:success] = "Código de Barras excluído com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar excluir o Código de Barras: #{@barcode.errors.full_messages}"
    end

    redirect_to barcodes_url
  end

  private
    def set_barcode
      @barcode = Barcode.find(params[:id])
    end

    def barcode_params
      params.require(:barcode).permit(
        :product_id,
        :number,
        :status
      )
    end
end
