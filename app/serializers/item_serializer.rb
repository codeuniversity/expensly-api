class ItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :name, :amount, :cost
  belongs_to :category
  def name
    object.article.name
  end

  def cost
    object.price * object.amount
  end

  def category_name
    object.article.category.name
  end
  def category
    object.article.category
  end
end
