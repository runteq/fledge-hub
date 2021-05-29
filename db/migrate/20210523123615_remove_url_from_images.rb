class RemoveUrlFromImages < ActiveRecord::Migration[6.1]
  def change
    remove_column :images, :title, :string, null: false
    remove_column :images, :url, :text, null: false
  end
end
