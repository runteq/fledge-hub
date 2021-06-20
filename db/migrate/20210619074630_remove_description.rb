class RemoveDescription < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :description, :text
    remove_column :media, :description, :text
  end
end
