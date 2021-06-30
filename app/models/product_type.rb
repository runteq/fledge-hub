class ProductType < ActiveHashMaster
  fields :id, :position, :name

  has_many :products
end
