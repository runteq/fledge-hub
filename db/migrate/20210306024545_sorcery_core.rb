class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :User do |t|
      t.string :email,            null: false
      t.string :crypted_password
      t.string :salt

      t.timestamps                null: false
    end

    add_index :User, :email, unique: true
  end
end
