class AddDefaultDisplayNameToUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :display_name, :string, default: ''
  end
end
