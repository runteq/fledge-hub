class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :email, null: false, default: ''
      t.string :about, null: false
      t.text :description, null: false
      t.string :user_agent, null: false

      t.timestamps
    end
  end
end
