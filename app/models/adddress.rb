class Adddress < ApplicationRecord
  belongs_to :contact, optional: true
end
