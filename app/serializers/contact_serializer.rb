class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate#, :author

  belongs_to :kind do
    link(:related) { kind_url(object.kind.id) }
  end

  has_many :phones
  has_one :adddress

  #links no json HATEOAS
  # dessa forma ele coloca somente o endereço sem o localhost
  link(:self) { contact_path(object.id) }

  # dessa forma ele deve colocar o valor completo, porém é necessário setar no development.rb a seguinte configuração:

  # Rails.application.routes.default_url_options = {
  #   host: 'localhost',
  #   port: 3000
  # }

  link(:kind) { kind_url(object.kind.id) }

  # meta para criar uma metainformação sobre o json, também chamado de informações extras
  meta do
    { author: "Antonio Carlos" }
  end


  # Atributo Virtual, podemos criar um atributo virtual na lista de atributos e depois criamos um método
  # com o retorno desejado por esse atributo virtual

  # def author
  #   "Antonio Carlos"
  # end

  # fazendo i18n com birthdate usando active_model_serializers
  def attributes(*args)
    hsh = super(*args)
    # pt-BR ---> hsh[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    hsh[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    hsh
  end
end
