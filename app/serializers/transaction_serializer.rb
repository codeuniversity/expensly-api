class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :name, :cost, :item_count, :created_at

  def item_count
    # object.item_count ||
    object.items.count
  end

  def cost
    # byebug
    # object.cost ||
    object.items.sum('items.price * items.amount')
  end

end
