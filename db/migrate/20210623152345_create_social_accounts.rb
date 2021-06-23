class CreateSocialAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :social_accounts do |t|
      t.integer :social_service_id, null: false
      t.references :user, null: false, foreign_key: true
      t.text :identifier, null: false

      t.timestamps
    end
  end
end
