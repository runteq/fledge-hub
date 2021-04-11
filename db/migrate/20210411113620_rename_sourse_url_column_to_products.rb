class RenameSourseUrlColumnToProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :source_url, :source_url
  end
end
