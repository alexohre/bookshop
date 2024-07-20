class AddSaleItemsCountToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :sale_items_count, :integer
  end
end
