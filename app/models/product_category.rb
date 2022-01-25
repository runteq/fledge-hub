class ProductCategory < ActiveHashMaster
  fields :id, :position, :name

  has_many :products
end
