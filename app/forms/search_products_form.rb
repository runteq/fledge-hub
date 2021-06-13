class SearchProductsForm
  include ActiveModel::Model
  include KanaHelper

  attr_accessor :title

  def search
    relation = Product
    relation = search_title(relation) if title.present?
    relation.order(created_at: :desc)
  end

  private

  def search_title(relation)
    like_hiragana = "%#{to_hiragana(title)}%"
    like_katakana = "%#{to_katakana(title)}%"

    relation.where('title LIKE ? or title LIKE ?', like_hiragana, like_katakana)
  end
end
