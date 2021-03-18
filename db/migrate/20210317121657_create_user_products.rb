class CreateUserProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_products do |t|
      t.references :user, null: false
      t.references :product, null: false

      t.timestamps
    end
  end
end
