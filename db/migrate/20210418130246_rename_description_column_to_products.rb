class RenameDescriptionColumnToProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :description, :summary
  end
end
