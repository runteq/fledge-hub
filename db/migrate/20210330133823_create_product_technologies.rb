class CreateProductTechnologies < ActiveRecord::Migration[6.1]
  def change
    create_table :product_technologies do |t|
      t.references :product, null: false, foreign_key: true
      t.references :technology, null: false, foreign_key: true

      t.timestamps
    end
  end
end
