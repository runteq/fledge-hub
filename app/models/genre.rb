class Genre < ActiveHashMaster
  has_many :products

  def self.asc
    Genre.all.sort_by(&:position)
  end
end
