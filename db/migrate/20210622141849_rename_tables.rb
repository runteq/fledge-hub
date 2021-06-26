class RenameTables < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :product_category_id, :integer, null: false
    rename_column :products, :genre_id, :product_type_id
  end
end
