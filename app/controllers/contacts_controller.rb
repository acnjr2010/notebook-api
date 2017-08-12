class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all

    render json: @contacts
  end

  # GET /contacts/1
  def show
    # o include usando active_model_serializers cria uma chave chamada included no final do json
    # trazendo informações sobre essa associação, include muito utilizado no belongs_to

    # meta cria uma informação sobre o proprio retorno, ele virá no mesmo lugar que o include, porém em chaves diferente,
    # para criar para todo o json siga o exemplo do serializer Contaact

    render json: @contact, include: [:kind]#, meta: { author: "Antonio Carlos" }#, include: [:kind, :phones]
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      #_destroy serve para deletar uma informação aninhada colocando o id e abaixo o _destroy
      # phones [
                 #{
                    #"id": 10,
                    #"_destroy"
                  #}
                #]
      params.require(:contact).permit(:name, :email, :birthdate, :kind_id, phones_attributes: [:id, :number, :_destroy])
    end
end
