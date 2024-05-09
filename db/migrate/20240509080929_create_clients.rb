class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :identity_document_number
      t.string :phone_number
      t.datetime :birth_date
      t.string :zipcode
      t.string :street
      t.string :number
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.text :observations
      t.boolean :status

      t.timestamps
    end
  end
end
