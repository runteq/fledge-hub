class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :display_name, null: false
      t.string :screen_name, null: false
      t.string :email, null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :screen_name, unique: true
  end
end
