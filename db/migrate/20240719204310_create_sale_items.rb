class CreateSaleItems < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_items do |t|
      t.references :sale, null: false, foreign_key: true
      t.integer :book_id
      t.string :title
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
