class RenameImagesAndMediaTables < ActiveRecord::Migration[6.1]
  def change
    rename_table :media, :product_media
    rename_table :images, :product_images
  end
end
