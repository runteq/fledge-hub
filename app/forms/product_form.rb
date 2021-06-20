class ProductForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :title, :string
  attribute :summary, :string
  attribute :url, :string
  attribute :source_url, :string
  attribute :released_on, :date
  attribute :genre_id, :integer
  attribute :technology_ids
  attribute :user_ids

  validates :id, presence: true, if: -> { product.persisted? }
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, url: { allow_blank: true, schemes: %w[https http] }, length: { maximum: 500 }
  validates :source_url, url: { allow_blank: true, schemes: %w[https http] },
                         length: { maximum: 500 }
  validates :released_on, presence: true
  validates :summary, length: { maximum: 500 }
  validates :genre_id, presence: true
  validates :user_ids, presence: true, if: -> { product.new_record? }

  delegate :persisted?, :new_record?, to: :product

  class << self
    def find(product_id, user_id)
      user = User.find(user_id)
      product = user.products.find(product_id)

      new(**attributes(product))
    end

    private

    def attributes(product)
      product.attributes.deep_symbolize_keys.slice(
        :id,
        :title,
        :summary,
        :url,
        :source_url,
        :released_on,
        :genre_id
      ).merge(
        {
          technology_ids: product.technology_ids,
          user_ids: product.user_ids
        }
      )
    end
  end

  def save
    return false if invalid?

    product.save!
    assign_attributes(id: product.id)
    true
  end

  def update(params)
    assign_attributes(params)
    return false if invalid?

    product.update!(**product_params)
  end

  def to_model
    product
  end

  private

  def product
    @product ||= Product.find_by(id: id) || Product.new(**product_params)
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
