class Contact < ApplicationRecord
  belongs_to :kind#, optional: true

  def to_br
    {
      name: self.name,
      email: self.email,
      birthdate: (I18n.l(self.birthdate) unless self.birthdate.blank?),
      kind_id: Kind.all.sample
    }
  end

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
