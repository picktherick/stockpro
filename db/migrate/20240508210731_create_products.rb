class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.float :price_in_cents
      t.string :status

      t.timestamps
    end
  end
end
