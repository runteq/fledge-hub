class AddNullValidate < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :summary, :text, null: false
    change_column :products, :url, :text, null: false
    change_column :products, :source_url, :text, null: false
    change_column :images, :description, :text, null: false
    change_column :media, :description, :text, null: false
  end
end
