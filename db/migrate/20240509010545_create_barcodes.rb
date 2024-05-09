class CreateBarcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :barcodes do |t|
      t.references :product, null: false, foreign_key: true
      t.string :number
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
