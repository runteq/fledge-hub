class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.string :url
      t.string :source_url
      t.date :released_on, null: false

      t.timestamps
    end
  end
end
