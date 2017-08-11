class CreateAdddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :adddresses do |t|
      t.string :street
      t.string :city
      t.references :contact, foreign_key: true

      t.timestamps
    end
  end
end
