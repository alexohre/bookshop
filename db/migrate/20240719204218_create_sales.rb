class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.decimal :total_amount, precision: 10, scale: 2
      t.references :student, null: false, foreign_key: true
      t.string :cashier_name

      t.timestamps
    end
  end
end
