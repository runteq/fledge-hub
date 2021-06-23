class CreateSocialAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :social_accounts do |t|
      t.references :social_service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :identifier, null: false

      t.timestamps
    end
  end
end
