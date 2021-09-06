class SearchProductsForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include KanaHelper

  attribute :title, :string, default: ''

  def self.search(args)
    new(args).search
  end

  def search
    relation = Product.all
    relation = search_title(relation) if title.present?
    relation
  end

  private

  def search_title(relation)
    like_hiragana = "%#{to_hiragana(title)}%"
    like_katakana = "%#{to_katakana(title)}%"

    relation.where('title LIKE ? or title LIKE ?', like_hiragana, like_katakana)
  end
end
