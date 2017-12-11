class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :article_count, :cost

  def article_count
    object.article_count
  rescue
    object.articles.count
  end

  def cost
    object.cost
  rescue
    object.articles.joins(:items).sum('items.price * items.amount')
  end
end
