class ProductType < ActiveHashMaster
  has_many :products

  def self.asc
    ProductType.all.sort_by(&:position)
  end
end
