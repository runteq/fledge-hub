class CreateTechnologies < ActiveRecord::Migration[6.1]
  def change
    create_table :technologies do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :technologies, :name, unique: true
    add_index :technologies, :slug, unique: true
  end
end
