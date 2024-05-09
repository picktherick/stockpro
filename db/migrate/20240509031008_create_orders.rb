class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :product, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.integer :quantity
      t.string :status
      t.float :total_price_in_cents

      t.timestamps
    end
  end
end
