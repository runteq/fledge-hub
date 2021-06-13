class SearchProductsForm
  include ActiveModel::Model

  attr_accessor :title

  def search
    relation = Product
    relation = relation.where('title LIKE ?', "%#{title}%") if title.present?
    relation.order(created_at: :desc)
  end
end
