class ClientsController < ApplicationController
  before_action :set_client, only: %i[ show edit update destroy ]

  def index
    @clients = Client.all
  end

  def show; end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      flash[:success] = "Cliente criado com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar criar o cliente: #{@client.errors.full_messages}"
    end

    redirect_to clients_url
  end

  def edit; end

  def update
    if @client.update(client_params)
      flash[:success] = "Cliente editado com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar editar o cliente: #{@client.errors.full_messages}"
    end

    redirect_to clients_url
  end

  def destroy
    if @client.destroy!
      flash[:success] = "Cliente excluído com sucesso!"
    else
      flash[:error] = "Ocorreu um erro ao tentar excluir o cliente: #{@client.errors.full_messages}"
    end

    redirect_to clients_url
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      attrs = params.require(:client).permit(
        :name,
        :identity_document_number,
        :phone_number,
        :birth_date,
        :zipcode,
        :street,
        :number,
        :complement,
        :neighborhood,
        :city,
        :state,
        :observations,
        :status
      )
      attrs[:status] = attrs[:status] == "false" ? false : true
      attrs
    end
end
