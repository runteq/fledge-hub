class ProductCategory < ActiveHashMaster
  has_many :products

  def self.asc
    ProductCategory.all.sort_by(&:position)
  end
end
