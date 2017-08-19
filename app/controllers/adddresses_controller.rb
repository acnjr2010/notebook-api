class AdddressesController < ApplicationController
  before_action :set_contact

  def create
    @contact.adddress = Adddress.new(adddress_params)

    if @contact.save
      render json: @contact.adddress, status: :created, location: contact_adddress_url(@contact)
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # GET /phones/1
  def show
    render json: @contact.adddress
  end

  def update
    if @contact.adddress.update(adddress_params)
      render json: @contact.adddress
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contact.adddress.destroy
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def adddress_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
