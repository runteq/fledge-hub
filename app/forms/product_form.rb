class ProductForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :title, :string
  attribute :summary, :string
  attribute :url, :string
  attribute :source_url, :string
  attribute :released_on, :date
  attribute :genre_id, :integer
  attribute :technology_ids
  attribute :user_ids

  validates :title, presence: true, length: { maximum: 100 }
  validates :url, url: { allow_blank: true, schemes: %w[https http] }, length: { maximum: 500 }
  validates :source_url, url: { allow_blank: true, schemes: %w[https http] },
                         length: { maximum: 500 }
  validates :released_on, presence: true
  validates :summary, length: { maximum: 500 }
  validates :genre_id, presence: true
  validates :user_ids, presence: true

  class << self
    def find(product_id, user_id)
      user = User.find(user_id)
      product = user.products.find(product_id)

      new(**attributes(product))
    end

    private

    def attributes(product)
      product.attributes.deep_symbolize_keys.slice(
        :title,
        :summary,
        :url,
        :source_url,
        :released_on,
        :genre_id,
      ).merge({
        technology_ids: product.technology_ids,
      })
    end
  end

  def save
    return false if invalid?

    product.save!
  end

  def to_model
    product
  end

  private

  def product
    @product ||= Product.new(**product_params)
  end

  def product_params
    {
      title: title,
      url: url,
      source_url: source_url,
      released_on: released_on,
      summary: summary,
      genre_id: genre_id,
      technology_ids: technology_ids,
      user_ids: user_ids
    }
  end
end
