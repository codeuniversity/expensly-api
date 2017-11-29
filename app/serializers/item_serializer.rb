class ItemSerializer < ActiveModel::Serializer
  attributes :id, :price, :name, :category_name

  def name
    object.article.name
  end
  def category_name
    object.article.category.name
  end

end
