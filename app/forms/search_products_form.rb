class SearchProductsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include KanaHelper

  attribute :title, :string, default: ''
  attribute :product_type_id, :integer, default: ''
  attribute :product_category_id, :string, default: ''

  def self.search(args)
    new(args).search
  end

  def search
    relation = Product.all
    relation = search_title(relation) if title.present?
    relation = search_product_type(relation) if product_type_id.present?
    relation = search_product_category(relation) if product_category_id.present?
    relation
  end

  private

  def search_title(relation)
    like_hiragana = "%#{to_hiragana(title)}%"
    like_katakana = "%#{to_katakana(title)}%"

    relation.where('title LIKE ? or title LIKE ?', like_hiragana, like_katakana)
  end

  def search_product_type(relation)
    relation.where(product_type_id: product_type_id)
  end

  def search_product_category(relation)
    relation.where(product_category_id: product_category_id)
  end
end
