class CreateSocialServices < ActiveRecord::Migration[6.1]
  def change
    create_table :social_services do |t|
      t.string :name, null: false
      t.text :icon, null: false
      t.string :base_url, null: false

      t.timestamps
    end
  end
end
