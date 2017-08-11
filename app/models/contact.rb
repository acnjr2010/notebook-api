class Contact < ApplicationRecord
  belongs_to :kind#, optional: true
  has_many :phones
  has_one :address

  # Permite que os itens aninhados sejam excluídos
  accepts_nested_attributes_for :phones, allow_destroy: true
  # update_only não permite que crie um novo somente atualizar o que ja existe
  accepts_nested_attributes_for :address, update_only: true

  def as_json(options={})
    hsh = super(options)
    hsh[:birthdate] = (I18n.l(self.birthdate) unless self.birthdate.blank?)
    hsh
  end

  # def to_br
  #   {
  #     name: self.name,
  #     email: self.email,
  #     birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?),
  #     kind_id: Kind.all.sample
  #   }
  # end

  # def author
  #   "Antonio Carlos"
  # end
  #
  # def kind_description
  #   self.kind.description
  # end
  #
  # def as_json(options={})
  #   super(
  #     root: true,
  #     methods: [:kind_description, :author]
  #     #include: :kind
  #   )
  # end
end
