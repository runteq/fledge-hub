class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.references :user, null: false, foreign_key: true, index: false
      t.references :product, null: false, foreign_key: true, index: false

      t.timestamps
    end
    add_index :stocks, [:product_id, :user_id], unique: true
  end
end
