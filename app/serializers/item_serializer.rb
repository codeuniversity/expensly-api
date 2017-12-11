class ItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :name, :amount, :cost, :created_at
  belongs_to :category
  belongs_to :transaction
  belongs_to :article
  def transaction
    object.change
  end
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
