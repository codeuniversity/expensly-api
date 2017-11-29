class Item < ApplicationRecord
  belongs_to :user
  belongs_to :change, class_name: "Transaction", foreign_key: "transaction_id"
  belongs_to :article

end
