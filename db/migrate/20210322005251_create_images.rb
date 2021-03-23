class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :title, null: false
      t.text :description
      t.text :url, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
