class RemoveColumnFromUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :display_name, nil)
  end
end
