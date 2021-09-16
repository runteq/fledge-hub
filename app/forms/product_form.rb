class ProductForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :id, :integer
  attribute :title, :string
  attribute :summary, :string
  attribute :url, :string
  attribute :source_url, :string
  attribute :released_on, :date
  attribute :product_category_id, :integer
  attribute :product_type_id, :integer
  attribute :technology_ids, default: []
  attribute :user_ids, default: []
  attribute :media_attributes, default: []

  validates :id, presence: true, if: -> { product.persisted? }
  validates :title, presence: true, length: { maximum: 100 }
  validates :url, url: { allow_blank: true, schemes: %w[https http] }, length: { maximum: 500 }
  validates :source_url, url: { allow_blank: true, schemes: %w[https http] },
                         length: { maximum: 500 }
  validates :released_on, presence: true
  validates :summary, length: { maximum: 500 }
  validates :product_category_id, presence: true
  validates :product_type_id, presence: true
  validates :user_ids, presence: true, if: -> { product.new_record? }
  validate :url_validity
  validate :media_validity

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
        :product_type_id,
        :product_category_id,
      ).merge(
        {
          technology_ids: product.technology_ids,
          user_ids: product.user_ids,
          # #mediaで使うidしか使用しない↓
          media_attributes: product.media.map(&:attributes),
        },
      )
    end
  end

  def save
    return false if invalid?

    save!
    true
  end

  def update(params)
    assign_attributes(params)
    return false if invalid?

    product.assign_attributes(**product_params)
    save!
    true
  end

  def to_model
    product
  end

  def media
    media_attributes.map(&:deep_symbolize_keys).map do |attributes|
      if attributes[:id].present?
        medium = product.media.find(attributes[:id])
        medium.assign_attributes(**attributes.slice(:title, :url))
        medium
      else
        # product.mediaでは取得できないようにする
        ProductMedium.new(**attributes, product: product)
      end
    end
  end

  private

  def save!
    ActiveRecord::Base.transaction(joinable: false, requires_new: true) do
      product.save!
      grab_ogp
      product.media.where.not(id: remained_medium_ids).destroy_all
      media.each(&:save!)
    end
    assign_attributes(id: product.id)
  end

  # 重複を返す
  def remained_medium_ids
    attr_medium_ids = media_attributes.map do |attr|
      attr.deep_symbolize_keys[:id]
    end.reject(&:blank?).map(&:to_i)
    attr_medium_ids & product.media.ids
  end

  def grab_ogp
    product.grab_ogp(URI.parse(ogp_url[:content])) if product.images.empty? && ogp_url
  end

  def ogp_url
    return nil if url.blank?

    agent = ::Mechanize.new
    page = agent.get(url)
    page.at('meta[property="og:image"]')
  end

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
      product_type_id: product_type_id,
      product_category_id: product_category_id,
      technology_ids: technology_ids,
      user_ids: user_ids,
    }
  end

  def url_validity
    ogp_url
  rescue SocketError, Net::OpenTimeout
    errors.add(:url, 'にアクセスできません。')
  end

  def media_validity
    return if errors.any?

    media.select(&:invalid?).flat_map(&:errors).flat_map(&:full_messages).each do |full_message|
      errors.add(:media_attributes, "の#{full_message}")
    end
  end
end
