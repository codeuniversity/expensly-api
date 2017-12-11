class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :item_count
  belongs_to :category

  def cost
    object.cost
  rescue
    object.items.sum('items.price * items.amount')
  end

  def item_count
    object.item_count
  rescue
    object.items.count
  end
end
